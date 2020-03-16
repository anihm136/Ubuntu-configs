if exists('g:started_by_firenvim')
  so ./firevimconfig.vim
else
  so ./genconfig.vim
endif
