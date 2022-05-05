-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/filetype')
require('plugins/filetype-settings')

settings = {yaml = {'set expandtab', 'set tabwidth 2'}}

vis.events.subscribe(
    vis.events.INIT, function()
      -- Your global configuration options
      vis:command('set ignorecase on')
      vis:command('set syntax on')
      vis:command('set theme base16-onedark')
    end
)

vis.events.subscribe(
    vis.events.WIN_OPEN, function(win)
      -- Your per window configuration options e.g.
      -- vis:command('set number')
      vis:command('set cursorline')
      vis:command('set relativenumbers')
    end
)
