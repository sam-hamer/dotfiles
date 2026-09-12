------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "DP-1",
    mode     = "3840x2160@143.99",
    position = "0x0",
    scale    = "1.25",
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "3840x2160@143.99",
    position = "-3072x0",
    scale    = "1.25",
})

-- Workspaces 1-5 on main monitor
for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1", persistent = true })
end

-- Workspaces 6-10 on main monitor
for i = 6, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1", persistent = true })
end
