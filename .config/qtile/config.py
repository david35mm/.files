"""This script sets the base configuration for Qtile.

It consists of keybindings, layouts, widgets, rules and hooks.
An in depth documentation can be found at:
https://github.com/david35mm/.files/tree/main/.config/qtile
"""

import os
import shutil
import socket
import subprocess
from libqtile import bar
from libqtile import hook
from libqtile import layout
from libqtile import qtile
from libqtile import widget
from libqtile.config import EzClick as Click
from libqtile.config import EzDrag as Drag
from libqtile.config import EzKey as Key
from libqtile.config import Group
from libqtile.config import Match
from libqtile.config import Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List

mod = "mod4"
my_term = guess_terminal()
my_browser = "brave"
my_file_manager = "pcmanfm-qt"
my_markdown = "marktext"
my_music_player = my_term + " --class cmus,cmus -e cmus"
my_office_suite = "desktopeditors"
my_pdf_reader = "zathura"
my_text_editor = "subl"
my_video_player = "celluloid"

mouse = [
    Drag("M-1",
         lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag("M-3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click("M-2",
          lazy.window.bring_to_front()),
]

keys = [
    Key("M-C-r",
        lazy.restart(),
        desc="Restart Qtile"),
    Key("M-C-q",
        lazy.shutdown(),
        desc="Quit Qtile"),
    Key("M-S-j",
        lazy.layout.shuffle_up(),
        desc="Swap with previous window"),
    Key("M-S-k",
        lazy.layout.shuffle_down(),
        desc="Swap with next window"),
    Key("M-j",
        lazy.group.prev_window(),
        desc="Focus previous window"),
    Key("M-k",
        lazy.group.next_window(),
        desc="Focus next window"),
    Key("M-s",
        lazy.window.toggle_fullscreen(),
        desc="Fullscreen toogle"),
    Key("M-w",
        lazy.window.kill(),
        desc="Close the window"),
    Key("M-f",
        lazy.window.toggle_floating(),
        desc="Floating toggle"),
    Key("M-S-f",
        lazy.layout.flip(),
        desc="Flip master pane side"),
    Key("M-S-h",
        lazy.layout.shrink(),
        desc="Shrink window size"),
    Key("M-S-l",
        lazy.layout.grow(),
        desc="Expand window size"),
    Key("M-S-n",
        lazy.layout.reset(),
        desc="Normalize all windows size"),
    Key("M-<Tab>",
        lazy.next_layout(),
        desc="Cycle through layouts"),
    Key("M-h",
        lazy.layout.shrink_main(),
        desc="Shrink master pane width"),
    Key("M-l",
        lazy.layout.grow_main(),
        desc="Grow master pane width"),
    Key("M-n",
        lazy.layout.normalize(),
        desc="Normalize all slave windows size"),
    Key("M-<comma>",
        lazy.prev_screen(),
        desc="Focus the previous screen"),
    Key("M-<period>",
        lazy.next_screen(),
        desc="Focus the next screen"),
    Key("<XF86AudioLowerVolume>",
        lazy.spawn("pamixer -u -d 5"),
        desc="Decrease the volume"),
    Key("<XF86AudioMute>",
        lazy.spawn("pamixer -t"),
        desc="Mute toggle"),
    Key("<XF86AudioRaiseVolume>",
        lazy.spawn("pamixer -u -i 5"),
        desc="Increase the volume"),
    Key("<XF86MonBrightnessDown>",
        lazy.spawn("brightnessctl set 10%-"),
        desc="Decrease the brightness"),
    Key("<XF86MonBrightnessUp>",
        lazy.spawn("brightnessctl set 10%+"),
        desc="Increase the brightness"),
    Key("A-j",
        lazy.spawn("brightnessctl set 10%-"),
        desc="Decrease the brightness"),
    Key("A-k",
        lazy.spawn("brightnessctl set 10%+"),
        desc="Increase the brightness"),
    Key("M-r",
        lazy.spawn("rofi -show drun"),
        desc="Run the application launcher"),
    Key("M-A-r",
        lazy.spawn("rofi -show run"),
        desc="Launch the run prompt"),
    Key("A-<Tab>",
        lazy.spawn("rofi -show window"),
        desc="Open the window switcher"),
    Key("M-<Return>",
        lazy.spawn(my_term),
        desc="Launch " + my_term),
    Key("M-A-i",
        lazy.spawn(my_browser),
        desc="Launch " + my_browser),
    Key("M-e",
        lazy.spawn(my_file_manager),
        desc="Launch " + my_file_manager),
    Key("M-A-d",
        lazy.spawn(my_markdown),
        desc="Launch " + my_markdown),
    Key("M-A-m",
        lazy.spawn(my_music_player),
        desc="Launch " + my_music_player),
    Key("M-A-o",
        lazy.spawn(my_office_suite),
        desc="Launch " + my_office_suite),
    Key("M-A-p",
        lazy.spawn(my_pdf_reader),
        desc="Launch " + my_pdf_reader),
    Key("M-A-t",
        lazy.spawn(my_text_editor),
        desc="Launch " + my_text_editor),
    Key("M-A-v",
        lazy.spawn(my_video_player),
        desc="Launch " + my_video_player),
    Key("M-A-e",
        lazy.spawn(my_term + " -e vifm"),
        desc="Launch " + my_term + " -e vifm"),
    Key("M-A-s",
        lazy.spawn("spotify"),
        desc="Launch spotify"),
    Key("M-A-g",
        lazy.spawn("steam"),
        desc="Launch steam"),
]

groups = [
    Group("web",
          layout="max",
          matches=[
              Match(wm_class=["Brave-browser", "Min"]),
          ]),
    Group("dev",
          layout="monadtall",
          matches=[
              Match(wm_class=["Emacs", "jetbrains-idea", "Sublime_text"]),
          ]),
    Group("sys",
          layout="monadtall",
          matches=[
              Match(wm_class=["Lxappearance", "Nitrogen"]),
          ]),
    Group("doc",
          layout="monadtall",
          matches=[
              Match(wm_class=["DesktopEditors", "marktext", "Zathura"]),
          ]),
    Group("chat",
          layout="max",
          matches=[
              Match(wm_class=["TelegramDesktop"]),
          ]),
    Group("game",
          layout="floating"),
    Group("media",
          layout="max",
          matches=[
              Match(wm_class=["cmus", "Geeqie"]),
              Match(title=["Celluloid"]),
          ]),
    Group("gfx",
          layout="floating"),
]

for k, group in zip(["1", "2", "3", "4", "5", "6", "7", "8"], groups):
  keys.append(Key("M-" + (k), lazy.group[group.name].toscreen()))
  keys.append(Key("M-S-" + (k), lazy.window.togroup(group.name)))

colours = [
    ["#181b20", "#181b20"],  # Background
    ["#e6e6e6", "#e6e6e6"],  # Foreground
    ["#535965", "#535965"],  # Grey Colour
    ["#e55561", "#e55561"],
    ["#8ebd6b", "#8ebd6b"],
    ["#e2b86b", "#e2b86b"],
    ["#4fa6ed", "#4fa6ed"],
    ["#bf68d9", "#bf68d9"],
    ["#48b0bd", "#48b0bd"],
]

layout_theme = {
    "border_focus": colours[6],
    "border_normal": colours[2],
    "margin": 4,
    "border_width": 2,
}

layouts = [
    # layout.Bsp(**layout_theme),
    # layout.Columns(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Slice(**layout_theme),
    # layout.Stack(num_stacks=2),
    # layout.Stack(stacks=2, **layout_theme),
    # layout.Tile(shift_windows=True, **layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Zoomy(**layout_theme),
    layout.Floating(**layout_theme),
    layout.Max(**layout_theme),
    layout.MonadTall(**layout_theme),
]

prompt = f"{os.environ['USER']}@{socket.gethostname()}: "

widget_defaults = dict(background=colours[0],
                       foreground=colours[1],
                       font="Roboto Nerd Font Regular",
                       fontsize=12,
                       padding=1)

extension_defaults = widget_defaults.copy()

widgets = [
    widget.Sep(
        foreground=colours[0],
        linewidth=4),
    widget.Image(
        filename="~/.config/qtile/py.png",
        mouse_callbacks=({
            "Button1": lambda: qtile.cmd_spawn("rofi -show drun"),
            "Button3": lambda: qtile.cmd_spawn("rofi -show run"),
        }),
        scale=True),
    widget.Sep(
        foreground=colours[2],
        linewidth=1,
        padding=10),
    widget.GroupBox(
        active=colours[4],
        inactive=colours[6],
        other_current_screen_border=colours[5],
        other_screen_border=colours[2],
        this_current_screen_border=colours[7],
        this_screen_border=colours[2],
        urgent_border=colours[3],
        urgent_text=colours[3],
        disable_drag=True,
        highlight_method="text",
        invert_mouse_wheel=True,
        margin=2,
        padding=0,
        rounded=True,
        urgent_alert_method="text"),
    widget.Sep(
        foreground=colours[2],
        linewidth=1,
        padding=10),
    widget.CurrentLayout(
        foreground=colours[7],
        font="Roboto Nerd Font Bold"),
    widget.Systray(
        icon_size=14,
        padding=4),
    widget.Cmus(
        noplay_color=colours[2],
        play_color=colours[1]),
    widget.Sep(
        foreground=colours[2],
        linewidth=1,
        padding=10),
    widget.WindowName(
        max_chars=75),
    # widget.Backlight(
    #     foreground=colours[3],
    #     foreground_alert=colours[3],
    #     format=" {percent:2.0%}",
    #     backlight_name="amdgpu_bl0", # ls /sys/class/backlight/
    #     change_command="brightnessctl set {0}%",
    #     step=10),
    widget.CPU(
        foreground=colours[3],
        format=" {load_percent}%",
        mouse_callbacks={
            "Button1": lambda: qtile.cmd_spawn(my_term + " -e ytop"),
        },
        update_interval=1.0),
    widget.Sep(
        foreground=colours[2],
        linewidth=1,
        padding=10),
    widget.Memory(
        foreground=colours[4],
        format="﬙ {MemUsed:.0f} MB",
        mouse_callbacks={
            "Button1": lambda: qtile.cmd_spawn(my_term + " -e ytop"),
        },
        update_interval=1.0),
    widget.Sep(
        foreground=colours[2],
        linewidth=1,
        padding=10),
    widget.CheckUpdates(
        colour_have_updates=colours[5],
        colour_no_updates=colours[5],
        custom_command="checkupdates",
        # custom_command="dnf updateinfo -q --list",
        display_format=" {updates} Updates",
        # execute="pkexec /usr/bin/dnf up -y",
        execute="pkexec /usr/bin/pacman -Syu --noconfirm",
        no_update_string=" Up to date!",
        update_interval=900),
    widget.Sep(
        foreground=colours[2],
        linewidth=1,
        padding=10),
    widget.PulseVolume(
        foreground=colours[6],
        fmt="墳 {}",
        update_interval=0.1,
        volume_app="pavucontrol",
        step=5),
    widget.Sep(
        foreground=colours[2],
        linewidth=1,
        padding=10),
    # widget.Net(
    #     foreground = colours[7],
    #     format = "爵 {down}  ",
    #     interface = "enp1s0"),
    widget.Battery(
        foreground=colours[7],
        format="{char} {percent:2.0%}",
        charge_char=" ",
        discharge_char=" ",
        empty_char=" ",
        full_char=" ",
        unknown_char=" ",
        low_foreground=colours[3],
        low_percentage=0.15,
        show_short_text=False,
        notify_below=15),
    widget.Sep(
        foreground=colours[2],
        linewidth=1,
        padding=10),
    widget.Clock(
        foreground=colours[8],
        format=" %a %b %d  %I:%M %P    "),
    # widget.StockTicker(
    #     apikey="AESKWL5CJVHHJKR5",
    #     url="https://www.alphavantage.co/query?"),
]

def status_bar(widget_list):
  return bar.Bar(widget_list, 18, opacity=1.0)

screens = [
    Screen(
        top=status_bar(widgets),
        wallpaper="/usr/share/wallpapers/deepin/Overlooking_by_Lance_Asper.jpg",
        wallpaper_mode="stretch"),
]

connected_monitors = (subprocess.run(
    "xrandr | busybox grep 'connected' | busybox cut -d' ' -f2",
    check=True,
    shell=True,
    stdout=subprocess.PIPE,
).stdout.decode("UTF-8").split("\n")[:-1].count("connected"))

if connected_monitors > 1:
  for i in range(1, connected_monitors):
    screens.append(
        Screen(
            top=status_bar(widgets),
            wallpaper=
                "/usr/share/wallpapers/deepin/Overlooking_by_Lance_Asper.jpg",
            wallpaper_mode="stretch"))

auto_fullscreen = True
auto_minimize = True
bring_front_click = False
cursor_warp = False
dgroups_app_rules = [] 
dgroups_key_binder = None
floating_layout = layout.Floating(
    **layout_theme,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(title="Authentication"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
        Match(wm_class="Arandr"),
        Match(wm_class="Blueman-adapters"),
        Match(wm_class="Blueman-manager"),
        Match(wm_class="confirm"),
        Match(wm_class="confirmreset"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="Gnome-screenshot"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="notification"),
        Match(wm_class="Pavucontrol"),
        Match(wm_class="splash"),
        Match(wm_class="ssh-askpass"),
        Match(wm_class="toolbar"),
    ])
focus_on_window_activation = "smart"
follow_mouse_focus = True
reconfigure_screens = True

# pylint: disable=consider-using-with
@hook.subscribe.restart
def delete_cache():
  shutil.rmtree(os.path.expanduser("~/.config/qtile/__pycache__"))

@hook.subscribe.shutdown
def stop_apps():
  delete_cache()
  subprocess.Popen(["killall", "dunst", "emacs", "lxpolkit", "picom",
                    "pipewire", "pipewire-pulse", "wireplumber", "udiskie"])

@hook.subscribe.startup_once
def start_apps():
  subprocess.Popen(["dunst"])
  subprocess.Popen(["emacs", "--daemon"])
  subprocess.Popen(["lxpolkit"])
  subprocess.Popen(["picom", "-b"])
  subprocess.Popen(["pipewire"])
  subprocess.Popen(["pipewire-pulse"])
  subprocess.Popen(["wireplumber"])
  subprocess.Popen(["udiskie", "-asn", "-f", "pcmanfm-qt"])

wmname = "LG3D"
