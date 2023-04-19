local wezterm = require("wezterm")

-- フルスクリーンで起動
local mux = wezterm.mux
wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

return {
    font_size = 16.0,
    font = wezterm.font "Ricty Diminished",
    native_macos_fullscreen_mode = false,
    window_decorations = "RESIZE",
}
