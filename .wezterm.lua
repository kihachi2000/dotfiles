local wezterm = require("wezterm")

-- full screen on launch
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

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

return config
