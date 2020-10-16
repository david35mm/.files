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
myOfficeSuite = "onlyoffice"
myLaTeXEditor = "gnome-latex"
myMusicPlayer = "rhythmbox"
myConfig = "~/.config/qtile/config.py"

keys = [
	# Qtile controls
	Key([mod, "control"], "r", lazy.restart()),
	Key([mod, "control"], "q", lazy.shutdown()),

	# Window controls
	Key([mod], "k", lazy.layout.down()),
	Key([mod], "j", lazy.layout.up()),
	Key([mod], "w", lazy.window.kill()),
	Key([mod], "f", lazy.window.toggle_floating()),
	Key([mod], "s", lazy.window.toggle_fullscreen()),

	# Increase and decrease windows size
	Key([mod], "l", lazy.layout.grow(),lazy.layout.increase_nmaster()),
	Key([mod], "h",lazy.layout.shrink(),lazy.layout.decrease_nmaster()),

	# Move windows up or down in current stack
	Key([mod, "control"], "k", lazy.layout.shuffle_down()),
	Key([mod, "control"], "j", lazy.layout.shuffle_up()),

	# Switch window focus to other pane(s) of stack
	Key([mod], "space", lazy.layout.next()),

	# Toggle between different layouts as defined below
	Key([mod], "Tab", lazy.next_layout()),

	# System Controls
	Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
	Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
	Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
	Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
	Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
	#Key(["mod1"], "k", lazy.spawn("brightnessctl set +10%")),
	#Key(["mod1"], "j", lazy.spawn("brightnessctl set 10%-")),

	# Applications launcher
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
	Key(["mod1"], "Tab", lazy.spawn("rofi -show window")),
	Key([mod, "mod1"], "r", lazy.spawn("rofi -show run")),
	Key([mod], "r", lazy.spawn("rofi -show drun")),
]

group_names	=	[("web", {'layout': 'max'}),
				 ("dev", {'layout': 'monadtall'}),
				 ("sys", {'layout': 'bsp'}),
				 ("doc", {'layout': 'bsp'}),
				 ("chat", {'layout': 'monadtall'}),
				 ("game", {'layout': 'max'}),
				 ("media", {'layout': 'max'}),
				 ("gfx", {'layout': 'floating'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
	keys.append(Key([mod], str(i), lazy.group[name].toscreen()))		# Switch to another group
	keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))	# Send current window to another group

layout_theme = {"border_width": 2,
				"margin": 4,
				"border_focus": "205E74", #colours[4]
				"border_normal": "606970" #colours[7]
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

colours = [["#1A1211", "#1A1211"], # Background
		   ["#A8BAB3", "#A8BAB3"], # Foreground
		   ["#75827D", "#75827D"], # Grey Colour
		   ["#324F6B", "#324F6B"],
		   ["#205E74", "#205E74"],
		   ["#494956", "#494956"],
		   ["#49546A", "#49546A"],
		   ["#606970", "#606970"],
		   ["#897B75", "#897B75"]]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

widget_defaults = dict(background= colours[0],
	foreground='EDEFF2',
	font="SF Pro Text Regular",
	fontsize = 12,
	padding = 2)
extension_defaults = widget_defaults.copy()

screens = [
	Screen(
		top=bar.Bar(
			[
			widget.Sep(
				foreground=colours[0],
				linewidth=2
				),
			widget.Image(
				scale=True,
				mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn("rofi -show drun")},
				filename="~/.config/qtile/py.png"
				),
			widget.TextBox(
				font="JetBrainsMono Nerd Font Regular",
				fontsize=16,
				width=22,
				foreground=colours[2],
				background=colours[0],
				text='\uE0BA'
				),
			widget.GroupBox(
				background=colours[2],
				padding=0,
				active=colours[0],
				inactive='C8CACC',
				highlight_color=colours[5],
				highlight_method='line',
				this_current_screen_border=colours[5]
				),
			widget.TextBox(
				font="JetBrainsMono Nerd Font Regular",
				fontsize=16,
				width=22,
				foreground=colours[0],
				background=colours[2],
				text='\uE0BA'
				),
			widget.CurrentLayout(
				font="SF Pro Text Semibold",
				foreground='477AB3'
				),
			widget.Systray(
				),
			widget.Cmus(
				play_color='FFFFFF',
				noplay_color='C8CACC'
				),
			widget.Sep(
				foreground='C8CACC',
				padding=8
				),
			widget.WindowName(
				),
			widget.TextBox(
				font="JetBrainsMono Nerd Font Regular",
				fontsize=16,
				width=22,
				foreground=colours[3],
				text='\uE0BA'
				),
			widget.TextBox(
				font="JetBrainsMono Nerd Font Regular",
				background=colours[3],
				fontsize=14,
				padding=0,
				text='﬙ '
				),
			widget.CPU(
				background=colours[3],
				mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e ytop')},
				format='{load_percent}%',
				update_interval=1.0
				),
			widget.TextBox(
				font="JetBrainsMono Nerd Font Regular",
				fontsize=16,
				width=22,
				foreground=colours[4],
				background=colours[3],
				text='\uE0BA'
				),
			widget.TextBox(
				font="JetBrainsMono Nerd Font Regular",
				background=colours[4],
				fontsize=14,
				padding=0,
				text=' '
				),
			widget.Memory(
				background=colours[4],
				mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e htop')},
				format='{MemUsed} MB'
				),
			widget.TextBox(
				font="JetBrainsMono Nerd Font Regular",
				fontsize=16,
				width=22,
				foreground=colours[5],
				background=colours[4],
				text='\uE0BA'
				),
			widget.TextBox(
				font="JetBrainsMono Nerd Font Regular",
				background=colours[5],
				fontsize=14,
				padding=0,
				text=' '
				),
			widget.ThermalSensor(
				background=colours[5],
				threshold=80,
				foreground_alert='DE935F'
				),
			widget.TextBox(
				font="JetBrainsMono Nerd Font Regular",
				fontsize=16,
				width=22,
				foreground=colours[6],
				background=colours[5],
				text='\uE0BA'
				),
			widget.TextBox(
				background=colours[6],
				text='Vol.'
				),
			widget.Volume(
				background=colours[6],
				step=5
				),
			widget.TextBox(
				font="JetBrainsMono Nerd Font Regular",
				fontsize=16,
				width=22,
				foreground=colours[7],
				background=colours[6],
				text='\uE0BA'
				),
			#widget.Image(
			#	scale=True,
			#	filename="~/.config/qtile/2.png"
			#	),
			#widget.Net(
			#	background=colours[7],
			#	interface='enp1s0',
			#	format='NET {down} ↓↑ {up}'
			#	),
			#widget.StockTicker(
			#	apikey='AESKWL5CJVHHJKR5',
			#	url='https://www.alphavantage.co/query?'
			#	),
			widget.TextBox(
				background=colours[7],
				text='Power'),
			widget.Battery(
				background=colours[7],
				format='{char} {percent:2.0%}',
				low_foreground='DE935F'
				),
			widget.TextBox(
				font="JetBrainsMono Nerd Font Regular",
				fontsize=16,
				width=22,
				foreground=colours[8],
				background=colours[7],
				text='\uE0BA'
				),
			widget.Clock(
				background=colours[8],
				format='%a %b %d  %I:%M %P    '
				)
			],
			18,
		),
	)
]

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