-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local mux = wezterm.mux

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "PaleNightHC"
config.font = wezterm.font("Fira Code Semibold")
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.enable_scroll_bar = true
config.scrollback_lines = 3500
config.initial_cols = 150
config.initial_rows = 80
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "INTEGRATED_BUTTONS|NONE"
config.keys = {
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
}
-- and finally, return the configuration to wezterm
wezterm.on("gui-startup", function(window)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)
return config
