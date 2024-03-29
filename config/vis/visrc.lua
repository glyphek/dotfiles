require('vis')
require('plugins/filetype')
require('plugins/vis-go')
require('plugins/vis-quickfix')
--require('plugins/vis-lspc')

--plugins--
--require('plugins/twofinger-surround')
--require('plugins/vis-commentary/vis-commentary')
--require('plugins/vis-ctags/ctags')
--require('plugins/vis-fzf-open/fzf-open')
--require('plugins/vis-modelines/vis-modelines')
--require('plugins/vis-surround/vis-surround')
--require('plugins/vis-vim-compatibility-pack/vis-vim-compatible')

vis.events.subscribe(vis.events.INIT, function()
	--global configuration--
	vis:command('set change-256colors on')
	vis:command('set theme deus')

	--keyboard shortcuts--
	vis:command('map insert <C-s> <Escape>:w<Enter>')
	vis:command('map normal <C-s> :w<Enter>')
	vis:command('map! insert <M-C-h> <Escape>dbi')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	--per-window configuration--
	vis:command('set number')
	vis:command('set autoindent on')
	--vis:command('set cursorline on')
	vis:command('set tabwidth 8')
end)

