-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config = {
    automatically_reload_config = true,
    enable_tab_bar = false,
    window_close_confirmation = "NeverPrompt",
    window_decorations = "RESIZE", -- disable the title bar but enable resizable border
    default_cursor_style = "BlinkingUnderline",
    font = wezterm.font("Liga SFMono Nerd Font", {weight="Regular", stretch="Normal", style="Normal"}),
    font_size = 14,
    window_background_opacity = 0.9,
    color_scheme = 'Palenight (Gogh)',
    background = {
        {
          source = {
            File = "/Users/samhamer/Library/Mobile Documents/com~apple~CloudDocs/Mac_Wallpapers/macos-monterey.jpg",
          },
          hsb = {
            hue = 1.0,
            saturation = 1.02,
            brightness = 0.25,
          },
        },
        {
          source = {
            Color = "#282c35",
          },
          width = "100%",
          height = "100%",
          opacity = 0.55,
        },
      },
}

-- and finally, return the configuration to wezterm
return config