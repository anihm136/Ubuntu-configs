local awful = require("awful")
local beautiful = require("beautiful")

-- define screen height and width
local screen_height = awful.screen.focused().geometry.height
local screen_width = awful.screen.focused().geometry.width

-- define module table
local rules = {}

-- ===================================================================
-- Rules
-- ===================================================================

-- return a table of client rules including provided keys / buttons
function rules.create(clientkeys, clientbuttons)
    return {
        -- All clients will match this rule.
        {
            rule = {},
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = clientkeys,
                buttons = clientbuttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap + awful.placement.no_offscreen,
                size_hints_honor = false,
                maximized = false,
                maximized_horizontal = false,
                maximized_vertical = false,
                callback = function(c)
                    if (c.floating) then
                        awful.placement.centered(c)
                    end
                end
            }
        },
        -- Titlebars
        {
            rule_any = {type = {"dialog", "normal"}},
            properties = {titlebars_enabled = false}
        },
        -- Set Firefox to always map on the first tag on screen 1.
        {
            rule_any = {class = {"Firefox", "Brave-browser"}},
            properties = {screen = 1, tag = awful.util.tagnames[4]}
        },
        {
            rule = {class = "Code"},
            properties = {screen = 1, tag = awful.util.tagnames[3]}
        },
        {
            rule_any = {class = {"Thunderbird", "Station", "Ferdi"}},
            properties = {screen = 1, tag = awful.util.tagnames[5]}
        },
        {
            rule = {class = "Emacs"},
            properties = {screen = 1, tag = awful.util.tagnames[7]}
        },
        -- Floating clients.
        {
            rule_any = {
                instance = {
                    "DTA",
                    "copyq"
                },
                class = {
                    "Nm-connection-editor"
                },
                name = {
                    "Event Tester",
                    "Steam Guard - Computer Authorization Required"
                },
                role = {
                    "pop-up",
                    "GtkFileChooserDialog"
                },
                type = {
                    "dialog"
                }
            },
            properties = {floating = true}
        },
        -- Rofi
        {
            rule_any = {name = {"rofi"}},
            properties = {maximized = true, ontop = true}
        },
        -- File chooser dialog
        {
            rule_any = {role = {"GtkFileChooserDialog"}},
            properties = {floating = true, width = screen_width * 0.55, height = screen_height * 0.65}
        },
        -- Pavucontrol & Bluetooth Devices
        {
            rule_any = {class = {"Pavucontrol"}, name = {"Bluetooth Devices"}},
            properties = {floating = true, width = screen_width * 0.55, height = screen_height * 0.45}
        }
    }
end

-- return module table
return rules
