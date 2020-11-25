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
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"
DISABLE_MAGIC_FUNCTIONS="true"

# Interactive shell options
forgit_log=glog
forgit_diff=gdiff
forgit_add=ga
forgit_reset_head=grh
forgit_ignore=gignore
forgit_restore=gcheck
forgit_clean=gclean
forgit_stash_show=gss
forgit_cherry_pick=gcp

# Linux antibody file
autoload -U compaudit compinit bashcompinit
ZSH="$ANTIBODY_HOME"/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh
source "${XDG_CONFIG_HOME:-$HOME/.config}/antibody/zsh_plugins.sh"
compinit -U
bashcompinit

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

setopt globdots
setopt extendedglob
unalias z 2> /dev/null

[[ -f ${ASDF_DIR:-$HOME/.asdf}/asdf.sh ]] && source ${ASDF_DIR:-$HOME/.asdf}/asdf.sh
[[ -f $HOME/.sh_funcs.zsh ]] && source $HOME/.sh_funcs.zsh
[[ -f $HOME/.aliases ]] && source $HOME/.aliases
[[ -f $ZDOTDIR/.zaliases ]] && source $ZDOTDIR/.zaliases

eval "$(asdf exec direnv hook zsh)"
eval "$(pipenv --completion)"
eval "$(register-python-argcomplete pipx)"
if (command -v perl && command -v cpanm) >/dev/null 2>&1; then
  test -d "$HOME/perl5/lib/perl5" && eval $(perl -I "$HOME/perl5/lib/perl5" -Mlocal::lib)
fi

catch_signal_usr1() {
  trap catch_signal_usr1 USR1
  nvim -c "SLoad reload"
}
trap catch_signal_usr1 USR1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
