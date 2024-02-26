local wezterm = require("wezterm")

local Theme = {}

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Zenwritten_dark"
	else
		return "Zenwritten_light"
	end
end

function Theme.setup(config)
	config.color_scheme = scheme_for_appearance(get_appearance())
end

return Theme
