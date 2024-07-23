local wezterm = require("wezterm")

-- full screen on launch
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

local config = {}
local arch = wezterm.target_triple
if arch == "x86_64-pc-windows-msvc" then
    -- for Windows
    config.default_prog = { "wsl", "~" }
elseif arch == "x86_64-apple-darwin" or arch == "aarch64-apple-darwin" then
    -- for Mac
    config.native_macos_fullscreen_mode = false
else
    -- for Linux
end

-- common settings
config.font_size = 15.0
config.line_height = 0.85
config.font = wezterm.font_with_fallback({
    "M+ 1m",
    "Noto Emoji",
})
config.window_decorations = "RESIZE"

config.keys = {
    {
        key = "t",
        mods = "CTRL",
        action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
}

-- override color scheme
local scheme = wezterm.color.get_default_colors()
scheme.foreground = "#dbdbdb"
scheme.background = "#11162c"
scheme.ansi = {
    "#11162c",
    "#f44d2c",
    "#3cc18a",
    "#f4af24",
    "#7793b5",
    "#d9aef9",
    "#9abdea",
    "#b8b8b8",
}
scheme.brights = {
    "#a0a0a0",
    "#f44d2c",
    "#8ecc99",
    "#f9dd9f",
    "#9abdea",
    "#e899ac",
    "#a3e0e2",
    "#dbdbdb",
}
config.color_schemes = { yash = scheme }
config.color_scheme = "yash"

return config
