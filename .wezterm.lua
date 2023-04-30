local wezterm = require("wezterm")

-- フルスクリーンで起動
local mux = wezterm.mux
wezterm.on('gui-startup', function(cmd)
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
