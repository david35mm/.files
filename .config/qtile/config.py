import os
import re
import socket
import subprocess
from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import EzClick as Click, EzDrag as Drag, EzKey as Key, Group, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List

mod = "mod4"
myTerm = guess_terminal()
myBrowser = "brave-browser"
myFileManager = "pcmanfm"
myTextEditor = "subl"
myOfficeSuite = "desktopeditors"
myLaTeXEditor = "gnome-latex"
myMusicPlayer = myTerm+" -e cmus"
myConfig = "~/.config/qtile/config.py"

keys = [
	# Qtile Controls
	Key("M-C-r", lazy.restart()),
	Key("M-C-q", lazy.shutdown()),

	# Window and Layout Controls
	Key("M-k", lazy.layout.down()),
	Key("M-j", lazy.layout.up()),
	Key("M-C-k", lazy.layout.shuffle_down()),
	Key("M-C-j", lazy.layout.shuffle_up()),
	Key("M-<space>", lazy.layout.next()),
	Key("M-<Tab>", lazy.next_layout()),
	Key("M-l", lazy.layout.grow()),
	Key("M-h",lazy.layout.shrink()),
	Key("M-f", lazy.window.toggle_floating()),
	Key("M-s", lazy.window.toggle_fullscreen()),
	Key("M-w", lazy.window.kill()),
	Key("M-<period>", lazy.next_screen()),
	Key("M-<comma>", lazy.prev_screen()),

	# System Controls
	Key("<XF86AudioLowerVolume>", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
	Key("<XF86AudioRaiseVolume>", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
	Key("<XF86AudioMute>", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
	Key("<XF86MonBrightnessUp>", lazy.spawn("brightnessctl set +10%")),
	Key("<XF86MonBrightnessDown>", lazy.spawn("brightnessctl set 10%-")),
	#Key("A-k", lazy.spawn("brightnessctl set +10%")),
	#Key("A-j", lazy.spawn("brightnessctl set 10%-")),

	# Applications launcher
	Key("A-<Tab>", lazy.spawn("rofi -show window")),
	Key("M-A-r", lazy.spawn("rofi -show run")),
	Key("M-r", lazy.spawn("rofi -show drun")),
	Key("M-<Return>", lazy.spawn(myTerm)),
	Key("M-A-s", lazy.spawn("spotify")),
	Key("M-A-v", lazy.spawn("vlc")),
	Key("M-A-g", lazy.spawn("steam")),
	Key("M-A-t", lazy.spawn(myTextEditor)),
	Key("M-A-o", lazy.spawn(myOfficeSuite)),
	Key("M-A-l", lazy.spawn(myLaTeXEditor)),
	Key("M-e", lazy.spawn(myFileManager)),
	Key("M-A-i", lazy.spawn(myBrowser)),
	Key("M-A-m", lazy.spawn(myMusicPlayer)),
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
	keys.append(Key("M-"+(k), lazy.group[group.name].toscreen()))			# Send current window to another group
	keys.append(Key("M-S-"+(k), lazy.window.togroup(group.name)))	# Send current window to another group

layout_theme = {"border_focus": "61AFEF", #colours[6]
				"border_normal": "848484", #colours[2]
				"margin": 4,
				"border_width": 2
				}

layouts = [
	#layout.Columns(**layout_theme),
	#layout.Matrix(**layout_theme),
	#layout.MonadWide(**layout_theme),
	#layout.RatioTile(**layout_theme),
	#layout.Slice(**layout_theme),
	#layout.Stack(num_stacks=2),
	#layout.Stack(stacks=2, **layout_theme),
	#layout.Tile(shift_windows=True, **layout_theme),
	#layout.VerticalTile(**layout_theme),
	#layout.Zoomy(**layout_theme),
	layout.Bsp(**layout_theme),
	layout.Floating(**layout_theme),
	layout.Max(**layout_theme),
	layout.MonadTall(**layout_theme)
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
		mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn("rofi -show drun")},
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
		mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn(myTerm + ' -e ytop')},
		fontsize=14,
		padding=0,
		text=' '
	),
	widget.CPU(
		foreground=colours[3],
		mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn(myTerm + ' -e ytop')},
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
		mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn(myTerm + ' -e ytop')},
		fontsize=14,
		padding=0,
		text='﬙ '
	),
	widget.Memory(
		foreground=colours[4],
		mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn(myTerm + ' -e ytop')},
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
	#	fontsize=12,
	#	padding=0,
	#	text=' '
	#),
	#widget.Backlight(
	#	foreground=colours[5],
	#	foreground_alert=colours[3],
	#	backlight_name='amdgpu_bl0', # ls /sys/class/backlight/
	#	change_command='brightnessctl set {0}',
	#	step=5
	#),
	widget.TextBox(
		font="JetBrainsMono Nerd Font Regular",
		foreground=colours[5],
		fontsize=14,
		padding=0,
		text=' '
	),
	widget.CheckUpdates(
		colour_have_updates=colours[5],
		colour_no_updates=colours[5],
	#	distro='Arch',
		custom_command='dnf updateinfo -q --list',
		display_format='{updates} Updates',
		no_update_string='Up to date!',
		update_interval=900
	),
	widget.Sep(
		foreground=colours[2],
		linewidth=1,
		padding=10
	),
	widget.TextBox(
		font="JetBrainsMono Nerd Font Regular",
		foreground=colours[6],
		mouse_callbacks = ({
			"Button1": lambda: qtile.cmd_spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
			"Button3": lambda: qtile.cmd_spawn("pavucontrol"),
			"Button4": lambda: qtile.cmd_spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
			"Button5": lambda: qtile.cmd_spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
        }),
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
	#widget.TextBox(
	#	font="JetBrainsMono Nerd Font Regular",
	#	foreground=colours[7],
	#	fontsize=14,
	#	padding=0,
	#	text='爵 '
	#),
	#widget.Net(
	#	foreground=colours[7],
	#	interface='enp1s0',
	#	format='{down}  '
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
	widget.TextBox(
		font="JetBrainsMono Nerd Font Regular",
		foreground=colours[8],
		fontsize=14,
		padding=0,
		text=' '
	),
	widget.Clock(
		foreground=colours[8],
		format='%a %b %d  %I:%M %P    '
	),
	#widget.StockTicker(
	#	apikey='AESKWL5CJVHHJKR5',
	#	url='https://www.alphavantage.co/query?'
	#	),
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
	Drag("M-1", lazy.window.set_position_floating(),
		start=lazy.window.get_position()),
	Drag("M-3", lazy.window.set_size_floating(),
		start=lazy.window.get_size()),
	Click("M-2", lazy.window.bring_to_front())
]

auto_fullscreen = True
bring_front_click = False
cursor_warp = False
dgroups_app_rules = []  # type: List
dgroups_key_binder = None
floating_layout = layout.Floating(float_rules=[
		*layout.Floating.default_float_rules,
		Match(title='Authentication'),
		Match(title='branchdialog'),
		Match(title='pinentry'),
		Match(wm_class='confirmreset'),
		Match(wm_class='makebranch'),
		Match(wm_class='maketag'),
		Match(wm_class='ssh-askpass'),
])
focus_on_window_activation = "smart"
follow_mouse_focus = True

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
