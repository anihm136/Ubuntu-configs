NUMTERM=$(pgrep -fc sakura)
if (( NUMTERM == 1));then
  ufetch-ubuntu
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Linux antigen file
source $HOME/.scripts/antigen.zsh
[ -f .sh_funcs ] && source .sh_funcs

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load the theme and configure
antigen theme romkatv/powerlevel10k

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
