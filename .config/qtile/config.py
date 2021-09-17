import os, re, shutil, socket, subprocess
from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import EzClick as Click, EzDrag as Drag, EzKey as Key, Group, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List

mod = "mod4"
myTerm = guess_terminal()
myBrowser = "brave-browser"
myFileManager = "pcmanfm"
myMarkdown = "marktext"
myMusicPlayer = myTerm + " --class cmus,cmus -e cmus"
myOfficeSuite = "desktopeditors"
myPDFReader = "zathura"
myTextEditor = "subl"
myVideoPlayer = "celluloid"

keys = [
	# Qtile Controls
	Key("M-C-r", lazy.restart(), desc="Restart Qtile"),
	Key("M-C-q", lazy.shutdown(), desc="Quit Qtile"),

	# Window Controls
	Key("M-S-j", lazy.layout.shuffle_up(), desc="Swap with previous window"),
	Key("M-S-k", lazy.layout.shuffle_down(), desc="Swap with next window"),
	Key("M-j", lazy.group.prev_window(), desc="Focus previous window"),
	Key("M-k", lazy.group.next_window(), desc="Focus next window"),
	Key("M-f", lazy.window.toggle_floating(), desc="Floating toggle"),
	Key("M-s", lazy.window.toggle_fullscreen(), desc="Fullscreen toogle"),
	Key("M-w", lazy.window.kill(), desc="Close the window"),

	# Layout Controls
	Key("M-<Tab>", lazy.next_layout(), desc="Cycle through layouts"),
	Key("M-S-h", lazy.layout.shrink(), desc="Shrink window size"),
	Key("M-S-l", lazy.layout.grow(), desc="Expand window size"),
	Key("M-h", lazy.layout.shrink_main(), desc="Shrink master pane width"),
	Key("M-l", lazy.layout.grow_main(), desc="Grow master pane width"),
	Key("M-S-f", lazy.layout.flip(), desc="Flip master pane side"),
	Key("M-S-n", lazy.layout.reset(), desc="Normalize all windows size"),
	Key("M-n", lazy.layout.normalize(), desc="Normalize all slave windows size"),


	# Multi-Screen Focus
	Key("M-<comma>", lazy.prev_screen(), desc="Focus the previous screen"),
	Key("M-<period>", lazy.next_screen(), desc="Focus the next screen"),

	# System Controls
	Key("<XF86AudioLowerVolume>", lazy.spawn("pamixer -u -d 5"), desc="Decrease the volume"),
	Key("<XF86AudioMute>", lazy.spawn("pamixer -t"), desc="Mute toggle"),
	Key("<XF86AudioRaiseVolume>", lazy.spawn("pamixer -u -i 5"), desc="Increase the volume"),
	Key("<XF86MonBrightnessDown>", lazy.spawn("brightnessctl set 10%-"), desc="Decrease the brightness"),
	Key("<XF86MonBrightnessUp>", lazy.spawn("brightnessctl set 10%+"), desc="Increase the brightness"),
	Key("A-j", lazy.spawn("brightnessctl set 10%-"), desc="Decrease the brightness"),
	Key("A-k", lazy.spawn("brightnessctl set 10%+"), desc="Increase the brightness"),

	# Applications Launcher
	Key("M-r", lazy.spawn("rofi -show drun"), desc="Run the application launcher"),
	Key("M-A-r", lazy.spawn("rofi -show run"), desc="Launch the run prompt"),
	Key("A-<Tab>", lazy.spawn("rofi -show window"), desc="Open the window switcher"),
	Key("M-<Return>", lazy.spawn(myTerm), desc="Launch " + myTerm),
	Key("M-A-i", lazy.spawn(myBrowser), desc="Launch " + myBrowser),
	Key("M-e", lazy.spawn(myFileManager), desc="Launch " + myFileManager),
	Key("M-A-d", lazy.spawn(myMarkdown), desc="Launch " + myMarkdown),
	Key("M-A-m", lazy.spawn(myMusicPlayer), desc="Launch " + myMusicPlayer),
	Key("M-A-o", lazy.spawn(myOfficeSuite), desc="Launch " + myOfficeSuite),
	Key("M-A-p", lazy.spawn(myPDFReader), desc="Launch " + myPDFReader),
	Key("M-A-t", lazy.spawn(myTextEditor), desc="Launch " + myTextEditor),
	Key("M-A-v", lazy.spawn(myVideoPlayer), desc="Launch " + myVideoPlayer),
	Key("M-A-e", lazy.spawn(myTerm + " -e vifm"), desc="Launch " + myTerm + " -e vifm"),
	Key("M-A-s", lazy.spawn("spotify"), desc="Launch spotify"),
	Key("M-A-g", lazy.spawn("steam"), desc="Launch steam"),
]

groups = [
	Group("web", layout="max", matches=[Match(wm_class=["Brave-browser", "Min"])]),
	Group("dev", layout="monadtall", matches=[Match(wm_class=["Emacs", "jetbrains-idea", "Sublime_text"])]),
	Group("sys", layout="monadtall", matches=[Match(wm_class=["Lxappearance", "Nitrogen"])]),
	Group("doc", layout="monadtall", matches=[Match(wm_class=["DesktopEditors", "marktext", "Zathura"])]),
	Group("chat", layout="max", matches=[Match(wm_class=["TelegramDesktop"])]),
	Group("game", layout="floating"),
	Group("media", layout="max", matches=[Match(wm_class=["cmus", "Geeqie"]), Match(title=["Celluloid"])]),
	Group("gfx", layout="floating"),
]

for k, group in zip(["1", "2", "3", "4", "5", "6", "7", "8"], groups):
	keys.append(Key("M-"+(k), lazy.group[group.name].toscreen()))
	keys.append(Key("M-S-"+(k), lazy.window.togroup(group.name)))

layout_theme = {
	"border_focus": "#61AFEF",
	"border_normal": "#848484",
	"margin": 4,
	"border_width": 2,
}

layouts = [
	#layout.Bsp(**layout_theme),
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
	layout.Floating(**layout_theme),
	layout.Max(**layout_theme),
	layout.MonadTall(**layout_theme),
]

colours = [["#080808", "#080808"], # Background
		   ["#FFFFFF", "#FFFFFF"], # Foreground
		   ["#ABB2BF", "#ABB2BF"], # Grey Colour
		   ["#E35374", "#E35374"],
		   ["#89CA78", "#89CA78"],
		   ["#F0C674", "#F0C674"],
		   ["#61AFEF", "#61AFEF"],
		   ["#D55FDE", "#D55FDE"],
		   ["#2BBAC5", "#2BBAC5"]]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

widget_defaults = dict(
	background = colours[0],
	foreground = colours[1],
	font = "SF Pro Text Regular",
	fontsize = 12,
	padding = 1,
)

extension_defaults = widget_defaults.copy()

widgets = [
	widget.Sep(
		foreground = colours[0],
		linewidth = 4,
	),
	widget.Image(
		filename = "~/.config/qtile/py.png",
		mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn("rofi -show drun")},
		scale = True,
	),
	widget.Sep(
		foreground = colours[2],
		linewidth = 1,
		padding = 10,
	),
	widget.GroupBox(
		active = colours[4],
		inactive = colours[6],
		other_current_screen_border = colours[5],
		other_screen_border = colours[2],
		this_current_screen_border = colours[7],
		this_screen_border = colours[2],
		urgent_border = colours[3],
		urgent_text = colours[3],
		disable_drag = True,
		highlight_method = "text",
		invert_mouse_wheel = True,
		margin = 2,
		padding = 0,
		rounded = True,
		urgent_alert_method = "text",
	),
	widget.Sep(
		foreground = colours[2],
		linewidth = 1,
		padding = 10,
	),
	widget.CurrentLayout(
		foreground = colours[7],
		font = "SF Pro Text Semibold",
	),
	widget.Systray(
		icon_size = 14,
		padding = 4,
	),
	widget.Cmus(
		noplay_color = colours[2],
		play_color = colours[1],
	),
	widget.Sep(
		foreground = colours[2],
		linewidth = 1,
		padding = 10,
	),
	widget.WindowName(
		max_chars = 75,
	),
	widget.TextBox(
		foreground = colours[3],
		font = "SF Mono Regular",
		fontsize = 14,
		mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn(myTerm + " -e ytop")},
		padding = 0,
		text = " "
	),
	widget.CPU(
		foreground = colours[3],
		format = "{load_percent}%",
		mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn(myTerm + " -e ytop")},
		update_interval = 1.0,
	),
	widget.Sep(
		foreground = colours[2],
		linewidth = 1,
		padding = 10,
	),
	widget.TextBox(
		foreground = colours[4],
		font = "SF Mono Regular",
		fontsize = 14,
		mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn(myTerm + " -e ytop")},
		padding = 0,
		text = "﬙ ",
	),
	widget.Memory(
		foreground = colours[4],
		format = "{MemUsed:.0f} MB",
		mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn(myTerm + " -e ytop")},
		update_interval = 1.0,
	),
	widget.Sep(
		foreground = colours[2],
		linewidth = 1,
		padding = 10,
	),
	#widget.TextBox(
	#	foreground = colours[5],
	#	font = "SF Mono Regular",
	#	fontsize = 12,
	#	padding = 0,
	#	text = " ",
	#),
	#widget.Backlight(
	#	foreground = colours[5],
	#	foreground_alert = colours[3],
	#	backlight_name = "amdgpu_bl0", # ls /sys/class/backlight/
	#	change_command = "brightnessctl set {0}",
	#	step = 5,
	#),
	widget.TextBox(
		foreground = colours[5],
		font = "SF Mono Regular",
		fontsize = 14,
		padding = 0,
		text = " ",
	),
	widget.CheckUpdates(
		colour_have_updates = colours[5],
		colour_no_updates = colours[5],
		custom_command = "checkupdates",
	#	custom_command = "dnf updateinfo -q --list",
		display_format = "{updates} Updates",
	#	execute = "pkexec /usr/bin/dnf up -y",
		execute = "pkexec /usr/bin/pacman -Syu --noconfirm",
		no_update_string = "Up to date!",
		update_interval = 900,
	),
	widget.Sep(
		foreground = colours[2],
		linewidth = 1,
		padding = 10,
	),
	widget.TextBox(
		foreground = colours[6],
		font = "SF Mono Regular",
		fontsize = 14,
		mouse_callbacks = ({
			"Button1": lambda: qtile.cmd_spawn("pamixer -t"),
			"Button3": lambda: qtile.cmd_spawn("pavucontrol"),
			"Button4": lambda: qtile.cmd_spawn("pamixer -u -i 5"),
			"Button5": lambda: qtile.cmd_spawn("pamixer -u -d 5"),
		}),
		padding = 0,
		text = "墳 ",
	),
	widget.PulseVolume(
		foreground = colours[6],
		update_interval = 0.1,
		volume_app = "pavucontrol",
		step = 5,
	),
	widget.Sep(
		foreground = colours[2],
		linewidth = 1,
		padding = 10,
	),
	#widget.TextBox(
	#	foreground = colours[7],
	#	font = "SF Mono Regular",
	#	fontsize = 14,
	#	padding = 0,
	#	text = "爵 ",
	#),
	#widget.Net(
	#	foreground = colours[7],
	#	format = "{down}  ",
	#	interface = "enp1s0",
	#),
	widget.Battery(
		foreground = colours[7],
		low_foreground = colours[3],
		charge_char = " ",
		discharge_char = " ",
		empty_char = " ",
		full_char = " ",
		unknown_char = " ",
		font = "SF Mono Regular",
		fontsize = 14,
		format = "{char}",
		low_percentage = 0.15,
		padding = 0,
		show_short_text = False,
	),
	widget.Battery(
		foreground = colours[7],
		low_foreground = colours[3],
		format = "{percent:2.0%}",
		low_percentage = 0.15,
		notify_below = 15,
	),
	widget.Sep(
		foreground = colours[2],
		linewidth = 1,
		padding = 10,
	),
	widget.TextBox(
		foreground = colours[8],
		font = "SF Mono Regular",
		fontsize = 14,
		padding = 0,
		text = " ",
	),
	widget.Clock(
		foreground = colours[8],
		format = "%a %b %d  %I:%M %P    ",
	),
	#widget.StockTicker(
	#	apikey = "AESKWL5CJVHHJKR5",
	#	url = "https://www.alphavantage.co/query?"
	#),
]

status_bar = lambda widgets: bar.Bar(widgets, 18, opacity=1.0)

screens = [Screen(top=status_bar(widgets), wallpaper="/usr/share/wallpapers/deepin/Overlooking_by_Lance_Asper.jpg", wallpaper_mode="stretch")]

connected_monitors = subprocess.run(
	"xrandr | grep 'connected' | cut -d ' ' -f 2",
	shell = True,
	stdout = subprocess.PIPE,
).stdout.decode("UTF-8").split("\n")[:-1].count("connected")

if connected_monitors > 1:
	for i in range(1, connected_monitors):
		screens.append(Screen(top=status_bar(widgets), wallpaper="/usr/share/wallpapers/deepin/Overlooking_by_Lance_Asper.jpg", wallpaper_mode="stretch"))

mouse = [
	Drag("M-1", lazy.window.set_position_floating(),
		start = lazy.window.get_position()),
	Drag("M-3", lazy.window.set_size_floating(),
		start  = lazy.window.get_size()),
	Click("M-2", lazy.window.bring_to_front()),
]

auto_fullscreen = True
auto_minimize = True
bring_front_click = False
cursor_warp = False
dgroups_app_rules = [] # type: List
dgroups_key_binder = None
floating_layout = layout.Floating(**layout_theme,
	float_rules=[
		*layout.Floating.default_float_rules,
		Match(title="Authentication"),
		Match(title="branchdialog"),
		Match(title="pinentry"),
		Match(wm_class="Arandr"),
		Match(wm_class="Blueman-adapters"),
		Match(wm_class="Blueman-manager"),
		Match(wm_class="confirmreset"),
		Match(wm_class="makebranch"),
		Match(wm_class="maketag"),
		Match(wm_class="Pavucontrol"),
		Match(wm_class="ssh-askpass"),
	]
)
focus_on_window_activation = "smart"
follow_mouse_focus = True
reconfigure_screens = True

@hook.subscribe.restart
def cleanup():
	shutil.rmtree(os.path.expanduser("~/.config/qtile/__pycache__"))

@hook.subscribe.shutdown
def killall():
	shutil.rmtree(os.path.expanduser("~/.config/qtile/__pycache__"))
	subprocess.Popen(["killall","dunst","lxpolkit","picom"])

@hook.subscribe.startup_complete
def checkupdts():
	subprocess.Popen(os.path.expanduser("~/.config/qtile/checkupdts.sh"))

@hook.subscribe.startup_once
def autostart():
	subprocess.Popen(["dunst"])
	subprocess.Popen(["lxpolkit"])
	subprocess.Popen(["picom","-b"])
	#subprocess.Popen(["emacs","--daemon"])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
