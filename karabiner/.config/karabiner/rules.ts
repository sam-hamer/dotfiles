import fs from "fs";
import { KarabinerRules } from "./types";
import { createHyperSubLayers, app, open, rectangle, shell } from "./utils";

const rules: KarabinerRules[] = [
  // External keyboard with firmware-level Hyper key
  {
    description: "External Keyboard - Hyper Key (⌃⌥⇧⌘)",
    manipulators: [
      {
        description: "Hyper Key Variable (External)",
        from: {
          simultaneous: [
            { key_code: "left_command" },
            { key_code: "left_control" },
            { key_code: "left_option" },
            { key_code: "left_shift" },
          ],
        },
        to: [
          {
            set_variable: {
              name: "hyper",
              value: 1,
            },
          },
        ],
        to_after_key_up: [
          {
            set_variable: {
              name: "hyper",
              value: 0,
            },
          },
        ],
        type: "basic",
        conditions: [
          {
            type: "device_if",
            identifiers: [
              {
                vendor_id: 7504,
                product_id: 24926,
              },
            ],
          },
        ],
      },
    ],
  },
  // Laptop keyboard with Caps Lock to Hyper
  {
    description: "Laptop Keyboard - Hyper Key (Caps Lock)",
    manipulators: [
      {
        description: "Caps Lock -> Hyper Key",
        from: {
          key_code: "caps_lock",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            set_variable: {
              name: "hyper",
              value: 1,
            },
          },
        ],
        to_after_key_up: [
          {
            set_variable: {
              name: "hyper",
              value: 0,
            },
          },
        ],
        to_if_alone: [
          {
            key_code: "escape",
          },
        ],
        type: "basic",
        conditions: [
          {
            type: "device_unless",
            identifiers: [
              {
                vendor_id: 7504,
                product_id: 24926,
              },
            ],
          },
        ],
      },
    ],
  },
  ...createHyperSubLayers({
    spacebar: open("raycast://extensions/doist/todoist/create-task"),
    // b = "B"rowse
    b: {
      y: open("https://www.youtube.com"),
      r: open("https://www.reddit.com"),
      g: open("https://github.com/sam-hamer"),
    },
    // o = "Open" applications
    o: {
      1: app("1Password"),
      g: app("Google Chrome"),
      c: app("Cursor"),
      d: app("Discord"),
      t: app("Wezterm"),
      f: app("Finder"),
      // "i"Message
      i: app("Messages"),
      a: app("Arc"),
      b: app("Zen Browser"),
      p: app("Music"),
      m: app("Mail"),
      n: app("Obsidian"),
      w: app("TickTick"),
    },

    // TODO: This doesn't quite work yet.
    // l = "Layouts" via Raycast's custom window management
    // l: {
    //   // Coding layout
    //   c: shell`
    //     open -a "Visual Studio Code.app"
    //     sleep 0.2
    //     open -g "raycast://customWindowManagementCommand?position=topLeft&relativeWidth=0.5"

    //     open -a "Terminal.app"
    //     sleep 0.2
    //     open -g "raycast://customWindowManagementCommand?position=topRight&relativeWidth=0.5"
    //   `,
    // },

    // w = "Window" via rectangle.app
    w: {
      semicolon: {
        description: "Window: Hide",
        to: [
          {
            key_code: "h",
            modifiers: ["right_command"],
          },
        ],
      },
      y: open(
        "-g raycast://extensions/raycast/window-management/previous-display"
      ),
      o: open("-g raycast://extensions/raycast/window-management/next-display"),
      h: open("-g raycast://extensions/raycast/window-management/left-half"),
      l: open("-g raycast://extensions/raycast/window-management/right-half"),
      f: open("-g raycast://extensions/raycast/window-management/maximize"),
      c: open(
        "-g raycast://extensions/raycast/window-management/almost-maximize"
      ),
      u: open(
        "-g raycast://extensions/raycast/window-management/top-left-quarter"
      ),
      i: open(
        "-g raycast://extensions/raycast/window-management/top-right-quarter"
      ),
      j: open(
        "-g raycast://extensions/raycast/window-management/bottom-left-quarter"
      ),
      k: open(
        "-g raycast://extensions/raycast/window-management/bottom-right-quarter"
      ),
      t: open(
        "-g raycast://extensions/raycast/window-management/reasonable-size"
      ),
      r: open("-g raycast://extensions/raycast/window-management/restore"),
      m: open(
        "-g raycast://extensions/raycast/system/hide-all-apps-except-frontmost"
      ),
      q: open("-g raycast://extensions/raycast/system/quit-all-applications"),
      comma: open(
        "-g raycast://extensions/raycast/window-management/make-larger"
      ),
      period: open(
        "-g raycast://extensions/raycast/window-management/make-smaller"
      ),
      n: {
        description: "Window: Next Window",
        to: [
          {
            key_code: "grave_accent_and_tilde",
            modifiers: ["right_command"],
          },
        ],
      },
    },

    // s = "System"
    s: {
      l: {
        to: [
          {
            key_code: "q",
            modifiers: ["right_control", "right_command"],
          },
        ],
      },
      p: {
        to: [
          {
            key_code: "play_or_pause",
          },
        ],
      },
      semicolon: {
        to: [
          {
            key_code: "fastforward",
          },
        ],
      },
      g: {
        to: [
          {
            key_code: "2",
            modifiers: ["right_shift", "right_command"],
          },
        ],
      },

      // "T"heme
      t: open(`raycast://extensions/raycast/system/toggle-system-appearance`),
      c: open("raycast://extensions/raycast/system/open-camera"),
    },

    // v = "moVe" which isn't "m" because we want it to be on the left hand
    // so that hjkl work like they do in vim
    v: {
      h: {
        to: [{ key_code: "left_arrow" }],
      },
      j: {
        to: [{ key_code: "down_arrow" }],
      },
      k: {
        to: [{ key_code: "up_arrow" }],
      },
      l: {
        to: [{ key_code: "right_arrow" }],
      },
      // Magicmove via homerow.app
      m: {
        to: [{ key_code: "f", modifiers: ["right_control"] }],
        // TODO: Trigger Vim Easymotion when VSCode is focused
      },
      // Scroll mode via homerow.app
      s: {
        to: [{ key_code: "j", modifiers: ["right_control"] }],
      },
      d: {
        to: [{ key_code: "d", modifiers: ["right_shift", "right_command"] }],
      },
      u: {
        to: [{ key_code: "page_down" }],
      },
      i: {
        to: [{ key_code: "page_up" }],
      },
    },

    // c = Musi*c* which isn't "m" because we want it to be on the left hand
    c: {
      p: {
        to: [{ key_code: "play_or_pause" }],
      },
      n: {
        to: [{ key_code: "fastforward" }],
      },
      b: {
        to: [{ key_code: "rewind" }],
      },
    },

    // r = "Raycast"
    r: {
      c: open("raycast://extensions/thomas/color-picker/pick-color"),
      n: open("raycast://script-commands/dismiss-notifications"),
      l: open(
        "raycast://extensions/stellate/mxstbr-commands/create-mxs-is-shortlink"
      ),
      e: open(
        "raycast://extensions/raycast/emoji-symbols/search-emoji-symbols"
      ),
      p: open("raycast://extensions/raycast/raycast/confetti"),
      a: open("raycast://extensions/raycast/raycast-ai/ai-chat"),
      s: open("raycast://extensions/peduarte/silent-mention/index"),
      h: open(
        "raycast://extensions/raycast/clipboard-history/clipboard-history"
      ),
      1: open(
        "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-1"
      ),
      2: open(
        "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-2"
      ),
    },
  }),
];

fs.writeFileSync(
  "karabiner.json",
  JSON.stringify(
    {
      global: {
        show_in_menu_bar: false,
      },
      profiles: [
        {
          name: "Default",
          complex_modifications: {
            rules,
          },
        },
      ],
    },
    null,
    2
  )
);
