-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config = {
    automatically_reload_config = true,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    window_close_confirmation = "NeverPrompt",
    window_decorations = "RESIZE", -- disable the title bar but enable resizable border
    default_cursor_style = "BlinkingUnderline",
    font = wezterm.font("Liga SFMono Nerd Font", {weight="Regular", stretch="Normal", style="Normal"}),
    font_size = 14,
    window_background_opacity = 0.9,
    color_scheme = 'bearded-arc',
    color_schemes = {
      ["bearded-arc"] = {
        foreground = "#d0d7e4",
        background = "#1a2130",
        cursor_bg = "#ead18c",
        cursor_fg = "#1a2130",
        cursor_border = "#ead18c",
        selection_fg = "#1a2130",
        selection_bg = "#d0d7e4",
        ansi = {
          "#1c2433", -- Ansi 0 (Black)
          "#e35555", -- Ansi 1 (Red)
          "#77e88f", -- Ansi 2 (Green)
          "#eacd61", -- Ansi 3 (Yellow)
          "#69c3ff", -- Ansi 4 (Blue)
          "#f38cf3", -- Ansi 5 (Magenta)
          "#22ecec", -- Ansi 6 (Cyan)
          "#d0d7e4", -- Ansi 7 (White)
        },
        brights = {
          "#3e4f71", -- Ansi 8 (Bright Black)
          "#ff4343", -- Ansi 9 (Bright Red)
          "#7afb8f", -- Ansi 10 (Bright Green)
          "#ffd94c", -- Ansi 11 (Bright Yellow)
          "#69c3ff", -- Ansi 12 (Bright Blue)
          "#ff80ff", -- Ansi 13 (Bright Magenta)
          "#0fffec", -- Ansi 14 (Bright Cyan)
          "#ffffff", -- Ansi 15 (Bright White)
        },
        indexed = {
          [16] = "#ead18c", -- Cursor Color
          [17] = "#d6d6d6", -- Bold Color
          [18] = "#69c3ff", -- Link Color
        },
      },
  },

    background = {
        {
          source = {
            File = "/Users/sam/wallpapers/macos-monterey.jpg",
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