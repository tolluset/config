local wezterm = require("wezterm")
local act = wezterm.action

-- opacity 프리셋 (0.0 -> 0.6 -> 1.0 순환)
local opacity_presets = { 0.0, 0.6, 1.0 }
local current_opacity_index = 3 -- 1.0부터 시작

local config = {
	keys = {
		-- clear screen
		{ key = "k", mods = "CMD", action = wezterm.action({ ClearScrollback = "ScrollbackAndViewport" }) },

		-- move by optons + ← →
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },

		-- opacity 순환 토글
		{
			key = "u",
			mods = "CTRL|SHIFT",
			action = wezterm.action.EmitEvent("cycle-opacity"),
		},
		-- QuickSelect (macOS 입력소스 단축키 충돌 회피)
		{ key = "Space", mods = "CMD|SHIFT", action = act.QuickSelect },
	},
	color_scheme = "cyberpunk",
	font = wezterm.font_with_fallback({
		"Hack",
		"MesloLGSDZ Nerd Font",
	}),
	window_background_opacity = 1.0,
	text_background_opacity = 1.0,
	audible_bell = "SystemBeep",
}

-- opacity 순환 이벤트 핸들러
wezterm.on("cycle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}

	current_opacity_index = (current_opacity_index % #opacity_presets) + 1
	local new_opacity = opacity_presets[current_opacity_index]

	overrides.window_background_opacity = new_opacity
	overrides.text_background_opacity = new_opacity

	window:set_config_overrides(overrides)
end)

return config
