local wezterm = require("wezterm")
local act = wezterm.action
local ok_local, local_config = pcall(dofile, wezterm.config_dir .. "/local.lua")
if not ok_local then local_config = {} end
local default_cwd = local_config.default_cwd or (wezterm.home_dir .. "/workspaces")

-- opacity 프리셋 (0.0 -> 0.6 -> 1.0 순환)
local opacity_presets = { 0.0, 0.6, 1.0 }
local current_opacity_index = 3 -- 1.0부터 시작

-- 윈도우를 화면 오른쪽 절반에 배치
local function snap_right_half(mux_window)
	local screen = wezterm.gui.screens().active
	local half_width = math.floor(screen.width / 2)
	local gui = mux_window:gui_window()
	gui:set_inner_size(half_width, screen.height)
	gui:set_position(half_width, 0)
end

local function claude_or(skill, fallback)
	local text = skill .. "\r"
	return wezterm.action_callback(function(window, pane)
		local process = pane:get_foreground_process_name()
		if process and process:find("claude", 1, true) then
			pane:send_text(text)
		elseif fallback then
			window:perform_action(fallback, pane)
		end
	end)
end

-- forward declarations (config 내 action_callback에서 참조)
local tab_display = {}
local last_completed_tid = nil

local config = {
	keys = {
		{ key = "k", mods = "CMD", action = claude_or("/clear", act.ClearScrollback("ScrollbackAndViewport")) },
		{ key = "s", mods = "CMD|SHIFT", action = claude_or("/simplify") },
		{ key = "Enter", mods = "CMD|SHIFT", action = claude_or("/commit-commands:commit") },
		{ key = "l", mods = "CMD|SHIFT", action = claude_or("/compound-engineering:ce-compound") },
		{ key = "r", mods = "CMD|SHIFT", action = claude_or("/code-review:review-local-changes", act.ReloadConfiguration) },
		{ key = "e", mods = "CMD|SHIFT", action = claude_or("/compound-engineering:ce-review") },

		-- 완료된/idle Claude 탭으로 점프
		{
			key = "j",
			mods = "CMD",
			action = wezterm.action_callback(function(window, pane)
				local ok, err = pcall(function()
					local tabs = window:mux_window():tabs_with_info()
					for _, info in ipairs(tabs) do
						if last_completed_tid and info.tab:tab_id() == last_completed_tid and not info.is_active then
							window:perform_action(act.ActivateTab(info.index), pane)
							last_completed_tid = nil
							return
						end
					end
					for _, info in ipairs(tabs) do
						local d = tab_display[info.tab:tab_id()]
						if d and d.state == "idle" and not info.is_active then
							window:perform_action(act.ActivateTab(info.index), pane)
							return
						end
					end
					window:toast_notification("Claude", "idle 탭 없음", nil, 1500)
				end)
				if not ok then
					window:toast_notification("Error", tostring(err), nil, 5000)
				end
			end),
		},
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
		-- 탭 위치 스왑 (현재 탭을 왼쪽/오른쪽으로)
		{ key = "{", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
		{ key = "}", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
		-- 새 윈도우도 오른쪽 절반에 배치
		{
			key = "n",
			mods = "CMD",
			action = wezterm.action_callback(function(_, _)
				local tab, pane, window = wezterm.mux.spawn_window({})
				snap_right_half(window)
			end),
		},
	},
	color_scheme = "cyberpunk",
	font = wezterm.font_with_fallback({
		"Hack",
		"MesloLGSDZ Nerd Font",
	}),
	window_background_opacity = 1.0,
	text_background_opacity = 1.0,
	audible_bell = "SystemBeep",
	status_update_interval = 33, -- ~30fps
	mouse_wheel_scrolls_tabs = false,
	default_cwd = default_cwd,
}

-- 파일 경로 패턴을 클릭 가능한 hyperlink으로 감지
config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
	-- /absolute/path/to/file:line 패턴 매칭
	regex = [[(/.+?\.\w+):(\d+)]],
	format = "file://$1:$2",
})

-- 시작 시 화면 오른쪽 절반에 배치 + 기본 디렉토리
wezterm.on("gui-startup", function(cmd)
	local args = cmd or {}
	args.cwd = args.cwd or default_cwd
	local tab, pane, window = wezterm.mux.spawn_window(args)
	pane:send_text("cd " .. args.cwd .. " && clear\n")
	snap_right_half(window)
end)

-- opacity 순환 이벤트 핸들러
wezterm.on("cycle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}

	current_opacity_index = (current_opacity_index % #opacity_presets) + 1
	local new_opacity = opacity_presets[current_opacity_index]

	overrides.window_background_opacity = new_opacity
	overrides.text_background_opacity = new_opacity

	window:set_config_overrides(overrides)
end)

-- 프로세스별 탭 아이콘 + CWD 기반 탭 이름
local process_icons = {
	nvim = "",
	vim = "",
	node = "⬢",
	python3 = "",
	python = "",
}

-- 컬러 팔레트
local THEME = {
	blue = "#3182F6",
	blue_dim = "#2B6AD0",
	white = "#FFFFFF",
	gray1 = "#D1D6DB",  -- 밝은 회색
	gray2 = "#8B95A1",  -- 중간 회색
	gray3 = "#6B7684",  -- 어두운 회색
}
local spinner_frames = { "⠋", "⠙", "⠸", "⢰", "⣠", "⣄", "⡆", "⠇" }
-- idle 숨쉬기 (블루 밝기 사이클)
local idle_pulse = { "#3182F6", "#4593F7", "#5BA4F8", "#6FB2F9", "#5BA4F8", "#4593F7", "#3182F6", "#2B6AD0" }
local prev_tab_state = {}
local busy_start = {}
local spinner_tick = 0
local claude_panes = {} -- pane_id -> true
local prev_titles = {} -- tab_id -> last set_title value (변경 감지)

-- CWD에서 디렉토리명 추출 (MuxPane/PaneInformation 양쪽 지원)
local function get_dir(pane)
	local cwd
	-- MuxPane: method call
	local ok, result = pcall(function() return pane:get_current_working_dir() end)
	if ok and result then cwd = result end
	-- PaneInformation: field access
	if not cwd then cwd = pane.current_working_dir end
	if cwd then
		return tostring(cwd):match("([^/]+)/?$") or ""
	end
	return ""
end

-- 30fps 상태 추적 + display 캐시 + OSC 0 방어
wezterm.on("update-status", function(window, pane)
	spinner_tick = spinner_tick + 1
	pcall(function()
		local active_pids = {}
		for _, info in ipairs(window:mux_window():tabs_with_info()) do
			local tab = info.tab
			local active = tab:active_pane()
			local process = active:get_foreground_process_name() or ""
			local pid = tostring(active:pane_id())
			local tid = tab:tab_id()
			active_pids[pid] = true

			if process:find("/claude/", 1, true) then
				claude_panes[pid] = true
			end

			if claude_panes[pid] then
				local title = active:get_title() or ""
				local is_idle = title:find("✳", 1, true) ~= nil
				local session = title:match("^%S+%s+(.+)") or ""
				local project = get_dir(active)
				local idx = spinner_tick % #spinner_frames + 1
				local pulse_idx = (math.floor(spinner_tick / 4) + tid) % #idle_pulse + 1
				local state = is_idle and "idle" or "busy"
				if state == "busy" and not busy_start[tid] then
					busy_start[tid] = os.time()
				end
				if prev_tab_state[tid] == "busy" and state == "idle" then
					busy_start[tid] = nil
					last_completed_tid = tid
				end
				prev_tab_state[tid] = state

				local elapsed = ""
				if not is_idle and busy_start[tid] then
					local secs = os.time() - busy_start[tid]
					if secs >= 60 then
						elapsed = string.format(" %dm%ds", math.floor(secs/60), secs%60)
					elseif secs >= 5 then
						elapsed = string.format(" %ds", secs)
					end
				end

				-- 표시: project › session (세션명 있으면)
				local label = session ~= "" and (project .. " › " .. session) or project

				tab_display[tid] = {
					state = state, label = label, elapsed = elapsed,
					frame = spinner_frames[idx], pulse = idle_pulse[pulse_idx],
				}
				tab:set_title(is_idle and ("● " .. label) or (spinner_frames[idx] .. " " .. label .. elapsed))
			else
				tab_display[tid] = nil
				local basename = process:match("([^/]+)$") or ""
				local icon = process_icons[basename] or ""
				local new_title = icon .. " " .. get_dir(active)
				if new_title ~= prev_titles[tid] then
					tab:set_title(new_title)
					prev_titles[tid] = new_title
				end
			end
		end
		-- 닫힌 pane 정리
		for pid in pairs(claude_panes) do
			if not active_pids[pid] then claude_panes[pid] = nil end
		end
	end)
end)

-- 색상 입히기 (display 캐시에서 읽기, 재계산 없음)
wezterm.on("format-tab-title", function(tab)
	local is_active = tab.is_active
	local display = tab_display[tab.tab_id]
	if not display then
		local pane = tab.active_pane
		local process = pane.foreground_process_name or ""
		local basename = process:match("([^/]+)$") or ""
		local icon = process_icons[basename] or ""
		local dir = get_dir(pane)
		return {
			{ Foreground = { Color = is_active and THEME.gray1 or THEME.gray3 } },
			{ Text = icon .. " " .. dir },
		}
	end

	if display.state == "idle" then
		return {
			{ Foreground = { Color = is_active and (display.pulse or THEME.blue) or THEME.blue_dim } },
			{ Text = "● " },
			{ Foreground = { Color = is_active and THEME.white or THEME.gray2 } },
			{ Text = display.label },
		}
	else
		return {
			{ Foreground = { Color = is_active and THEME.blue or THEME.gray2 } },
			{ Text = display.frame .. " " },
			{ Foreground = { Color = is_active and THEME.white or THEME.gray2 } },
			{ Text = display.label .. display.elapsed },
		}
	end
end)

return config
