# Linux antigen file
source $HOME/.scripts/antigen.zsh
[ -f .sh_funcs ] && source .sh_funcs

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load the theme and configure
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
antigen theme bhilburn/powerlevel9k powerlevel9k
# antigen theme denysdovhan/spaceship-prompt
POWERLEVEL9K_MODE='nerdfont-complete'

# Prompts
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{202}\uF460%F{208}\uF460%F{214}\uF460%f "
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vi_mode vcs os_icon)

# OS Icon
POWERLEVEL9K_OS_ICON_FOREGROUND=220
POWERLEVEL9K_OS_ICON_BACKGROUND=236

# Context
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND=236
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=220

# Context
POWERLEVEL9K_USER_DEFAULT_BACKGROUND=236
POWERLEVEL9K_USER_DEFAULT_FOREGROUND=220

# Status
POWERLEVEL9K_STATUS_OK_BACKGROUND=236
POWERLEVEL9K_STATUS_OK_FOREGROUND=119
POWERLEVEL9K_STATUS_ERROR_BACKGROUND=210
POWERLEVEL9K_STATUS_ERROR_FOREGROUND=236

# Dir
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_DIR_PATH_SEPARATOR=">"
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true
POWERLEVEL9K_DIR_ETC_BACKGROUND=253
POWERLEVEL9K_DIR_ETC_FOREGROUND=236
POWERLEVEL9K_DIR_HOME_BACKGROUND=253
POWERLEVEL9K_DIR_HOME_FOREGROUND=236
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=253
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=236
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=253
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=236
POWERLEVEL9K_DIR_PATH_SEPARATOR_FOREGROUND=208
POWERLEVEL9K_DIR_PATH_HIGHLIGHT_FOREGROUND=028
POWERLEVEL9K_DIR_PATH_HIGHLIGHT_BOLD=true

# Vcs
POWERLEVEL9K_VCS_SHORTEN_LENGTH=8
POWERLEVEL9K_VCS_MIN_SHORTEN_LENGTH=6
POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=119
POWERLEVEL9K_VCS_CLEAN_FOREGROUND=236
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=210
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=236
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=229
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=236

# Date and time
POWERLEVEL9K_DATE_FORMAT=%D{"%a %d %b,%Y"}
POWERLEVEL9K_DATE_ICON=''
POWERLEVEL9K_DATE_BACKGROUND=229
POWERLEVEL9K_DATE_FOREGROUND=236
POWERLEVEL9K_TIME_FORMAT=%D{"%l:%M %p"}
POWERLEVEL9K_TIME_ICON=''
POWERLEVEL9K_TIME_BACKGROUND=236
POWERLEVEL9K_TIME_FOREGROUND=220

# Vi mode 
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=236
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND=039
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND=236
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND=119

# Add plugins
antigen bundles <<EOBUNDLES
  command-not-found
  pip
  python
  esc/conda-zsh-completion
  git
  common-aliases
  web-search
  sudo
  vi-mode
  z
  zdharma/fast-syntax-highlighting
  zsh-users/zsh-completions
  zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh
EOBUNDLES

# Tell Antigen that you're done.
antigen apply

# Load custom aliases
[[ -s "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"

NUMTERM=$(pgrep -fc sakura)
if (( NUMTERM == 1));then
  pfetch
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/anirudh/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/home/anirudh/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/home/anirudh/miniconda3/etc/profile.d/conda.sh"
  else
    export PATH="/home/anirudh/miniconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zle-keymap-select () {
VI_KEYMAP=$KEYMAP
zle reset-prompt
zle -R
if [ $KEYMAP = vicmd ]; then
  printf "\033[2 q"
else
  printf "\033[6 q"
fi
}
zle -N zle-keymap-select
zle-line-init () {
zle -K viins
printf "\033[6 q"
}
zle -N zle-line-init
