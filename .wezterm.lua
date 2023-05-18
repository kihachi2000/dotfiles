local wezterm = require("wezterm")

-- full screen on launch
local mux = wezterm.mux
<<<<<<< HEAD
wezterm.on('gui-startup', function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)


local config = {}
local arch = wezterm.target_triple
if arch == "x86_64-pc-windows-msvc" then
    -- for Windows
    config.default_prog = { "PowerShell.exe", "-NoLogo" }
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

return config
=======
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

return {
    font_size = 15.0,
    line_height = 0.85,

    font = wezterm.font_with_fallback({
        "M+ 1m",
        "Noto Emoji",
    }),
    native_macos_fullscreen_mode = false,
    window_decorations = "RESIZE",
}
>>>>>>> 33f8897e7638ef0253ebd732d6381307c0c10f04
