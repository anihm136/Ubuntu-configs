NUMTERM=$(pgrep -fc alacritty)
if (( NUMTERM == 1));then
  ufetch-ubuntu
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


HISTSIZE=1000
SAVEHIST=1000
HISTFILE="$XDG_CACHE_HOME/zsh/history"

# Linux antibody file
source "${XDG_CONFIG_HOME:-$HOME/.config}/antibody/zsh_plugins.sh"

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

eval "$(pipenv --completion)"
if (command -v perl && command -v cpanm) >/dev/null 2>&1; then
  test -d "$HOME/perl5/lib/perl5" && eval $(perl -I "$HOME/perl5/lib/perl5" -Mlocal::lib)
fi
_comp_options+=(globdots)

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

autoload -Uz edit-command-line
zle -N edit-command-line

bindkey -v
bindkey -a 'v' edit-command-line
bindkey '^[[A' up-line-or-search
bindkey "^[[3~" delete-char
bindkey '^?' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -f ~/.sh_funcs ]] && source ~/.sh_funcs
[[ -f ~/.aliases ]] && source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
