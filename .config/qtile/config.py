import os
import re
import socket
import subprocess
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from typing import List
from libqtile import hook

mod = "mod4"
myTerm = "alacritty"
myBrowser = "brave-browser"
myFileManager = "nemo"
myTextEditor = "subl"
myOfficeSuite = "desktopeditors"
myLaTeXEditor = "gnome-latex"
myMusicPlayer = "rhythmbox"
myConfig = "~/.config/qtile/config.py"

keys = [
	# Qtile Controls
	Key([mod, "control"], "r", lazy.restart()),
	Key([mod, "control"], "q", lazy.shutdown()),

	# Window and Layout Controls
	Key([mod], "k", lazy.layout.down()),
	Key([mod], "j", lazy.layout.up()),
	Key([mod, "control"], "k", lazy.layout.shuffle_down()),
	Key([mod, "control"], "j", lazy.layout.shuffle_up()),
	Key([mod], "space", lazy.layout.next()),
	Key([mod], "Tab", lazy.next_layout()),
	Key([mod], "l", lazy.layout.grow()),
	Key([mod], "h",lazy.layout.shrink()),
	Key([mod], "f", lazy.window.toggle_floating()),
	Key([mod], "s", lazy.window.toggle_fullscreen()),
	Key([mod], "w", lazy.window.kill()),
	Key([mod], "period", lazy.next_screen()),
	Key([mod], "comma", lazy.prev_screen()),

	# System Controls
	Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
	Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
	Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
	Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
	Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
	#Key(["mod1"], "k", lazy.spawn("brightnessctl set +10%")),
	#Key(["mod1"], "j", lazy.spawn("brightnessctl set 10%-")),

	# Applications launcher
	Key(["mod1"], "Tab", lazy.spawn("rofi -show window")),
	Key([mod, "mod1"], "r", lazy.spawn("rofi -show run")),
	Key([mod], "r", lazy.spawn("rofi -show drun")),
	Key([mod], "Return", lazy.spawn(myTerm)),
	Key([mod, "mod1"], "s", lazy.spawn("spotify")),
	Key([mod, "mod1"], "v", lazy.spawn("vlc")),
	Key([mod, "mod1"], "g", lazy.spawn("steam")),
	Key([mod, "mod1"], "t", lazy.spawn(myTextEditor)),
	Key([mod, "mod1"], "o", lazy.spawn(myOfficeSuite)),
	Key([mod, "mod1"], "l", lazy.spawn(myLaTeXEditor)),
	Key([mod], "e", lazy.spawn(myFileManager)),
	Key([mod, "mod1"], "i", lazy.spawn(myBrowser)),
	Key([mod, "mod1"], "m", lazy.spawn(myMusicPlayer)),
]

groups = [
	Group("web", layout="max"),
	Group("dev", layout="monadtall"),
	Group("sys", layout="bsp"),
	Group("doc", layout="bsp"),
	Group("chat", layout="monadtall"),
	Group("game", layout="max"),
	Group("media", layout="max"),
	Group("gfx", layout="floating")
]

for k, group in zip(["1", "2", "3", "4", "5", "6", "7", "8"], groups):
	keys.append(Key([mod], k, lazy.group[group.name].toscreen()))			# Send current window to another group
	keys.append(Key([mod, "shift"], k, lazy.window.togroup(group.name)))	# Send current window to another group

layout_theme = {"border_width": 2,
				"margin": 4,
				"border_focus": "61AFEF", #colours[6]
				"border_normal": "848484" #colours[2]
				}

layouts = [
	layout.Max(**layout_theme),
	layout.MonadTall(**layout_theme),
	#layout.Tile(shift_windows=True, **layout_theme),
	layout.Bsp(**layout_theme),
	layout.Floating(**layout_theme)
	#layout.MonadWide(**layout_theme),
	#layout.Stack(stacks=2, **layout_theme),
	#layout.Columns(**layout_theme),
	#layout.RatioTile(**layout_theme),
	#layout.VerticalTile(**layout_theme),
	#layout.Matrix(**layout_theme),
	#layout.Zoomy(**layout_theme),
	#layout.Slice(**layout_theme),
	#layout.Stack(num_stacks=2),
]

colours = [["#141414", "#141414"], # Background
		   ["#FFFFFF", "#FFFFFF"], # Foreground
		   ["#848484", "#848484"], # Grey Colour
		   ["#E35374", "#E35374"],
		   ["#98C379", "#98C379"],
		   ["#F0C674", "#F0C674"],
		   ["#61AFEF", "#61AFEF"],
		   ["#C678DD", "#C678DD"],
		   ["#56B6BC", "#56B6BC"]]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

widget_defaults = dict(
	background= colours[0],
	foreground=colours[1],
	font="SF Pro Text Regular",
	fontsize=12,
	padding=1
	)
extension_defaults = widget_defaults.copy()

widgets = [
	widget.Sep(
		foreground=colours[0],
		linewidth=4
	),
	widget.Image(
		scale=True,
		mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn("rofi -show drun")},
		filename="~/.config/qtile/py.png"
	),
	widget.Sep(
		foreground=colours[2],
		linewidth=1,
		padding=10
	),
	widget.GroupBox(
		padding=0,
		active=colours[4],
		inactive=colours[6],
		margin=2,
		highlight_method='text',
		this_current_screen_border=colours[7],
		urgent_alert_method='text',
		urgent_border=colours[3],
		urgent_text=colours[3],
		disable_drag=True,
		invert_mouse_wheel=True
	),
	widget.Sep(
		foreground=colours[2],
		linewidth=1,
		padding=10
	),
	widget.CurrentLayout(
		font="SF Pro Text Semibold",
		foreground=colours[7]
	),
	widget.Systray(
		icon_size=14,
		padding=4
	),
	widget.Cmus(
		play_color=colours[1],
		noplay_color=colours[2]
	),
	widget.Sep(
		foreground=colours[2],
		linewidth=1,
		padding=10
	),
	widget.WindowName(
	),
	widget.TextBox(
		font="JetBrainsMono Nerd Font Regular",
		foreground=colours[3],
		fontsize=14,
		padding=0,
		text='﬙ '
	),
	widget.CPU(
		foreground=colours[3],
		mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e ytop')},
		format='{load_percent}%',
		update_interval=1.0
	),
	widget.Sep(
		foreground=colours[2],
		linewidth=1,
		padding=10
	),
	widget.TextBox(
		font="JetBrainsMono Nerd Font Regular",
		foreground=colours[4],
		fontsize=14,
		padding=0,
		text=' '
	),
	widget.Memory(
		foreground=colours[4],
		mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e ytop')},
		format='{MemUsed} MB'
	),
	widget.Sep(
		foreground=colours[2],
		linewidth=1,
		padding=10
	),
	#widget.TextBox(
	#	font="JetBrainsMono Nerd Font Regular",
	#	foreground=colours[5],
	#	fontsize=14,
	#	padding=0,
	#	text=' '
	#),
	#widget.ThermalSensor(
	#	foreground=colours[5],
	#	threshold=80,
	#	foreground_alert=colours[3],
	#	tag_sensor="Tctl"
	#),
	widget.TextBox(
		font="JetBrainsMono Nerd Font Regular",
		foreground=colours[5],
		fontsize=12,
		padding=0,
		text=' '
	),
	widget.Backlight(
		foreground=colours[5],
		foreground_alert=colours[3],
		backlight_name='amdgpu_bl0',
		change_command='brightnessctl set {0}',
		step=5
	),
	widget.Sep(
		foreground=colours[2],
		linewidth=1,
		padding=10
	),
	widget.TextBox(
		font="JetBrainsMono Nerd Font Regular",
		foreground=colours[6],
		fontsize=14,
		padding=0,
		text='墳 '
	),
	widget.Volume(
		foreground=colours[6],
		step=5
	),
	widget.Sep(
		foreground=colours[2],
		linewidth=1,
		padding=10
	),
	#widget.Net(
	#	background=colours[7],
	#	interface='enp1s0',
	#	format='NET {down} ↓↑ {up}'
	#	),
	#widget.StockTicker(
	#	apikey='AESKWL5CJVHHJKR5',
	#	url='https://www.alphavantage.co/query?'
	#	),
	widget.Battery(
		font="JetBrainsMono Nerd Font Regular",
		fontsize=14,
		padding=0,
		foreground=colours[7],
		charge_char=' ',
		discharge_char=' ',
		empty_char=' ',
		full_char=' ',
		unknown_char=' ',
		format='{char}',
		low_foreground=colours[3],
		low_percentage=0.2,
		show_short_text=False
	),
	widget.Battery(
		foreground=colours[7],
		format='{percent:2.0%}',
		low_foreground=colours[3],
		low_percentage=0.2,
		notify_below=20,
	),
	widget.Sep(
		foreground=colours[2],
		linewidth=1,
		padding=10
	),
	widget.Clock(
		foreground=colours[8],
		format='%a %b %d  %I:%M %P    '
	),
]

status_bar = lambda widgets: bar.Bar(widgets, 18, opacity=1.0)

screens = [Screen(top=status_bar(widgets))]

connected_monitors = subprocess.run(
	"xrandr | grep 'connected' | cut -d ' ' -f 2",
	shell=True,
	stdout=subprocess.PIPE
).stdout.decode("UTF-8").split("\n")[:-1].count("connected")

if connected_monitors > 1:
	for i in range(1, connected_monitors):
		screens.append(Screen(top=status_bar(widgets)))

mouse = [
	Drag([mod], "Button1", lazy.window.set_position_floating(),
		start=lazy.window.get_position()),
	Drag([mod], "Button3", lazy.window.set_size_floating(),
		start=lazy.window.get_size()),
	Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
	{'wmclass': 'confirm'},
	{'wmclass': 'dialog'},
	{'wmclass': 'download'},
	{'wmclass': 'error'},
	{'wmclass': 'file_progress'},
	{'wmclass': 'notification'},
	{'wmclass': 'splash'},
	{'wmclass': 'toolbar'},
	{'wmclass': 'confirmreset'},  # gitk
	{'wmclass': 'makebranch'},  # gitk
	{'wmclass': 'maketag'},  # gitk
	{'wname': 'Authentication'},  # Polkit agent
	{'wname': 'branchdialog'},  # gitk
	{'wname': 'pinentry'},  # GPG key password entry
	{'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def autostart():
	home = os.path.expanduser('~/.config/qtile/autostart.sh')
	subprocess.call([home])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
