-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
-- nvidia
-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME"," nvidia")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
-- hl.env("STEAM_FORCE_DESKTOPUI_SCALING", "1")

-- toolkit backend
-- hl.env("GDK_BACKEND", "wayland,x11,*")
-- hl.env("SDL_VIDEODRIVER", "wayland")
-- hl.env("CLUTTER_BACKEND", "wayland")

-- xdg
-- hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
-- hl.env("XDG_SESSION_TYPE", "wayland")
-- hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- qt
-- hl.env("GDK_SCALE", 1)
-- hl.env("GDK_DPI_SCALE", "0.625")
-- hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1.25")
-- hl.env("QT_QPA_PLATFORM", "wayland;xcb")
-- hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- cursor
-- hl.env("XCURSOR_THEME", "breeze_cursors")
-- hl.env("XCURSOR_SIZE", "24")
-- hl.env("HYPRCURSOR_SIZE", "24")
