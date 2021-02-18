# -*- encoding: utf-8 -*-
#
# Author::  Christoph Kappel <unexist@subforge.org>
# Version:: $Id: data/subtle.rb,v 3278 1517559402.0-3600 unexist $
# License:: GNU GPLv2
#
# = Subtle default configuration
#
# This file will be installed as default and can also be used as a starter for
# an own custom configuration file. The system wide config usually resides in
# +/etc/xdg/subtle+ and the user config in +HOME/.config/subtle+, both locations
# are dependent on the locations specified by +XDG_CONFIG_DIRS+ and
# +XDG_CONFIG_HOME+.
#

#
# == Options
#
# Following options change behaviour and sizes of the window manager:
#

# Window move/resize steps in pixel per keypress
set :increase_step, 5

# Window screen border snapping
set :border_snap, 10

# Default starting gravity for windows. Comment out to use gravity of
# currently active client
set :default_gravity, :center

# Make dialog windows urgent and draw focus
set :urgent_dialogs, false

# Honor resize size hints globally
set :honor_size_hints, false

# Enable gravity tiling for all gravities
set :gravity_tiling, false

# Enable click-to-focus focus model
set :click_to_focus, false

# Skip pointer movement on e.g. gravity change
set :skip_pointer_warp, false

# Skip pointer movement to urgent windows
set :skip_urgent_warp, false

# Set the WM_NAME of subtle (Java quirk)
# set :wmname, "LG3D"

#
# == Styles
#
# Styles define various properties of styleable items in a CSS-like syntax.
#
# Following properties are available for most the styles:
#
# [*foreground*] Foreground text color
# [*background*] Background color
# [*margin*]     Outer spacing
# [*border*]     Border color and size
# [*padding*]    Inner spacing
# [*font*]       Font string (xftontsel or xft)
#
# The styles also define the styling and appearance of the two possible
# panels per screen in subtle. Each panel can be configured with different
# panel items and sublets screen wise. The default config uses a top panel
# on the first screen only, it's up to the user to enable the bottom panel or
# disable either one # or both.
#
# Following items are available for the panels:
#
# [*:views*]     List of views with buttons
# [*:title*]     Title of the current active window
# [*:tray*]      Systray icons (Can be used only once)
# [*:keychain*]  Display current chain (Can be used only once)
# [*:sublets*]   Catch-all for installed sublets
# [*:sublet*]    Name of a sublet for direct placement
# [*:spacer*]    Variable spacer (free width / count of spacers)
# [*:center*]    Enclose items with :center to center them on the panel
# [*:separator*] Insert separator

# Empty panels are hidden.
#
# === Links
#
# https://subforge.org/projects/subtle/wiki/Styles
# https://subforge.org/projects/subtle/wiki/Multihead
# https://subforge.org/projects/subtle/wiki/Panel

# Style for all style elements
style :all do
  foreground  "#61AFEF"
  background  "#141414"
  icon        "#FFFFFF"
  padding     0, 3
  font        "xft:SF Pro Text-10"
  #font        "xft:sans-8"
end

# Style for the all views
style :views do
  # Style for the active views
  style :focus do
    foreground  "#C678DD"
  end

  # Style for urgent window titles and views
  style :urgent do
    foreground  "#E35374"
  end

  # Style for occupied views (views with clients)
  style :occupied do
    foreground  "#98C379"
  end
end

# Style for sublets
style :sublets do
end

# Style for separator
style :separator do
  separator   "|"
end

# Style for focus window title
style :title do
  foreground  "#FFFFFF"
end

# Style for active/inactive windows
style :clients do
  active    "#61AFEF", 2
  inactive  "#848484", 2
  margin    4
  width     50
end

# Style for tray
style :tray do
end

# Style for top panels
style :panel_top do
  screen 1, [ :views, :title, :spacer, :keychain, :spacer, :tray, :sublets ]
  #screen 2, [ :views ]
end

# Style for bottom panels
style :panel_bottom do
  screen 1, [ ]
  #screen 2, [ ]
end

#
# == Gravities
#
# Gravities are predefined sizes a window can be set to. There are several ways
# to set a certain gravity, most convenient is to define a gravity via a tag or
# change them during runtime via grab. Subtler and subtlext can also modify
# gravities.
#
# A gravity consists of four values which are a percentage value of the screen
# size. The first two values are x and y starting at the center of the screen
# and he last two values are the width and height.
#
# === Example
#
# Following defines a gravity for a window with 100% width and height:
#
#   gravity :example, [ 0, 0, 100, 100 ]
#
# === Link
#
# https://subforge.org/projects/subtle/wiki/Gravity
#

# Top left
gravity :top_left,       [   0,   0,  50,  50 ]
gravity :top_left66,     [   0,   0,  50,  66 ]
gravity :top_left33,     [   0,   0,  50,  34 ]

# Top
gravity :top,            [   0,   0, 100,  50 ]
gravity :top66,          [   0,   0, 100,  66 ]
gravity :top33,          [   0,   0, 100,  34 ]

# Top right
gravity :top_right,      [  50,   0,  50,  50 ]
gravity :top_right66,    [  50,   0,  50,  66 ]
gravity :top_right33,    [  50,   0,  50,  33 ]

# Left
gravity :left,           [   0,   0,  50, 100 ]
gravity :left66,         [   0,   0,  66, 100 ]
gravity :left33,         [   0,   0,  33, 100 ]

# Center
gravity :center,         [   0,   0, 100, 100 ]
gravity :center66,       [  17,  17,  66,  66 ]
gravity :center33,       [  33,  33,  33,  33 ]

# Right
gravity :right,          [  50,   0,  50, 100 ]
gravity :right66,        [  34,   0,  66, 100 ]
gravity :right33,        [  67,   0,  33, 100 ]

# Bottom left
gravity :bottom_left,    [   0,  50,  50,  50 ]
gravity :bottom_left66,  [   0,  34,  50,  66 ]
gravity :bottom_left33,  [   0,  67,  50,  33 ]

# Bottom
gravity :bottom,         [   0,  50, 100,  50 ]
gravity :bottom66,       [   0,  34, 100,  66 ]
gravity :bottom33,       [   0,  67, 100,  33 ]

# Bottom right
gravity :bottom_right,   [  50,  50,  50,  50 ]
gravity :bottom_right66, [  50,  34,  50,  66 ]
gravity :bottom_right33, [  50,  67,  50,  33 ]

# Gimp
gravity :gimp_image,     [  10,   0,  80, 100 ]
gravity :gimp_toolbox,   [   0,   0,  10, 100 ]
gravity :gimp_dock,      [  90,   0,  10, 100 ]

#
# == Grabs
#
# Grabs are keyboard and mouse actions within subtle, every grab can be
# assigned either to a key and/or to a mouse button combination. A grab
# consists of a chain and an action.
#
# === Finding keys
#
# The best resource for getting the correct key names is
# */usr/include/X11/keysymdef.h*, but to make life easier here are some hints
# about it:
#
# * Numbers and letters keep their names, so *a* is *a* and *0* is *0*
# * Keypad keys need *KP_* as prefix, so *KP_1* is *1* on the keypad
# * Strip the *XK_* from the key names if looked up in
#   /usr/include/X11/keysymdef.h
# * Keys usually have meaningful english names
# * Modifier keys have special meaning (Alt (A), Control (C), Meta (M),
#   Shift (S), Super (W))
#
# === Chaining
#
# Chains are a combination of keys and modifiers to one or a list of keys
# and can be used in various ways to trigger an action. In subtle, there are
# two ways to define chains for grabs:
#
#   1. *Default*: Add modifiers to a key and use it for a grab
#
#      *Example*: grab "W-Return", "urxvt"
#
#   2. *Chain*: Define a list of grabs that need to be pressed in order
#
#      *Example*: grab "C-y Return", "urxvt"
#
# ==== Mouse buttons
#
# [*B1*]  = Button1 (Left mouse button)
# [*B2*]  = Button2 (Middle mouse button)
# [*B3*]  = Button3 (Right mouse button)
# [*B4*]  = Button4 (Mouse wheel up)
# [*B5*]  = Button5 (Mouse wheel down)
# [*...*]
# [*B20*] = Button20 (Are you sure that this is a mouse and not a keyboard?)
#
# ==== Modifiers
#
# [*A*] = Alt key (Mod1)
# [*C*] = Control key
# [*M*] = Meta key (Mod3)
# [*S*] = Shift key
# [*W*] = Super/Windows key (Mod4)
# [*G*] = Alt Gr (Mod5)
#
# === Action
#
# An action is something that happens when a grab is activated, this can be one
# of the following:
#
# [*symbol*] Run a subtle action
# [*string*] Start a certain program
# [*array*]  Cycle through gravities
# [*lambda*] Run a Ruby proc
#
# === Example
#
# This will create a grab that starts a urxvt when Alt+Enter are pressed:
#
#   grab "A-Return", "urxvt"
#   grab "C-a c",    "urxvt"
#
# === Link
#
# https://subforge.org/projects/subtle/wiki/Grabs
#

# Jump to view1, view2, ...
grab "W-S-1", :ViewJump1
grab "W-S-2", :ViewJump2
grab "W-S-3", :ViewJump3
grab "W-S-4", :ViewJump4

# Switch current view
grab "W-1", :ViewSwitch1
grab "W-2", :ViewSwitch2
grab "W-3", :ViewSwitch3
grab "W-4", :ViewSwitch4

# Select next and prev view */
grab "KP_Add",      :ViewNext
grab "KP_Subtract", :ViewPrev

# Move mouse to screen1, screen2, ...
grab "W-A-1", :ScreenJump1
grab "W-A-2", :ScreenJump2
grab "W-A-3", :ScreenJump3
grab "W-A-4", :ScreenJump4

# Force reload of config and sublets
grab "W-C-r", :SubtleReload

# Force restart of subtle
grab "W-C-S-r", :SubtleRestart

# Quit subtle
grab "W-C-q", :SubtleQuit

# Move current window
grab "W-B1", :WindowMove

# Resize current window
grab "W-B3", :WindowResize

# Toggle floating mode of window
grab "W-f", :WindowFloat

# Toggle fullscreen mode of window
grab "W-space", :WindowFull

# Toggle sticky mode of window (will be visible on all views)
grab "W-s", :WindowStick

# Toggle zaphod mode of window (will span across all screens)
grab "W-equal", :WindowZaphod

# Raise window
grab "W-r", :WindowRaise

# Lower window
grab "W-l", :WindowLower

# Select next windows
grab "W-Left",  :WindowLeft
grab "W-Down",  :WindowDown
grab "W-Up",    :WindowUp
grab "W-Right", :WindowRight

# Kill current window
grab "W-w", :WindowKill

# Cycle between given gravities
grab "W-KP_7", [ :top_left,     :top_left66,     :top_left33     ]
grab "W-KP_8", [ :top,          :top66,          :top33          ]
grab "W-KP_9", [ :top_right,    :top_right66,    :top_right33    ]
grab "W-KP_4", [ :left,         :left66,         :left33         ]
grab "W-KP_5", [ :center,       :center66,       :center33       ]
grab "W-KP_6", [ :right,        :right66,        :right33        ]
grab "W-KP_1", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
grab "W-KP_2", [ :bottom,       :bottom66,       :bottom33       ]
grab "W-KP_3", [ :bottom_right, :bottom_right66, :bottom_right33 ]

# In case no numpad is available e.g. on notebooks
#grab "W-q", [ :top_left,     :top_left66,     :top_left33     ]
#grab "W-w", [ :top,          :top66,          :top33          ]
#grab "W-e", [ :top_right,    :top_right66,    :top_right33    ]
#grab "W-a", [ :left,         :left66,         :left33         ]
#grab "W-s", [ :center,       :center66,       :center33       ]
#grab "W-d", [ :right,        :right66,        :right33        ]
#
# QUERTZ
#grab "W-y", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
#
# QWERTY
#grab "W-z", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
#
#grab "W-x", [ :bottom,       :bottom66,       :bottom33       ]
#grab "W-c", [ :bottom_right, :bottom_right66, :bottom_right33 ]

# Exec programs
grab "W-Return", "alacritty"
grab "W-S-r", "rofi -show drun"

# Run Ruby lambdas
grab "S-F2" do |c|
  puts c.name
end

grab "S-F3" do
  puts Subtlext::VERSION
end

#
# == Tags
#
# Tags are generally used in subtle for placement of windows. This placement is
# strict, that means that - aside from other tiling window managers - windows
# must have a matching tag to be on a certain view. This also includes that
# windows that are started on a certain view will not automatically be placed
# there.
#
# There are to ways to define a tag:
#
# === Simple
#
# The simple way just needs a name and a regular expression to just handle the
# placement:
#
# Example:
#
#  tag "terms", "xterm|[u]?rxvt"
#
# === Extended
#
# Additionally tags can do a lot more then just control the placement - they
# also have properties than can define and control some aspects of a window
# like the default gravity or the default screen per view.
#
# Example:
#
#  tag "terms" do
#    match   "xterm|[u]?rxvt"
#    gravity :center
#  end
#
# === Default
#
# Whenever a window has no tag it will get the default tag and is placed on the
# default view. The default view can either be set by the user by adding the
# default tag to a view by choice or otherwise the first defined view will be
# chosen automatically.
#
# === Modes
#
# Modes can be set with the set option, see below.
#
# [*borderless*] Enable the borderless mode for tgagged clients. When set, any borders
#                around tagged clients are absent.
#
#                Example: set :borderless
#                Links:   https://subforge.org/projects/subtle/wiki/Tagging#Borderless
#                         https://subforge.org/projects/subtle/wiki/Clients#Borderless
#
# [*fixed*]      Enable the fixed mode for tagged clients. When set, the client cannot be
#                resized anymore.
#
#                Example: set :fixed
#                Links:   https://subforge.org/projects/subtle/wiki/Tagging#Fixed
#                         https://subforge.org/projects/subtle/wiki/Clients#Fixed
#
# [*floating*]   Enables the float mode for tagged clients.
#
#                Example: set :floating
#                Links:   https://subforge.org/projects/subtle/wiki/Tagging#Floating
#                         https://subforge.org/projects/subtle/wiki/Clients#Floating
#
# [*full*]       Enable the fullscreen mode for tagged clients. When set, the client
#                covers the whole screen size.
#
#                Example: set :full
#                Links:   https://subforge.org/projects/subtle/wiki/Tagging#Fullscreen
#                         https://subforge.org/projects/subtle/wiki/Clients#Fullscreen
#
# [*resize*]     Enable resize mode for tagged clients. When set, subtle honors size
#                hints, that define various size constraints like sizes for columns
#                and rows of a terminal.
#
#                Example: set :resize
#                Links:   https://subforge.org/projects/subtle/wiki/Tagging#Resize
#                         https://subforge.org/projects/subtle/wiki/Clients#Resize
#
# [*sticky*]     Enable sticky mode for tagged clients. When set, subtle keeps the
#                client on the current screen, regardless of the tags.
#
#                Example: set :sticky
#                Links:   https://subforge.org/projects/subtle/wiki/Tagging#Sticky
#
# [*urgent*]     Enables the urgent mode for tagged clients. When set, subtle
#                automatically sets this client to urgent.
#
#                Urgent usually means the window requires immediate attention like
#                a visual bell in a term.
#
#                Example: set :urgent
#                Links:   https://subforge.org/projects/subtle/wiki/Tagging#Stick
#                         https://subforge.org/projects/subtle/wiki/Clients#Urgent
#
# [*zaphod*]     Enables the zaphod mode for tagged clients. When set, the client
#                spans across all connected screens.
#
#                Example: set :zaphod
#                Links:   https://subforge.org/projects/subtle/wiki/Tagging#Zaphod
#                         https://subforge.org/projects/subtle/wiki/Clients#Zaphod
#
# === Options
#
# [*set*]        Set various modes to the tagged client. Multiple modes can be set,
#                separated by comma. (See Modes)
#
#                Example: set :floating, :sticky
#
# [*geometry*]   Set a certain geometry for the tagged client and put it in
#                floating mode, but only on views that have this tag in common.
#                Expected is an array with x, y, width and height values whereas
#                width and height must be >0.
#
#                Example: geometry [100, 100, 50, 50]
#                Link:    https://subforge.org/projects/subtle/wiki/Tagging#Geometry
#
# [*gravity*]    Set a certain to gravity to the tagged client, but only on views
#                that have this tag in common.
#
#                Example: gravity :center
#                Link:    https://subforge.org/projects/subtle/wiki/Tagging#Gravity
#
# [*match*]      Add matching patterns to a tag, this can be done more than once.
#
#                Matching works either via plaintext, regular expressions
#                (see man regex(7)) or window id. Per default tags will only match
#                the WM_NAME and the  WM_CLASS portion of a client, this can be
#                changed with following possible values:
#
#                [*:name*]      Match the WM_NAME
#                [*:instance*]  Match the first (instance) part from WM_CLASS
#                [*:class*]     Match the second (class) part from WM_CLASS
#                [*:role*]      Match the window role
#                [*:type*]      Match the window type
#
#                Examples: match instance: "urxvt"
#                          match [:role, :class] => "test"
#                          match "[xa]+term"
#                Link:     https://subforge.org/projects/subtle/wiki/Tagging#Match
#
# [*on_match*]   Add a Ruby proc that is executed when this tag matches
#
#                Example:
#
#                tag "gimp" do
#                  match role: "gimp.*"
#
#                  on_match do |c|
#                    c.gravity = ("gimp_" + c.role.split("-")[1]).to_sym
#                   end
#                 end
#
# [*position*]   Similar to the geometry option, set the x/y coordinates of the
#                tagged client for views with common tags.
#
#                Expected is an array with x and y values.
#
#                Example: position [ 10, 10 ]
#                Link:    https://subforge.org/projects/subtle/wiki/Tagging#Position
#
# [*stick_to*]   Keep a tagged client on the given screen. When set, clients are
#                visible on all views, even when they don't have matching tags.
#
#                On multihead, sticky clients keep the screen they are assigned to.
#
#                Example: stick_to 1
#                Links:   https://subforge.org/projects/subtle/wiki/Tagging#Stick
#                         https://subforge.org/projects/subtle/wiki/Clients#Stick
#
# [*type*]       Set the window type of the tagged client, this will force it to be
#                treated as a specific window type though as the window sets the type by
#                itself.
#
#                Following types are possible:
#
#                [*:desktop*]  Treat as desktop window (_NET_WM_WINDOW_TYPE_DESKTOP)
#                              Link: https://subforge.org/projects/subtle/wiki/Clients#Desktop
#                [*:dock*]     Treat as dock window (_NET_WM_WINDOW_TYPE_DOCK)
#                              Link: https://subforge.org/projects/subtle/wiki/Clients#Dock
#                [*:toolbar*]  Treat as toolbar windows (_NET_WM_WINDOW_TYPE_TOOLBAR)
#                              Link: https://subforge.org/projects/subtle/wiki/Clients#Toolbar
#                [*:splash*]   Treat as splash window (_NET_WM_WINDOW_TYPE_SPLASH)
#                              Link: https://subforge.org/projects/subtle/wiki/Clients#Splash
#                [*:dialog*]   Treat as dialog window (_NET_WM_WINDOW_TYPE_DIALOG)
#                              Link: https://subforge.org/projects/subtle/wiki/Clients#Dialog
#
#                Example: type :desktop
#                Link:    https://subforge.org/projects/subtle/wiki/Tagging#Type
#
# === Link
#
# https://subforge.org/projects/subtle/wiki/Tagging
#

# Simple tags
tag "terms",   "xterm|[u]?rxvt"
tag "browser", "opera|firefox|(google\-)?chrom[e|ium]"

# Placement
tag "editor" do
  match "[g]?vim"
end

tag "fixed" do
  geometry [ 10, 10, 100, 100 ]
  set :sticky
end

tag "resize" do
  match  "sakura|gvim"
  set :resize
end

tag "gravity" do
  gravity :center
end

# Modes
tag "stick" do
  match "mplayer"
  set :floating, :sticky
end

tag "float" do
  match "display"
  set :floating
end

# Gimp
tag "gimp_image" do
  match   :role => "gimp-image-window"
  gravity :gimp_image
end

tag "gimp_toolbox" do
  match   :role => "gimp-toolbox$"
  gravity :gimp_toolbox
end

tag "gimp_dock" do
  match   :role => "gimp-dock"
  gravity :gimp_dock
end

tag "gimp_scum" do
  match role: "gimp-.*|screenshot"
end

#
# == Views
#
# Views are the virtual desktops in subtle, they show all windows that share a
# tag with them. Windows that have no tag will be visible on the default view
# which is the view with the default tag or the first defined view when this
# tag isn't set.
#
# Like tags views can be defined in two ways:
#
# === Simple
#
# The simple way is exactly the same as for tags:
#
# Example:
#
#   view "terms", "terms"
#
# === Extended
#
# The extended way for views is also similar to the tags, but with fewer
# properties.
#
# Example:
#
#  view "terms" do
#    match "terms"
#    icon  "/usr/share/icons/icon.xbm"
#  end
#
# === Modes
#
# Modes can be set with the set option, see below.
#
# [*dynamic*]    Enable dynamic mode for views. When set, icons of unoccupied views (views that display no
#                windows) are hidden.
#
#                Example: set :dynamic
#                Links:   https://subforge.org/projects/subtle/wiki/Views#Dynamic
#
# [*icon_only*]  Enable icon only mode. When set, subtle hides the view name from the view buttons, just
#                the icon will be visible.
#
#                Example: set :icon_only
#                Links:   https://subforge.org/projects/subtle/wiki/Views#Icon_only
#
# === Options
#
# [*set*]        Set various modes to views. Multiple modes can be set,
#                separated by comma. (See Modes)
#
#                Example: set :dynamic, :icon_only
#
# [*match*]      This property adds a matching pattern to a view. Matching
#                works either via plaintext or regex (see man regex(7)) and
#                applies to names of tags.
#
#                Example: match "terms"
#

#
# [*icon*]       This property adds an icon in front of the view name. The
#                icon can either be path to an icon or an instance of
#                Subtlext::Icon.
#
#                Example: icon "/usr/share/icons/icon.xbm"
#                         icon Subtlext::Icon.new("/usr/share/icons/icon.xbm")
#
# === Link
#
# https://subforge.org/projects/subtle/wiki/Tagging
#

view "terms", "terms|default"
view "www",   "browser"
view "gimp",  "gimp_.*"
view "dev",   "editor"

#
# == Screens
#
# Subtle usually creates screens based on the information it gathers from  X
# and xrandr runtime.
#
# To allow more flexibility, subtle can split physically screens into virtual
# ones and low to see multiple views on screen per virtual screen.
#
# === Example
#
#   screen 1 do
#     virtual [  0,  0, 50, 50 ]
#     virtual [ 50, 50, 50, 50 ]
#   end

#
# == Sublets
#
# Sublets are Ruby scripts that provide data for the panel and can be managed
# with the sur script that comes with subtle.
#
# === Example
#
#  sur install clock
#  sur uninstall clock
#  sur list
#
# === Configuration
#
# All sublets have a set of configuration values that can be changed directly
# from the config of subtle.
#
# There are three default properties, that can be be changed for every sublet:
#
# [*interval*]    Update interval of the sublet
# [*foreground*]  Default foreground color
# [*background*]  Default background color
#
# sur can also give a brief overview about properties:
#
# === Example
#
#   sur config clock
#
# The syntax of the sublet configuration is similar to other configuration
# options in subtle:
#
# === Example
#
#  sublet :clock do
#    interval      30
#    foreground    "#eeeeee"
#    background    "#000000"
#    format_string "%H:%M:%S"
#  end
#
#  === Link
#
# https://subforge.org/projects/subtle/wiki/Sublets
#

#
# == Hooks
#
# And finally hooks are a way to bind Ruby scripts to a certain event.
#
# Following hooks exist so far:
#
# [*:client_create*]    Called whenever a window is created
# [*:client_gravity*]   Called whenever a window is configured
# [*:client_mode*]      Called whenever a window is configured
# [*:client_focus*]     Called whenever a window gets focus
# [*:client_rename*]    Called whenever a window is renamed
# [*:client_kill*]      Called whenever a window is killed
#
# [*:tag_create*]       Called whenever a tag is created
# [*:tag_kill*]         Called whenever a tag is killed
#
# [*:view_create*]      Called whenever a view is created
# [*:view_focus*]       Called whenever a view is configured
# [*:view_kill*]        Called whenever a view is killed
#
# [*:start*]            Called on start
# [*:exit*]             Called on exit
# [*:tile*]             Called on whenever tiling would be needed
# [*:reload*]           Called on reload
#
# === Example
#
# This hook will print the name of the window that gets the focus:
#
#   on :client_focus do |c|
#     puts c.name
#   end
#
# === Link
#
# https://subforge.org/projects/subtle/wiki/Hooks
#

# vim:ts=2:bs=2:sw=2:et:fdm=marker
