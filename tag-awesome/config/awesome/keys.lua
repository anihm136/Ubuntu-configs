local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local my_table = gears.table
local machi = require("layout-machi")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local modkey = "Mod4"
local altkey = "Mod1"

local keys = {}

-- ===================================================================
-- Movement Functions (Called by some keybinds)
-- ===================================================================

-- Move given client to given direction
local function move_client(c, direction)
    -- If client is floating, move to edge
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        -- Otherwise swap the client in the tiled layout
        local workarea = awful.screen.focused().workarea
        if direction == "up" then
            c:geometry({nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil})
        elseif direction == "down" then
            c:geometry(
                {
                    nil,
                    y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 -
                        beautiful.border_width * 2,
                    nil,
                    nil
                }
            )
        elseif direction == "left" then
            c:geometry({x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil})
        elseif direction == "right" then
            c:geometry(
                {
                    x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 -
                        beautiful.border_width * 2,
                    nil,
                    nil,
                    nil
                }
            )
        end
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
        if direction == "up" or direction == "left" then
            awful.client.swap.byidx(-1, c)
        elseif direction == "down" or direction == "right" then
            awful.client.swap.byidx(1, c)
        end
    else
        awful.client.swap.bydirection(direction, c, nil)
    end
end

-- Resize client in given direction
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.05

local function resize_client(c, direction)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
        if direction == "up" then
            c:relative_move(0, 0, 0, -floating_resize_amount)
        elseif direction == "down" then
            c:relative_move(0, 0, 0, floating_resize_amount)
        elseif direction == "left" then
            c:relative_move(0, 0, -floating_resize_amount, 0)
        elseif direction == "right" then
            c:relative_move(0, 0, floating_resize_amount, 0)
        end
    else
        if direction == "up" then
            awful.client.incwfact(-tiling_resize_factor)
        elseif direction == "down" then
            awful.client.incwfact(tiling_resize_factor)
        elseif direction == "left" then
            awful.tag.incmwfact(-tiling_resize_factor)
        elseif direction == "right" then
            awful.tag.incmwfact(tiling_resize_factor)
        end
    end
end

-- raise focused client
local function raise_client()
    if client.focus then
        client.focus:raise()
    end
end

-- Toggle sticky floating window
local function sticky_float(c)
    awful.client.floating.toggle()
    if c.floating then
        c.ontop=true
        c.sticky=true
        c.width=533
        c.height=300
        awful.placement.top_right(client.focus)
    else
        c.ontop=false
        c.sticky=false
    end
end

-- ===================================================================
-- Mouse bindings
-- ===================================================================

-- Mouse buttons on the desktop
keys.desktopbuttons =
    my_table.join(
    -- left click on desktop to hide notification
    awful.button(
        {},
        1,
        function()
            naughty.destroy_all_notifications()
        end
    )
)

-- Mouse buttons on the client
keys.clientbuttons =
    gears.table.join(
    -- Raise client
    awful.button(
        {},
        1,
        function(c)
            client.focus = c
            c:raise()
        end
    ),
    -- Move and Resize Client
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize)
)

awful.util.taglist_buttons =
    my_table.join(
    awful.button(
        {},
        1,
        function(t)
            t:view_only()
        end
    ),
    awful.button(
        {},
        4,
        function(t)
            awful.tag.viewnext(t.screen)
        end
    ),
    awful.button(
        {},
        5,
        function(t)
            awful.tag.viewprev(t.screen)
        end
    )
)

awful.util.tasklist_buttons = my_table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() and c.first_tag then
        c.first_tag:view_only()
      end
      -- This will also un-minimize
      -- the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
  awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
  )

-- ===================================================================
-- Desktop Key bindings
-- ===================================================================

keys.globalkeys =
    my_table.join(
    -- =========================================
    -- RELOAD / QUIT AWESOME
    -- =========================================

    -- Reload Awesome
    awful.key({modkey, "Shift"}, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
    -- Quit Awesome
    awful.key({modkey, "Shift"}, "e", awesome.quit, {description = "quit awesome", group = "awesome"}),
    -- Show help
    awful.key({modkey}, 's', hotkeys_popup.show_help, {description = 'show help', group = 'awesome'}),
    -- =========================================
    -- CLIENT FOCUSING
    -- =========================================

    -- Focus client by direction (hjkl keys)
    awful.key(
        {modkey},
        "j",
        function()
            awful.client.focus.bydirection("down")
            raise_client()
        end,
        {description = "focus down", group = "client"}
    ),
    awful.key(
        {modkey},
        "k",
        function()
            awful.client.focus.bydirection("up")
            raise_client()
        end,
        {description = "focus up", group = "client"}
    ),
    awful.key(
        {modkey},
        "h",
        function()
            awful.client.focus.bydirection("left")
            raise_client()
        end,
        {description = "focus left", group = "client"}
    ),
    awful.key(
        {modkey},
        "l",
        function()
            awful.client.focus.bydirection("right")
            raise_client()
        end,
        {description = "focus right", group = "client"}
    ),
    -- Focus client by direction (arrow keys)
    awful.key(
        {modkey},
        "Down",
        function()
            awful.client.focus.bydirection("down")
            raise_client()
        end,
        {description = "focus down", group = "client"}
    ),
    awful.key(
        {modkey},
        "Up",
        function()
            awful.client.focus.bydirection("up")
            raise_client()
        end,
        {description = "focus up", group = "client"}
    ),
    awful.key(
        {modkey},
        "Left",
        function()
            awful.client.focus.bydirection("left")
            raise_client()
        end,
        {description = "focus left", group = "client"}
    ),
    awful.key(
        {modkey},
        "Right",
        function()
            awful.client.focus.bydirection("right")
            raise_client()
        end,
        {description = "focus right", group = "client"}
    ),
    -- Focus client by index (history)
    awful.key({modkey}, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = "client"}),
    awful.key(
        {modkey},
        "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}
    ),
    awful.key({modkey}, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"}),
    -- Show/Hide Wibox
    awful.key(
        {modkey, "Shift"},
        "b",
        function()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle top wibar", group = "awesome"}
    ),
    -- =========================================
    -- CLIENT RESIZING
    -- =========================================

    awful.key(
        {modkey, "Control"},
        "Down",
        function(c)
            resize_client(client.focus, "down")
        end
    ),
    awful.key(
        {modkey, "Control"},
        "Up",
        function(c)
            resize_client(client.focus, "up")
        end
    ),
    awful.key(
        {modkey, "Control"},
        "Left",
        function(c)
            resize_client(client.focus, "left")
        end
    ),
    awful.key(
        {modkey, "Control"},
        "Right",
        function(c)
            resize_client(client.focus, "right")
        end
    ),
    awful.key(
        {modkey, "Control"},
        "j",
        function(c)
            resize_client(client.focus, "down")
        end
    ),
    awful.key(
        {modkey, "Control"},
        "k",
        function(c)
            resize_client(client.focus, "up")
        end
    ),
    awful.key(
        {modkey, "Control"},
        "h",
        function(c)
            resize_client(client.focus, "left")
        end
    ),
    awful.key(
        {modkey, "Control"},
        "l",
        function(c)
            resize_client(client.focus, "right")
        end
    ),
    -- =========================================
    -- NUMBER OF MASTER / COLUMN CLIENTS
    -- =========================================

    -- Number of master clients
    awful.key(
        {modkey, altkey},
        "h",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key(
        {modkey, altkey},
        "l",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}
    ),
    awful.key(
        {modkey, altkey},
        "Left",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key(
        {modkey, altkey},
        "Right",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}
    ),
    -- Number of columns
    awful.key(
        {modkey, altkey},
        "k",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key(
        {modkey, altkey},
        "j",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}
    ),
    awful.key(
        {modkey, altkey},
        "Up",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key(
        {modkey, altkey},
        "Down",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}
    ),
    -- =========================================
    -- GAP CONTROL
    -- =========================================

    -- Gap control
    awful.key(
        {modkey, "Shift"},
        "minus",
        function()
            awful.tag.incgap(5, nil)
        end,
        {description = "increment gaps size for the current tag", group = "gaps"}
    ),
    awful.key(
        {modkey},
        "minus",
        function()
            awful.tag.incgap(-5, nil)
        end,
        {description = "decrement gap size for the current tag", group = "gaps"}
    ),
    -- =========================================
    -- LAYOUT SELECTION
    -- =========================================

    -- select next layout
    awful.key(
        {modkey},
        "space",
        function()
            awful.layout.inc(1)
        end,
        {description = "select next", group = "layout"}
    ),
    -- select previous layout
    awful.key(
        {modkey, "Shift"},
        "space",
        function()
            awful.layout.inc(-1)
        end,
        {description = "select previous", group = "layout"}
    ),
    -- =========================================
    -- CLIENT MINIMIZATION
    -- =========================================

    -- restore minimized client
    awful.key(
        {modkey, "Shift"},
        "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}
    ),
    -- Copy primary to clipboard (terminals to gtk)
    awful.key(
        {modkey},
        "c",
        function()
            awful.spawn.with_shell("xsel | xsel -i -b")
        end,
        {description = "copy terminal to gtk", group = "hotkeys"}
    ),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key(
        {modkey},
        "v",
        function()
            awful.spawn.with_shell("xsel -b | xsel")
        end,
        {description = "copy gtk to terminal", group = "hotkeys"}
    ),
    -- machi layout special keybindings
    awful.key(
        {modkey},
        ".",
        function()
            machi.default_editor.start_interactive()
        end,
        {description = "machi: edit the current machi layout", group = "layout"}
    ),
    awful.key(
        {modkey},
        "/",
        function()
            machi.switcher.start(client.focus)
        end,
        {description = "switch between windows for a machi layout", group = "layout"}
    )
)

-- ===================================================================
-- Client Key bindings
-- ===================================================================

keys.clientkeys =
    gears.table.join(
    -- Move to edge or swap by direction
    awful.key(
        {modkey, "Shift"},
        "Down",
        function(c)
            move_client(c, "down")
        end
    ),
    awful.key(
        {modkey, "Shift"},
        "Up",
        function(c)
            move_client(c, "up")
        end
    ),
    awful.key(
        {modkey, "Shift"},
        "Left",
        function(c)
            move_client(c, "left")
        end
    ),
    awful.key(
        {modkey, "Shift"},
        "Right",
        function(c)
            move_client(c, "right")
        end
    ),
    awful.key(
        {modkey, "Shift"},
        "j",
        function(c)
            move_client(c, "down")
        end
    ),
    awful.key(
        {modkey, "Shift"},
        "k",
        function(c)
            move_client(c, "up")
        end
    ),
    awful.key(
        {modkey, "Shift"},
        "h",
        function(c)
            move_client(c, "left")
        end
    ),
    awful.key(
        {modkey, "Shift"},
        "l",
        function(c)
            move_client(c, "right")
        end
    ),
    awful.key(
        {modkey, "Control"},
        "space",
        awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}
    ),
    awful.key(
        {modkey, altkey},
        "space",
        sticky_float,
        {description = "toggle sticky floating", group = "client"}
    ),
    awful.key(
        {modkey, "Shift"},
        "c",
        awful.placement.centered,
        {description = "center floating client", group = "client"}
    ),
    awful.key(
        {modkey, "Control"},
        "Return",
        function(c)
            c:swap(awful.client.getmaster())
        end,
        {description = "move to master", group = "client"}
    ),
    -- toggle fullscreen
    awful.key(
        {modkey},
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    -- close client
    awful.key(
        {modkey},
        "q",
        function(c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),
    -- Minimize
    awful.key(
        {modkey},
        "n",
        function(c)
            c.minimized = true
        end,
        {description = "minimize", group = "client"}
    ),
    -- Maximize
    awful.key(
        {modkey},
        "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
    )
)

-- Bind all key numbers to tags
for i = 1, 9 do
    keys.globalkeys =
        gears.table.join(
        keys.globalkeys,
        -- Switch to tag
        awful.key(
            {modkey},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #" .. i, group = "tag"}
        ),
        -- Move client to tag
        awful.key(
            {modkey, "Shift"},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #" .. i, group = "tag"}
        )
    )
end

return keys
