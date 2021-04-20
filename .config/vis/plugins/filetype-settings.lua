-- vis-filetype-settings
-- (https://github.com/jocap/vis-filetype-settings)

-- This plugin provides a declarative interface for setting vis
-- options depending on filetype.
-- 
-- It expects a global variable called `settings` to be defined:
-- 
-- 	settings = {
-- 		markdown = {"set expandtab on", "set tabwidth 4"}
-- 	}
-- 
-- In this variable, filetypes are mapped to sets of settings that are
-- to be executed when a window containing the specified filetype is
-- opened.
-- 
-- If you want to do more than setting simple options, you can specify a function instead:
-- 
-- 	settings = {
-- 		bash = function(win)
-- 			-- do things for shell scripts
-- 		end
-- 	}
-- 
-- Be sure not to run commands that open another window with the same
-- filetype, leading to an infinite loop.

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	if settings == nil then return end
	local window_settings = settings[win.syntax]

	if type(window_settings) == "table" then
		for _, setting in pairs(window_settings) do
			vis:command(setting)
		end
	elseif type(window_settings) == "function" then
		window_settings(win)
	end
end)
