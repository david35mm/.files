-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({preset = naughty.config.presets.critical,
	title = "Oops, there were errors during startup!",
	text = awesome.startup_errors})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err)})
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- This is used later as the default terminal and editor to run.
myTerm = "alacritty"
myBrowser = "brave-browser"
myFileManager = "pcmanfm"
myMarkdown = "marktext"
myMusicPlayer = myTerm .. " --class cmus,cmus -e cmus"
myOfficeSuite = "desktopeditors"
myPDFReader = "zathura"
myTextEditor = "subl"
myVideoPlayer = "celluloid"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.

M = "Mod4"
A = "Mod1"
S = "Shift"
C = "Control"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	--awful.layout.suit.corner.ne,
	--awful.layout.suit.corner.se,
	--awful.layout.suit.corner.sw,
	--awful.layout.suit.corner.nw,
	--awful.layout.suit.fair,
	--awful.layout.suit.fair.horizontal,
	--awful.layout.suit.magnifier,
	--awful.layout.suit.max.fullscreen,
	--awful.layout.suit.spiral,
	--awful.layout.suit.spiral.dwindle,
	--awful.layout.suit.tile.bottom,
	--awful.layout.suit.tile.left,
	--awful.layout.suit.tile.top,
	awful.layout.suit.floating,
	awful.layout.suit.max,
	awful.layout.suit.tile,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
	{"hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
	{"manual", myTerm .. " -e man awesome"},
	{"edit config", myTerm .. " -e nvim " .. awesome.conffile},
	{"restart", awesome.restart},
	{"quit", function() awesome.quit() end},
}

mymainmenu = awful.menu({items = {{"awesome", myawesomemenu, beautiful.awesome_icon},
	{"open terminal", myTerm}}
})
-- }}}

-- {{{ Wibar
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({M}, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({M}, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", {raise = true})
		end
	end),
	awful.button({}, 3, function() awful.menu.client_list({theme = {width = 250}}) end),
	awful.button({}, 4, function() awful.client.focus.byidx(1) end),
	awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	local names = {"web", "dev", "sys", "doc", "chat", "game", "media", "gfx"}
	local l = awful.layout.suit  -- Just to save some typing: use an alias.
	local layouts = {l.max, l.tile, l.tile, l.tile, l.max, l.floating, l.max, l.floating}
	awful.tag(names, s, layouts)

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function() awful.layout.inc( 1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc( 1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.all,
		buttons = taglist_buttons
	}

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist {
		screen  = s,
		filter  = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
	}

	-- Create the wibox
	s.mywibox = awful.wibar({position = "top", screen = s})

	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
			s.mylayoutbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			wibox.widget.textclock("%a %b %d  %I:%M %P    "),
		},
	}
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function() mymainmenu:toggle() end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
	-- Awesome Controls
	awful.key({M, C}, "r", awesome.restart, {description = "Restart Awesome", group = "Awesome"}),
	awful.key({M, C}, "q", awesome.quit, {description = "Quit Awesome", group = "Awesome"}),
	awful.key({M}, "b", hotkeys_popup.show_help, {description="Open <b>this</b> cheatsheet", group="Awesome"}),

	-- Window Controls
	awful.key({M, S}, "j", function() awful.client.swap.byidx(-1) end, {description = "Swap with previous window", group = "Window"}),
	awful.key({M, S}, "k", function() awful.client.swap.byidx(1) end, {description = "Swap with next window", group = "Window"}),
	awful.key({M}, "j", function() awful.client.focus.byidx(-1) end, {description = "Focus previous window", group = "Window"}),
	awful.key({M}, "k", function() awful.client.focus.byidx(1) end, {description = "Focus next window", group = "Window"}),
	awful.key({M}, "u", awful.client.urgent.jumpto, {description = "Focus urgent window", group = "Window"}),
	awful.key({M, S}, "c", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", {raise = true})
		end
	end, {description = "Unminimize window", group = "Window"}),

	-- Workspace Navigation
	awful.key({M}, "Left", awful.tag.viewprev, {description = "Go to previous workspace", group = "Workspace"}),
	awful.key({M}, "Right", awful.tag.viewnext, {description = "Go to next workspace", group = "Workspace"}),
	awful.key({M}, "Escape", awful.tag.history.restore, {description = "Go to last workspace", group = "Workspace"}),

	-- Layout Controls
	awful.key({M, C}, "h", function() awful.tag.incnmaster( 1, nil, true) end, {description = "Add window to the master pane", group = "Layout"}),
	awful.key({M, C}, "j", function() awful.tag.incncol(-1, nil, true) end, {description = "Decrease columns on the slave pane", group = "Layout"}),
	awful.key({M, C}, "k", function() awful.tag.incncol( 1, nil, true) end, {description = "Increase columns on the slave pane", group = "Layout"}),
	awful.key({M, C}, "l", function() awful.tag.incnmaster(-1, nil, true) end, {description = "Remove window from the master pane", group = "Layout"}),
	awful.key({M}, "Tab", function() awful.layout.inc( 1) end, {description = "Cycle through layouts", group = "Layout"}),
	awful.key({M}, "h", function() awful.tag.incmwfact(-0.05) end, {description = "Shrink master pane width", group = "Layout"}),
	awful.key({M}, "l", function() awful.tag.incmwfact( 0.05) end, {description = "Grow master pane width", group = "Layout"}),

	-- Multi-Screen Focus
	awful.key({M}, "Comma", function() awful.screen.focus_relative(-1) end, {description = "Focus the previous screen", group = "Screen"}),
	awful.key({M}, "Period", function() awful.screen.focus_relative( 1) end, {description = "Focus the next screen", group = "Screen"}),

	-- System Controls
	awful.key({}, "XF86AudioLowerVolume", function() awful.spawn("pamixer -u -d 5") end, {description = "Decrease the volume", group = "System"}),
	awful.key({}, "XF86AudioMute", function() awful.spawn("pamixer -t") end, {description = "Mute toggle", group = "System"}),
	awful.key({}, "XF86AudioRaiseVolume", function() awful.spawn("pamixer -u -i 5") end, {description = "Increase the volume", group = "System"}),
	awful.key({}, "XF86MonBrightnessDown", function() awful.spawn("brightnessctl set 10%-") end, {description = "Decrease the brightness", group = "System"}),
	awful.key({}, "XF86MonBrightnessUp", function() awful.spawn("brightnessctl set 10%+") end, {description = "Increase the brightness", group = "System"}),
	awful.key({A}, "j", function() awful.spawn("brightnessctl set 10%-") end, {description = "Decrease the brightness", group = "System"}),
	awful.key({A}, "k", function() awful.spawn("brightnessctl set 10%+") end, {description = "Increase the brightness", group = "System"}),

	-- Applications launcher
	awful.key({M}, "r", function() awful.spawn("rofi -show drun") end, {description = "Run the application launcher", group = "Launcher"}),
	awful.key({M, A}, "r", function() awful.spawn("rofi -show run") end, {description = "Launch the run prompt", group = "Launcher"}),
	awful.key({A}, "Tab", function() awful.spawn("rofi -show window") end, {description = "Open the window switcher", group = "Launcher"}),
	awful.key({M}, "Return", function() awful.spawn(myTerm) end, {description = "Launch " .. myTerm, group = "Programs"}),
	awful.key({M, A}, "i", function() awful.spawn(myBrowser) end, {description = "Launch " .. myBrowser, group = "Programs"}),
	awful.key({M}, "e", function() awful.spawn(myFileManager) end, {description = "Launch " .. myFileManager, group = "Programs"}),
	awful.key({M, A}, "d", function() awful.spawn(myMarkdown) end, {description = "Launch " .. myMarkdown, group = "Programs"}),
	awful.key({M, A}, "m", function() awful.spawn(myMusicPlayer) end, {description = "Launch " .. myMusicPlayer, group = "Programs"}),
	awful.key({M, A}, "o", function() awful.spawn(myOfficeSuite) end, {description = "Launch " .. myOfficeSuite, group = "Programs"}),
	awful.key({M, A}, "p", function() awful.spawn(myPDFReader) end, {description = "Launch " .. myPDFReader, group = "Programs"}),
	awful.key({M, A}, "t", function() awful.spawn(myTextEditor) end, {description = "Launch " .. myTextEditor, group = "Programs"}),
	awful.key({M, A}, "v", function() awful.spawn(myVideoPlayer) end, {description = "Launch " .. myVideoPlayer, group = "Programs"}),
	awful.key({M, A}, "e", function() awful.spawn(myTerm .. ' -e vifm') end, {description = "Launch " .. myTerm .. ' -e vifm', group = "Programs"}),
	awful.key({M, A}, "s", function() awful.spawn("spotify") end, {description = "Launch Spotify", group = "Programs"}),
	awful.key({M, A}, "g", function() awful.spawn("steam") end, {description = "Launch Steam", group = "Programs"})
)

clientkeys = gears.table.join(
	awful.key({M}, "s", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, {description = "Fullscreen toggle", group = "Window"}),
	awful.key({M}, "w", function(c) c:kill() end, {description = "Close the window", group = "Window"}),
	awful.key({M}, "f", awful.client.floating.toggle , {description = "Floating toggle", group = "Window"}),
	awful.key({M, S}, "Return", function(c) c:swap(awful.client.getmaster()) end, {description = "Swap with master window", group = "Window"}),
	awful.key({M}, "o", function(c) c:move_to_screen() end, {description = "Move to screen", group = "Window"}),
	awful.key({M}, "c", function(c) c.minimized = true end, {description = "Minimize window", group = "Window"}),
	awful.key({M}, "m",function(c)
		c.maximized = not c.maximized
		c:raise()
	end, {description = "(un)maximize window", group = "Window"}),
	awful.key({M, C}, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, {description = "(un)maximize window vertically", group = "Window"}),
	awful.key({M, S}, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, {description = "(un)maximize window horizontally", group = "Window"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+b)
	local descr_view, descr_toggle, descr_move, descr_toggle_focus
	if i == 1 or i == 9 then
		descr_view = {description = "view tag #", group = "Workspace"}
		descr_toggle = {description = "toggle tag #", group = "Workspace"}
		descr_move = {description = "move focused client to tag #", group = "Workspace"}
		descr_toggle_focus = {description = "toggle focused client on tag #", group = "Workspace"}
	end
	globalkeys = gears.table.join(globalkeys,
		-- View tag only.
		awful.key({M}, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, descr_view),
		-- Toggle tag display.
		awful.key({M, C}, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, descr_toggle),
		-- Move client to tag.
		awful.key({M, S}, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, descr_move),
		-- Toggle tag on focused client.
		awful.key({M, C, S}, "#" .. i + 9, function()
			if client.focus then
			local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, descr_toggle_focus)
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
	end),
	awful.button({M}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		awful.mouse.client.move(c)
	end),
	awful.button({M}, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{rule = {},
		properties = {border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen,
			size_hints_honor = false
		}
	},

	-- Floating clients.
	{rule_any = {
		class = {"Arandr", "Blueman-adapters", "Blueman-manager", "confirmreset", "file_progress",
			"makebranch", "maketag", "Pavucontrol", "ssh-askpass", "confirm", "dialog", "download",
			"error", "notification", "splash", "toolbar"},

		role = {"utility", "notificion", "toolbar", "splash", "dialog"},
		-- Note that the name property shown in xprop might be set slightly after creation of the client
		-- and the name shown there might not match defined rules here.
		name = {"Authentication", "branchdialog", "pinentry"},
	}, properties = {floating = true}},

	{rule_any = {class = {"Brave-browser", "Min"}}, properties = {maximized = true, tag = "web"}},
	{rule_any = {class = {"Emacs", "jetbrains-idea", "Sublime_text"}}, properties = {tag = "dev"}},
	{rule_any = {class = {"Lxappearance", "Nitrogen"}}, properties = {tag = "sys"}},
	{rule_any = {class = {"DesktopEditors", "marktext", "Zathura"}}, properties = {tag = "doc"}},
	{rule_any = {class = {"TelegramDesktop"}}, properties = {tag = "chat"}},
	{rule_any = {class = {"cmus", "Geeqie"}, name = {"Celluloid"}}, properties = {tag = "media"}},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup
		and not c.size_hints.user_position
		and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

function border_adjust(c)
	if c.maximized then -- no borders if only 1 client visible
		c.border_width = 0
	elseif #awful.screen.focused().clients > 1 then
		c.border_width = beautiful.border_width
		c.border_color = beautiful.border_focus
	end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

awful.spawn.easy_async("picom -b", function() end)
awful.spawn.easy_async("lxpolkit", function() end)
awful.spawn.easy_async("pcmanfm -d", function() end)
awful.spawn.easy_async("xfce4-power-manager", function() end)
awful.spawn.easy_async_with_shell(gears.filesystem.get_configuration_dir() .. "checkupdts.sh", function() end)
