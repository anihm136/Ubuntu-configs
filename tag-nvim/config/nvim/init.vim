if exists('g:started_by_firenvim')
	so ~/.config/nvim/firevimconfig.vim
else
	so ~/.config/nvim/disablePlugins.vim
	so ~/.config/nvim/plugins.vim
	so ~/.config/nvim/genconfig.vim
endif
