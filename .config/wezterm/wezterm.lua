-- wezterm config inspired by https://github.com/thanhvule0310/dotfiles
local wezterm = require("wezterm")
local keys = require("keys")
-- local process_icons = require("process_icons")
local tab = require("tab")
local font = require("font")
local theme = require("theme")

-- local function is_vi_process(pane)
-- 	return pane:get_foreground_process_name():find("n?vim") ~= nil
-- end
--
-- local function conditional_activate_pane(window, pane, pane_direction, vim_direction)
-- 	if is_vi_process(pane) then
-- 		window:perform_action(wezterm.action.SendKey({ key = vim_direction, mods = "ALT" }), pane)
-- 	else
-- 		window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
-- 	end
-- end

-- wezterm.on("ActivatePaneDirection-right", function(window, pane)
-- 	conditional_activate_pane(window, pane, "Right", "l")
-- end)
-- wezterm.on("ActivatePaneDirection-left", function(window, pane)
-- 	conditional_activate_pane(window, pane, "Left", "h")
-- end)
-- wezterm.on("ActivatePaneDirection-up", function(window, pane)
-- 	conditional_activate_pane(window, pane, "Up", "k")
-- end)
-- wezterm.on("ActivatePaneDirection-down", function(window, pane)
-- 	conditional_activate_pane(window, pane, "Down", "j")
-- end)

local config = {
	font = wezterm.font_with_fallback({
		"Liga SFMono Nerd Font",
		"Apple Color Emoji",
	}),
	-- font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
	font_size = 16,
	max_fps = 120,
	enable_wayland = false,
	pane_focus_follows_mouse = false,
	warn_about_missing_glyphs = false,
	show_update_window = false,
	check_for_updates = false,
	line_height = 1.1,
	window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",
	audible_bell = "Disabled",
	window_padding = {
		left = "1cell",
		right = "1cell",
		top = "0.5cell",
		bottom = "0.5cell",
	},
	initial_cols = 110,
	initial_rows = 25,
	inactive_pane_hsb = {
		saturation = 0.5,
		brightness = 0.7,
	},
	enable_scroll_bar = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	window_background_opacity = 1.0,
	tab_max_width = 50,
	hide_tab_bar_if_only_one_tab = true,
	disable_default_key_bindings = true,
	send_composed_key_when_left_alt_is_pressed = true, -- alt keybindings
	use_ime = false,
	use_dead_keys = true,
	debug_key_events = false,
	front_end = "WebGpu",
	hyperlink_rules = {
		{
			regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b",
			format = "$0",
		},
		{
			regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},
		{
			regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
			format = "mailto:$0",
		},
		{
			regex = [[\bfile://\S*\b]],
			format = "$0",
		},
		{
			regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
			format = "$0",
		},
		{
			regex = [[\b[tT](\d+)\b]],
			format = "https://example.com/tasks/?t=$1",
		},
	},
}

font.setup(config)
theme.setup(config)
keys.setup(config)
tab.setup(config)

return config
