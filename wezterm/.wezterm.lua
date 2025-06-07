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
    color_scheme = 'anysphere',
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
      ["anysphere"] = {
        -- The default text color
        foreground = "#D6D6DD",
        -- The default background color
        background = "#181818",

        -- Overrides the cell background color when the current cell is occupied by the
        -- cursor and the cursor style is set to Block
        cursor_bg = "#D6D6DD",
        -- Overrides the text color when the current cell is occupied by the cursor
        cursor_fg = "#181818",
        -- Specifies the border color of the cursor when the cursor style is set to Block,
        -- or the color of the vertical or horizontal bar when the cursor style is set to
        -- Bar or Underline.
        cursor_border = "#D6D6DD",

        -- the foreground color of selected text
        selection_fg = "#D6D6DD",
        -- the background color of selected text
        selection_bg = "#163761",

        -- Colors for search matches
        -- search_bar_fg = "#D6D6DD",
        -- search_bar_bg = "#4F4F82",

        -- The color of the scrollbar "thumb"; the portion that represents the current viewport
        scrollbar_thumb = "#737373",

        -- The color of the split lines between panes
        split = "#737373",

        ansi = {
          "#181818", -- black
          "#FF6767", -- red
          "#68E868", -- green
          "#EBC88D", -- yellow
          "#94C1FA", -- blue
          "#E394DC", -- magenta
          "#83D6C5", -- cyan
          "#D6D6DD", -- white
        },
        brights = {
          "#6D6D6D", -- bright black
          "#FFB3B3", -- bright red
          "#6AE96A", -- bright green
          "#F8C762", -- bright yellow
          "#C7C7FF", -- bright blue
          "#FDA5FF", -- bright magenta
          "#82D2CE", -- bright cyan
          "#FFFFFF", -- bright white
        },

        -- Colors for copy_mode and quick_select
        -- available since: 20220807-113146-c2fee766
        -- In copy_mode, the color of the active text selection
        copy_mode_active_highlight_bg = { Color = "#163761" },
        -- In copy_mode, the color of inactive text selections
        copy_mode_inactive_highlight_bg = { Color = "#292929" },
        -- The color of the quick select labels
        quick_select_label_bg = { Color = "#163761" },
        -- The color of the quick select label text
        quick_select_label_fg = { Color = "#D6D6DD" },
      },
  },

    background = {
        {
          source = {
            File = wezterm.home_dir .. "/.config/wallpapers/macos-monterey.jpg",
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