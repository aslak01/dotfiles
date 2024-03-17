local wezterm = require("wezterm")
local act = wezterm.action

local Keys = {}

-- modified default set to remove CTRL @ preventing a zsh binding

function Keys.setup(config)
	config.disable_default_key_bindings = true
	config.send_composed_key_when_left_alt_is_pressed = true -- alt keybindings
	config.use_ime = false
	config.use_dead_keys = true
	config.debug_key_events = false
	config.keys = {
		-- new split binds
		{ key = "w",     mods = "ALT|CTRL",   action = wezterm.action.CloseCurrentPane({ confirm = true }) },
		{ key = "v",     mods = "ALT|CTRL",   action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h",     mods = "ALT|CTRL",   action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "p",     mods = "ALT|CTRL",   action = act.PaneSelect({ alphabet = "", mode = "Activate" }) },
		{ key = "h",     mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-left") },
		{ key = "j",     mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-down") },
		{ key = "k",     mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-up") },
		{ key = "l",     mods = "ALT",        action = wezterm.action.EmitEvent("ActivatePaneDirection-right") },
		{ key = "Enter", mods = "ALT|CTRL",   action = act.TogglePaneZoomState },
		{ key = "Enter", mods = "ALT",        action = act.ToggleFullScreen },
		{ key = "+",     mods = "CTRL",       action = act.IncreaseFontSize },
		{ key = "-",     mods = "CTRL",       action = act.DecreaseFontSize },
		{ key = "-",     mods = "SUPER",      action = act.DecreaseFontSize },
		{ key = "0",     mods = "SUPER",      action = act.ResetFontSize },
		{ key = "1",     mods = "SUPER",      action = act.ActivateTab(0) },
		{ key = "2",     mods = "SUPER",      action = act.ActivateTab(1) },
		{ key = "3",     mods = "SUPER",      action = act.ActivateTab(2) },
		{ key = "4",     mods = "SUPER",      action = act.ActivateTab(3) },
		{ key = "5",     mods = "SUPER",      action = act.ActivateTab(4) },
		{ key = "6",     mods = "SUPER",      action = act.ActivateTab(5) },
		{ key = "7",     mods = "SUPER",      action = act.ActivateTab(6) },
		{ key = "8",     mods = "SUPER",      action = act.ActivateTab(7) },
		{ key = "9",     mods = "SUPER",      action = act.ActivateTab(-1) },
		{ key = "C",     mods = "CTRL",       action = act.CopyTo("Clipboard") },
		{ key = "C",     mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
		{ key = "F",     mods = "CTRL",       action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "F",     mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "H",     mods = "CTRL",       action = act.HideApplication },
		{ key = "H",     mods = "SHIFT|CTRL", action = act.HideApplication },
		{ key = "K",     mods = "CTRL",       action = act.ClearScrollback("ScrollbackOnly") },
		{ key = "K",     mods = "SHIFT|CTRL", action = act.ClearScrollback("ScrollbackOnly") },
		-- { key = "L", mods = "CTRL", action = act.ShowDebugOverlay },
		{ key = "L",     mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
		{ key = "M",     mods = "CTRL",       action = act.Hide },
		{ key = "M",     mods = "SHIFT|CTRL", action = act.Hide },
		{ key = "N",     mods = "CTRL",       action = act.SpawnWindow },
		{ key = "N",     mods = "SHIFT|CTRL", action = act.SpawnWindow },
		{ key = "Q",     mods = "CTRL",       action = act.QuitApplication },
		{ key = "Q",     mods = "SHIFT|CTRL", action = act.QuitApplication },
		{ key = "R",     mods = "CTRL",       action = act.ReloadConfiguration },
		{ key = "R",     mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
		{ key = "T",     mods = "CTRL",       action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "T",     mods = "SHIFT|CTRL", action = act.SpawnTab("CurrentPaneDomain") },
		{
			key = "U",
			mods = "CTRL",
			action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},
		{
			key = "U",
			mods = "SHIFT|CTRL",
			action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},
		{ key = "V", mods = "CTRL",        action = act.PasteFrom("Clipboard") },
		{ key = "V", mods = "SHIFT|CTRL",  action = act.PasteFrom("Clipboard") },
		{ key = "W", mods = "CTRL",        action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "W", mods = "SHIFT|CTRL",  action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "X", mods = "CTRL",        action = act.ActivateCopyMode },
		{ key = "X", mods = "SHIFT|CTRL",  action = act.ActivateCopyMode },
		{ key = "Z", mods = "SHIFT|CTRL",  action = act.TogglePaneZoomState },
		{ key = "[", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(-1) },
		{ key = "]", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(1) },
		{ key = "^", mods = "CTRL",        action = act.ActivateTab(5) },
		{ key = "^", mods = "SHIFT|CTRL",  action = act.ActivateTab(5) },
		{ key = "_", mods = "CTRL",        action = act.DecreaseFontSize },
		{ key = "_", mods = "SHIFT|CTRL",  action = act.DecreaseFontSize },
		{ key = "c", mods = "SHIFT|CTRL",  action = act.CopyTo("Clipboard") },
		{ key = "c", mods = "SUPER",       action = act.CopyTo("Clipboard") },
		{ key = "f", mods = "SHIFT|CTRL",  action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "f", mods = "SUPER",       action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "h", mods = "SHIFT|CTRL",  action = act.HideApplication },
		{ key = "h", mods = "SUPER",       action = act.HideApplication },
		{ key = "k", mods = "SHIFT|CTRL",  action = act.ClearScrollback("ScrollbackOnly") },
		{ key = "k", mods = "SUPER",       action = act.ClearScrollback("ScrollbackOnly") },
		-- { key = "l", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
		{ key = "m", mods = "SHIFT|CTRL",  action = act.Hide },
		{ key = "m", mods = "SUPER",       action = act.Hide },
		{ key = "n", mods = "SHIFT|CTRL",  action = act.SpawnWindow },
		{ key = "n", mods = "SUPER",       action = act.SpawnWindow },
		{ key = "p", mods = "CTRL",        action = act.PaneSelect({ alphabet = "", mode = "Activate" }) },
		{ key = "q", mods = "SHIFT|CTRL",  action = act.QuitApplication },
		{ key = "q", mods = "SUPER",       action = act.QuitApplication },
		{ key = "r", mods = "SHIFT|CTRL",  action = act.ReloadConfiguration },
		{ key = "r", mods = "SUPER",       action = act.ReloadConfiguration },
		{ key = "t", mods = "SHIFT|CTRL",  action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "t", mods = "SUPER",       action = act.SpawnTab("CurrentPaneDomain") },
		{
			key = "u",
			mods = "SHIFT|CTRL",
			action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},
		{ key = "v",          mods = "SHIFT|CTRL",  action = act.PasteFrom("Clipboard") },
		{ key = "v",          mods = "SUPER",       action = act.PasteFrom("Clipboard") },
		{ key = "w",          mods = "SHIFT|CTRL",  action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "w",          mods = "SUPER",       action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "x",          mods = "SHIFT|CTRL",  action = act.ActivateCopyMode },
		{ key = "z",          mods = "SHIFT|CTRL",  action = act.TogglePaneZoomState },
		{ key = "{",          mods = "SUPER",       action = act.ActivateTabRelative(-1) },
		{ key = "{",          mods = "SHIFT|SUPER", action = act.ActivateTabRelative(-1) },
		{ key = "}",          mods = "SUPER",       action = act.ActivateTabRelative(1) },
		{ key = "}",          mods = "SHIFT|SUPER", action = act.ActivateTabRelative(1) },
		{ key = "phys:Space", mods = "SHIFT|CTRL",  action = act.QuickSelect },
		{ key = "PageUp",     mods = "SHIFT",       action = act.ScrollByPage(-1) },
		{ key = "PageUp",     mods = "CTRL",        action = act.ActivateTabRelative(-1) },
		{ key = "PageUp",     mods = "SHIFT|CTRL",  action = act.MoveTabRelative(-1) },
		{ key = "PageDown",   mods = "SHIFT",       action = act.ScrollByPage(1) },
		{ key = "PageDown",   mods = "CTRL",        action = act.ActivateTabRelative(1) },
		{ key = "PageDown",   mods = "SHIFT|CTRL",  action = act.MoveTabRelative(1) },
		{ key = "LeftArrow",  mods = "SHIFT|CTRL",  action = act.ActivatePaneDirection("Left") },
		{ key = "LeftArrow",  mods = "",            action = act.AdjustPaneSize({ "Left", 3 }) },
		{ key = "RightArrow", mods = "SHIFT|CTRL",  action = act.ActivatePaneDirection("Right") },
		{ key = "RightArrow", mods = "",            action = act.AdjustPaneSize({ "Right", 3 }) },
		{ key = "UpArrow",    mods = "SHIFT|CTRL",  action = act.ActivatePaneDirection("Up") },
		{ key = "UpArrow",    mods = "",            action = act.AdjustPaneSize({ "Up", 3 }) },
		{ key = "DownArrow",  mods = "SHIFT|CTRL",  action = act.ActivatePaneDirection("Down") },
		{ key = "DownArrow",  mods = "",            action = act.AdjustPaneSize({ "Down", 3 }) },
		{ key = "Insert",     mods = "SHIFT",       action = act.PasteFrom("PrimarySelection") },
		{ key = "Insert",     mods = "CTRL",        action = act.CopyTo("PrimarySelection") },
		{ key = "Copy",       mods = "NONE",        action = act.CopyTo("Clipboard") },
		{ key = "Paste",      mods = "NONE",        action = act.PasteFrom("Clipboard") },
	}

	config.key_tables = {
		copy_mode = {
			{ key = "Tab",    mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
			{ key = "Tab",    mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "Enter",  mods = "NONE",  action = act.CopyMode("MoveToStartOfNextLine") },
			{ key = "Escape", mods = "NONE",  action = act.CopyMode("Close") },
			{ key = "Space",  mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "$",      mods = "NONE",  action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$",      mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = ",",      mods = "NONE",  action = act.CopyMode("JumpReverse") },
			{ key = "0",      mods = "NONE",  action = act.CopyMode("MoveToStartOfLine") },
			{ key = ";",      mods = "NONE",  action = act.CopyMode("JumpAgain") },
			{ key = "F",      mods = "NONE",  action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "F",      mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "G",      mods = "NONE",  action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "G",      mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "H",      mods = "NONE",  action = act.CopyMode("MoveToViewportTop") },
			{ key = "H",      mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			-- { key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			-- { key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "M",      mods = "NONE",  action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "M",      mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "O",      mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O",      mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "T",      mods = "NONE",  action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "T",      mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "V",      mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "V",      mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "^",      mods = "NONE",  action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^",      mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "b",      mods = "NONE",  action = act.CopyMode("MoveBackwardWord") },
			{ key = "b",      mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
			{ key = "b",      mods = "CTRL",  action = act.CopyMode("PageUp") },
			{ key = "c",      mods = "CTRL",  action = act.CopyMode("Close") },
			{ key = "f",      mods = "NONE",  action = act.CopyMode({ JumpForward = { prev_char = false } }) },
			{ key = "f",      mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
			{ key = "f",      mods = "CTRL",  action = act.CopyMode("PageDown") },
			{ key = "g",      mods = "NONE",  action = act.CopyMode("MoveToScrollbackTop") },
			{ key = "g",      mods = "CTRL",  action = act.CopyMode("Close") },
			{ key = "h",      mods = "NONE",  action = act.CopyMode("MoveLeft") },
			{ key = "j",      mods = "NONE",  action = act.CopyMode("MoveDown") },
			{ key = "k",      mods = "NONE",  action = act.CopyMode("MoveUp") },
			{ key = "l",      mods = "NONE",  action = act.CopyMode("MoveRight") },
			{ key = "m",      mods = "ALT",   action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "o",      mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "q",      mods = "NONE",  action = act.CopyMode("Close") },
			{ key = "t",      mods = "NONE",  action = act.CopyMode({ JumpForward = { prev_char = true } }) },
			{ key = "v",      mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v",      mods = "CTRL",  action = act.CopyMode({ SetSelectionMode = "Block" }) },
			{ key = "w",      mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
			},
			{ key = "PageUp",     mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown",   mods = "NONE", action = act.CopyMode("PageDown") },
			{ key = "LeftArrow",  mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "LeftArrow",  mods = "ALT",  action = act.CopyMode("MoveBackwardWord") },
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "RightArrow", mods = "ALT",  action = act.CopyMode("MoveForwardWord") },
			{ key = "UpArrow",    mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow",  mods = "NONE", action = act.CopyMode("MoveDown") },
		},

		search_mode = {
			{ key = "Enter",     mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "Escape",    mods = "NONE", action = act.CopyMode("Close") },
			{ key = "n",         mods = "CTRL", action = act.CopyMode("NextMatch") },
			{ key = "p",         mods = "CTRL", action = act.CopyMode("PriorMatch") },
			{ key = "r",         mods = "CTRL", action = act.CopyMode("CycleMatchType") },
			{ key = "u",         mods = "CTRL", action = act.CopyMode("ClearPattern") },
			{ key = "PageUp",    mods = "NONE", action = act.CopyMode("PriorMatchPage") },
			{ key = "PageDown",  mods = "NONE", action = act.CopyMode("NextMatchPage") },
			{ key = "UpArrow",   mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
		},
	}
end

return Keys

-- from disabled config:
-- keys = {
--   {
--     mods = "ALT",
--     key = [[\]],
--     action = wezterm.action({
--       SplitHorizontal = { domain = "CurrentPaneDomain" },
--     }),
--   },
--   {
--     mods = "ALT|SHIFT",
--     key = [[|]],
--     action = wezterm.action.SplitPane({
--       top_level = true,
--       direction = "Right",
--       size = { Percent = 50 },
--     }),
--   },
--   {
--     mods = "ALT",
--     key = [[-]],
--     action = wezterm.action({
--       SplitVertical = { domain = "CurrentPaneDomain" },
--     }),
--   },
--   {
--     mods = "ALT|SHIFT",
--     key = [[_]],
--     action = wezterm.action.SplitPane({
--       top_level = true,
--       direction = "Down",
--       size = { Percent = 50 },
--     }),
--   },
--   {
--     key = "n",
--     mods = "ALT",
--     action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
--   },
--   {
--     key = "Q",
--     mods = "ALT",
--     action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
--   },
--   { key = "q", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
--   { key = "z", mods = "ALT", action = wezterm.action.TogglePaneZoomState },
--   { key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },
--   { key = "h", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
--   { key = "j", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
--   { key = "k", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
--   { key = "l", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
--   { key = "h", mods = "ALT", action = wezterm.action.EmitEvent("ActivatePaneDirection-left") },
--   { key = "j", mods = "ALT", action = wezterm.action.EmitEvent("ActivatePaneDirection-down") },
--   { key = "k", mods = "ALT", action = wezterm.action.EmitEvent("ActivatePaneDirection-up") },
--   { key = "l", mods = "ALT", action = wezterm.action.EmitEvent("ActivatePaneDirection-right") },
--   { key = "[", mods = "ALT", action = wezterm.action({ ActivateTabRelative = -1 }) },
--   { key = "]", mods = "ALT", action = wezterm.action({ ActivateTabRelative = 1 }) },
--   { key = "{", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(-1) },
--   { key = "}", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(1) },
--   { key = "v", mods = "ALT", action = wezterm.action.ActivateCopyMode },
--   { key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
--   { key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
--   { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
--   { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
--   { key = "1", mods = "ALT", action = wezterm.action({ ActivateTab = 0 }) },
--   { key = "2", mods = "ALT", action = wezterm.action({ ActivateTab = 1 }) },
--   { key = "3", mods = "ALT", action = wezterm.action({ ActivateTab = 2 }) },
--   { key = "4", mods = "ALT", action = wezterm.action({ ActivateTab = 3 }) },
--   { key = "5", mods = "ALT", action = wezterm.action({ ActivateTab = 4 }) },
--   { key = "6", mods = "ALT", action = wezterm.action({ ActivateTab = 5 }) },
--   { key = "7", mods = "ALT", action = wezterm.action({ ActivateTab = 6 }) },
--   { key = "8", mods = "ALT", action = wezterm.action({ ActivateTab = 7 }) },
--   { key = "9", mods = "ALT", action = wezterm.action({ ActivateTab = 8 }) },
-- },
