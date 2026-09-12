---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal        = "ghostty"
local fileManager     = "dolphin"
local menu            = "rofi -show drun"
local browser         = "zen-browser"
local passwordManager = "bitwarden-desktop"
local editor          = "zeditor"
local notes           = "obsidian"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod         = "SUPER"
local secondMod       = "SUPER + SHIFT"
local hyperMod        = "CTRL + SUPER + ALT"

-- Launch Applications
-- hl.bind("ALT" .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(hyperMod .. " + T", hl.dsp.exec_cmd(terminal), { description = "Open Terminal" })
hl.bind(hyperMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(hyperMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(hyperMod .. " + C", hl.dsp.exec_cmd(editor))
hl.bind(hyperMod .. " + D", hl.dsp.exec_cmd("discord"))
hl.bind(hyperMod .. " + slash", hl.dsp.exec_cmd(passwordManager))
hl.bind(hyperMod .. " + N", hl.dsp.exec_cmd(notes))

-- Global Application Keybinds
hl.bind("CTRL + SHIFT + M", hl.dsp.pass({ window = "class:^(discord)$" }), { description = "Toggle Discord mute" })
hl.bind("CTRL + SHIFT + D", hl.dsp.pass({ window = "class:^(discord)$" }), { description = "Toggle Discord deafen" })
hl.bind("CTRL + SHIFT + B", hl.dsp.pass({ window = "class:^(discord)$" }), { description = "Toggle Discord soundboard" })

-- Window Management
hl.bind(secondMod .. " + ESCAPE",
    hl.dsp.exec_cmd("wlogout -b 2 -s -L 1200 -R 1200 -T 700 -B 700"))
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + C", hl.dsp.window.center())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("pkill waybar; waybar &"))

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
--     { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
--     { locked = true, repeating = true })
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
--     { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
--     { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
-- hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
-- hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
-- hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
