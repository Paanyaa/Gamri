-- ~/.gaming/hyprland.lua
-- Gaming profile — Nvidia + Intel hybrid, minimal

-- ── Nvidia + Intel hybrid env vars ───────────────────────────────────────────

hl.env("GBM_BACKEND",                "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME",  "nvidia")
hl.env("LIBVA_DRIVER_NAME",          "nvidia")
hl.env("AQ_DRM_DEVICES",            "/dev/dri/card1:/dev/dri/card0") -- Nvidia first, Intel fallback

hl.env("XDG_SESSION_TYPE",             "wayland")
hl.env("XDG_CURRENT_DESKTOP",          "Hyprland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland") -- Discord screen share

-- ── Font & DPI ───────────────────────────────────────────────────────────────

hl.env("FONT",          "JetBrainsMono Nerd Font")
hl.env("GDK_DPI_SCALE", "1")
hl.env("QT_FONT_DPI",   "96")
hl.env("XCURSOR_SIZE",  "24")

-- ── Monitor ──────────────────────────────────────────────────────────────────

hl.monitor({
  output   = "eDP-2",
  mode     = "1920x1080@144",
  position = "0x0",
  scale    = 1,
})

-- ── Autostart ────────────────────────────────────────────────────────────────

-- live wallpaper
hl.exec_cmd("systemctl --user start mpvpaper.service")
-- ── Keybinds ─────────────────────────────────────────────────────────────────

-- Terminal
hl.bind("SUPER + Return", hl.dsp.exec_cmd("foot"))

-- Logout
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("hyprshutdown"))

-- Shutodwn
hl.bind("SUPER + P", hl.dsp.exec_cmd("poweroff"))

-- Reboot
hl.bind("SUPER + O", hl.dsp.exec_cmd("reboot"))

-- Kill focused window
hl.bind("SUPER + Q", hl.dsp.window.close())

-- Thunar files
hl.bind("SUPER + T", hl.dsp.exec_cmd("thunar"))

-- Launch Apps
hl.bind("SUPER + B", hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + G", hl.dsp.exec_cmd("steam"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("discord"))
hl.bind("SUPER + CTRL + B", hl.dsp.exec_cmd("blueman-manager"))

-- Live wallpaper
hl.bind("SUPER + W", hl.dsp.exec_cmd("~/.gaming/mpvpaper-toggle.sh"))

-- Fullscreen screenshot
hl.bind("Print", hl.dsp.exec_cmd("grim ~/Pictures/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"))

-- Region screenshot (select area with mouse)
hl.bind("SUPER + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"))

-- Active window screenshot (using hyprctl to get window geometry)
hl.bind("ALT + Print", hl.dsp.exec_cmd("grim -g \"$(hyprctl activewindow -j | jq -r '.at[0],.at[1],.size[0],.size[1]' | paste -sd 'x' -)\" ~/Pictures/windowshot-$(date +%Y-%m-%d_%H-%M-%S).png"))


-- Volume controls — wob overlay + sound
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+; wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}' > /tmp/wob.sock; paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-; wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}' > /tmp/wob.sock; paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"), { locked = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Workspaces 1–5
for i = 1, 5 do
  hl.bind("SUPER + " .. i,         hl.dsp.focus({ workspace = tostring(i) }))
  hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
  hl.window_rule({ match = { class = "discord" }, workspace = 1, opacity=0.8})
  hl.window_rule({ match = { class = "steam" }, workspace = 2, opacity=0.8})
  hl.window_rule({ match = { class = "firefox" }, workspace = 3, opacity=0.8})


-- Input 
hl.config({
   input = {
	kb_layout = "us",
	numlock_by_default = true,
	repeat_delay = 250,
	repeat_rate = 35,
	focus_on_close = 1,
	touchpad = {
	   natural_scroll = true,
   	},
   },
   misc = {
	force_default_wallpaper = 0,
	disable_hyprland_logo = true
   } 
})
end

require("hyprland.env")
