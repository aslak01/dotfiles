-- https://github.com/thanhvule0310/dotfiles/blob/main/wezterm/fonts.lua
local wezterm = require("wezterm")

local Fonts = {}

function Fonts.setup(config)
	config.font = wezterm.font_with_fallback({
		"Liga SFMono Nerd Font",
		-- "MesloLGL Nerd Font",
		"Apple Color Emoji",
	})

	config.font_size = 19
	config.underline_thickness = "200%"
	config.underline_position = "-3pt"
	config.line_height = 1.1
end

return Fonts
