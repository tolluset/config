local wezterm = require("wezterm")
return {
	keys = {
		-- clear screen
		{ key = "k", mods = "CMD", action = wezterm.action({ ClearScrollback = "ScrollbackAndViewport" }) },

		-- move by optons + ← →
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	},
	color_scheme = "cyberpunk",
	font = wezterm.font("Hack Nerd Font"),
	window_background_opacity = 0.6,
	text_background_opacity = 0.6,
}
