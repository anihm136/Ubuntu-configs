local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local awesome, client, os = awesome, client, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
require("pl.stringx").import()

local theme = {}
theme.dir = gears.filesystem.get_configuration_dir() .. "theme"
theme.wallpaper = theme.dir .. "/wall.jpg"
theme.font = "Overpass 13"
theme.taglist_font = "Kimberley Bl 11"
theme.fg_normal = "#BBBBBB"
theme.fg_focus = "#78A4FF"
theme.bg_normal = "#222222"
theme.bg_focus = "#222222"
theme.fg_urgent = "#000000"
theme.bg_urgent = "#FFFFFF"
theme.border_width = dpi(1)
theme.border_normal = "#111111"
theme.border_focus = "#93B6FF"
theme.taglist_fg_focus = "#FFFFFF"
theme.taglist_bg_focus = "#222222"
theme.taglist_bg_normal = "#222222"
theme.titlebar_bg_normal = "#191919"
theme.titlebar_bg_focus = "#262626"
theme.tooltip_bg = "#222222"
theme.tooltip_fg = "#BBBBBB"
theme.tooltip_font = "Overpass 8"
theme.menu_height = dpi(20)
theme.menu_width = dpi(250)
theme.tasklist_disable_icon = true
theme.awesome_icon = theme.dir .. "/icons/awesome.png"
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel = theme.dir .. "/icons/square_unsel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"
theme.vol = theme.dir .. "/icons/vol.png"
theme.vol_low = theme.dir .. "/icons/vol_low.png"
theme.vol_no = theme.dir .. "/icons/vol_no.png"
theme.vol_mute = theme.dir .. "/icons/vol_mute.png"
theme.disk = theme.dir .. "/icons/disk.png"
theme.ac = theme.dir .. "/icons/ac.png"
theme.bat = theme.dir .. "/icons/bat.png"
theme.bat_low = theme.dir .. "/icons/bat_low.png"
theme.bat_no = theme.dir .. "/icons/bat_no.png"
theme.play = theme.dir .. "/icons/play.png"
theme.pause = theme.dir .. "/icons/pause.png"
theme.stop = theme.dir .. "/icons/stop.png"
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv = theme.dir .. "/icons/fairv.png"
theme.layout_fairh = theme.dir .. "/icons/fairh.png"
theme.layout_spiral = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle = theme.dir .. "/icons/dwindle.png"
theme.layout_max = theme.dir .. "/icons/max.png"
theme.layout_fullscreen = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.dir .. "/icons/magnifier.png"
theme.layout_floating = theme.dir .. "/icons/floating.png"
theme.useless_gap = 6
theme.layout_centerfair = theme.dir .. "/icons/centerfair.png"
theme.layout_termfair = theme.dir .. "/icons/termfair.png"
theme.layout_centerwork = theme.dir .. "/icons/centerwork.png"
theme.icon_theme = "candy-icons"

local markup = lain.util.markup
local blue = theme.fg_focus
local red = "#EB8F8F"
local green = "#8FEB8F"

-- Textclock
local mytextclock = wibox.widget.textclock("<span> %I:%M:%S </span>", 1)
mytextclock.font = "Kimberley Bl 11"
mytextclock.forced_width = 70

-- Calendar
theme.cal =
    lain.widget.cal(
    {
        attach_to = {mytextclock},
        notification_preset = {
            title = "",
            icon_size = 32,
            margin = 5,
            font = "Overpass Mono 9",
            fg = theme.fg_normal,
            bg = theme.bg_normal
        }
    }
)

-- /home fs
local fsicon = wibox.widget.imagebox(theme.disk)
local fsbar =
    wibox.widget {
    forced_height = dpi(1),
    forced_width = dpi(59),
    color = theme.fg_normal,
    background_color = theme.bg_normal,
    margins = 1,
    paddings = 1,
    ticks = true,
    ticks_size = dpi(6),
    widget = wibox.widget.progressbar
}
theme.fs =
    lain.widget.fs {
    notification_preset = {fg = theme.fg_normal, bg = theme.bg_normal, font = "Overpass Mono 10.5"},
    settings = function()
        if fs_now["/"].percentage < 90 then
            fsbar:set_color(theme.fg_normal)
        else
            fsbar:set_color("#EB8F8F")
        end
        fsbar:set_value(fs_now["/"].percentage / 100)
    end
}
local fsbg = wibox.container.background(fsbar, "#474747", gears.shape.rectangle)
local fswidget = wibox.container.margin(fsbg, dpi(2), dpi(7), dpi(4), dpi(4))
--]]

-- ALSA volume bar
local volicon = wibox.widget.imagebox(theme.vol)
theme.volume =
    lain.widget.alsabar {
    width = dpi(59),
    border_width = 0,
    ticks = true,
    ticks_size = dpi(6),
    notification_preset = {font = theme.font},
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.vol_mute)
        elseif volume_now.level == 0 then
            volicon:set_image(theme.vol_no)
        elseif volume_now.level <= 50 then
            volicon:set_image(theme.vol_low)
        else
            volicon:set_image(theme.vol)
        end
    end,
    colors = {
        background = theme.bg_normal,
        mute = red,
        unmute = theme.fg_normal
    }
}
theme.volume.tooltip.fg = theme.tooltip_fg
theme.volume.tooltip.bg = theme.tooltip_bg
theme.volume.tooltip.font = theme.tooltip_font

theme.volume.bar:buttons(
    my_table.join(
        awful.button(
            {},
            1,
            function()
                os.execute(string.format("%s -e alsamixer", awful.terminal))
            end
        ),
        awful.button(
            {},
            2,
            function()
                os.execute(string.format("%s set %s 100%%", theme.volume.cmd, theme.volume.channel))
                theme.volume.update()
            end
        ),
        awful.button(
            {},
            3,
            function()
                os.execute(
                    string.format(
                        "%s set %s toggle",
                        theme.volume.cmd,
                        theme.volume.togglechannel or theme.volume.channel
                    )
                )
                theme.volume.update()
            end
        ),
        awful.button(
            {},
            4,
            function()
                os.execute(string.format("%s set %s 1%%+", theme.volume.cmd, theme.volume.channel))
                theme.volume.update()
            end
        ),
        awful.button(
            {},
            5,
            function()
                os.execute(string.format("%s set %s 1%%-", theme.volume.cmd, theme.volume.channel))
                theme.volume.update()
            end
        )
    )
)
local volumebg = wibox.container.background(theme.volume.bar, "#474747", gears.shape.rectangle)
local volumewidget = wibox.container.margin(volumebg, dpi(2), dpi(7), dpi(4), dpi(4))

-- Cmus widget
-- local cmus, cmus_timer = awful.widget.watch(
--     "cmus-remote -Q",
--     1,
--     function(widget, stdout)
--         local cmus_now = {
--             state   = "N/A",
--             artist  = "N/A",
--             title   = "N/A",
--             album   = "N/A"
--         }
--
--         for w in string.gmatch(stdout, "(.-)tag") do
--             a, b = w:match("(%w+) (.*)\n")
--             cmus_now[a] = b
--         end
--
--         if string.match(stdout, "tag title (.+)\n") then
--             cmus_now["title"] = string.match(stdout, "tag title (.+)\n")
--         end
--         if string.match(stdout, "status (%a+)\n") then
--             cmus_now["state"] = string.match(stdout, "status (%a+)")
--         end
--
--         -- customize here
--         local wistring = " " .. cmus_now.artist .. " - " .. cmus_now.title .. " "
--         if cmus_now.state == "paused" then
--             wistring = " ⏸ " .. wistring
--         elseif cmus_now.state == "playing" then
--             wistring = " ▶ " .. wistring
--         elseif cmus_now.state == "stopped" then
--             wistring = " ■ " .. wistring
--         end
--         widget:set_text(wistring)
--     end
--     )

-- MOCP widget
local mocp, mocp_timer =
    awful.widget.watch(
    "mocp -i",
    1,
    function(widget, stdout)
        local mocp_now = {
            state = "N/A",
            artist = "N/A",
            title = "N/A",
            album = "N/A",
            cur_time = "`",
            tot_time = "`"
        }

        if string.match(stdout, "SongTitle: ([^\n]+)\n") then
            mocp_now["title"] = string.match(stdout, "SongTitle: ([^\n]+)\n")
        end
        if string.match(stdout, "State: (%a+)") then
            mocp_now["state"] = string.match(stdout, "State: (%a+)")
        end
        if string.match(stdout, "Artist: ([^\n]+)\n") then
            mocp_now["artist"] = string.match(stdout, "Artist: ([^\n]+)\n")
        end
        if string.match(stdout, "CurrentTime: ([%d%p ]+)\n") then
            mocp_now["cur_time"] = string.match(stdout, "CurrentTime: ([%d%p ]+)")
        end
        if string.match(stdout, "TotalTime: ([%d%p ]+)\n") then
            mocp_now["tot_time"] = string.match(stdout, "TotalTime: ([%d%p ]+)")
        end

        -- customize here
        local total_length = #mocp_now.artist + #mocp_now.title
        local percent = 40 / total_length

        local max_artist = math.floor(#mocp_now.artist * percent)
        local max_title = math.floor(#mocp_now.title * percent)

        local info_string = " " .. mocp_now.artist .. " - " .. mocp_now.title

        local wistring =
            " " ..
            mocp_now.artist:shorten(max_artist) ..
                " - " ..
                    mocp_now.title:shorten(max_title) .. "   " .. mocp_now.cur_time .. " [" .. mocp_now.tot_time .. "] "
        if mocp_now.state == "PAUSE" then
            wistring = " ⏸ " .. wistring
        elseif mocp_now.state == "PLAY" then
            wistring = " ▶ " .. wistring
        elseif mocp_now.state == "STOP" then
            wistring = " ■ " .. wistring
        end
        widget:set_font("Overpass 9")
        widget:set_text(wistring)
        widget.info_string = info_string
    end
)
local music_tooltip = awful.tooltip { 
    bg=theme.tooltip_bg,
    fg=theme.tooltip_fg,
    font=theme.tooltip_font
}

music_tooltip:add_to_object(mocp)

mocp:connect_signal(
    "mouse::enter",
    function()
        music_tooltip.text = mocp.info_string
    end
)

-- Separators
local first = wibox.widget.textbox(markup.font("Overpass Mono 3", " "))
local spr = wibox.widget.textbox(" ")
local small_spr = wibox.widget.textbox(markup.font("Overpass Mono 4", " "))
local bar_spr =
    wibox.widget.textbox(
    markup.font("Overpass Mono 3", " ") ..
        markup.fontfg(theme.font, "#777777", "|") .. markup.font("Overpass Mono 5", " ")
)

-- Eminent-like task filtering
local orig_filter = awful.widget.taglist.filter.all

-- Taglist label functions
awful.widget.taglist.filter.all = function(t, args)
    if t.selected or #t:clients() > 0 then
        return orig_filter(t, args)
    end
end

-- Import tag settings
-- local tags = require("tags")

function theme.at_screen_connect(s)
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[2])
    -- for i, tag in pairs(tags) do
    --     awful.tag.add(
    --         i,
    --         {
    --             icon = tag.icon,
    --             icon_only = true,
    --             layout = awful.layout.suit.tile,
    --             screen = s,
    --             selected = i == 1
    --         }
    --     )
    -- end

    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(
        my_table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                2,
                function()
                    awful.layout.set(awful.layout.layouts[1])
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                {},
                4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                5,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox =
        awful.wibar({position = "top", screen = s, height = dpi(24), bg = theme.bg_normal, fg = theme.fg_normal})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            small_spr,
            s.mylayoutbox,
            first,
            bar_spr,
            s.mytaglist,
            first,
            s.mypromptbox
        },
        s.mytasklist, -- Middle widget
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            bar_spr,
            mocp,
            bar_spr,
            fsicon,
            fswidget,
            bar_spr,
            volicon,
            volumewidget,
            bar_spr,
            mytextclock
        }
    }
end

return theme
