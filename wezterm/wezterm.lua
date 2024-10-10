-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local mux = wezterm.mux
local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Dracula"
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font_size = is_linux() and 10.0 or 12.0
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.enable_scroll_bar = true
config.scrollback_lines = 3500
config.initial_cols = 150
config.initial_rows = 80
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = is_linux() and "INTEGRATED_BUTTONS|NONE" or "INTEGRATED_BUTTONS"
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
