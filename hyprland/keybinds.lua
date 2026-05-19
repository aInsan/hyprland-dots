-- Keybindings
-- https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod = "SUPER"

-- ── Core ────────────────────────────────────────────────────────────────────
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(
	"CTRL + ALT + Delete",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit")
)
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(terminal .. " btop"))
hl.bind(mainMod .. " + ALT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + D", function()
	local w = hl.get_active_window()
	if w == nil then
		return
	end

	if w.fullscreen == 1 then
		-- Already in pseudo-fullscreen → restore to normal
		hl.dispatch(hl.dsp.window.fullscreen_state({
			internal = 0,
			client = 0,
		}))
	else
		-- Enter pseudo-fullscreen
		hl.dispatch(hl.dsp.window.fullscreen_state({
			internal = 1, -- Hyprland maximizes (respects gaps, bar, borders)
			client = 1, -- App thinks it's fullscreen
		}))
	end
end)

hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("systemctl sleep"))
hl.bind(mainMod .. " + J", hl.dsp.exec_cmd("~/.config/quickshell/toggle.sh"))

-- ── Focus ────────────────────────────────────────────────────────────────────
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- ── Workspaces ───────────────────────────────────────────────────────────────
for i = 1, 10 do
	local key = i % 10 -- 10 → key "0"
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- ── Special workspace (scratchpad) ───────────────────────────────────────────
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- ── Mouse ────────────────────────────────────────────────────────────────────
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── Volume ───────────────────────────────────────────────────────────────────
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh up"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh down"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/hypr/scripts/volume.sh mute"), { locked = true, repeating = true })
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- ── Brightness ───────────────────────────────────────────────────────────────
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh up"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh down"),
	{ locked = true, repeating = true }
)
hl.bind(
	"CTRL + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh up"),
	{ locked = true, repeating = true }
)
hl.bind(
	"CTRL + XF86AudioLowerVolume",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh down"),
	{ locked = true, repeating = true }
)

-- ── Media (requires playerctl) ───────────────────────────────────────────────
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("pavucontrol-qt"))

-- ── Clipboard ────────────────────────────────────────────────────────────────
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("iv -w $(wl-paste)"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grimblast copysave area -n -f"))

-- ── Misc ─────────────────────────────────────────────────────────────────────
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd([[bash -c 'notify-send "$(date +"%T %a %b %d")"']]))
