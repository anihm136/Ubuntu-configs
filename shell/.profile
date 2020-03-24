# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

[[ -f ~/.sh_funcs ]] && source ~/.sh_funcs
[[ -f ~/.aliases ]] && source ~/.aliases

# Cleanup
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export LESSHISTFILE="."
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/.gtkrc-2.0"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"

# Path additions
export JAVA_HOME=/usr/lib/jvm/jdk-13.0.1+9
export PATH=$PATH:$JAVA_HOME/bin
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$PATH:/opt/lampp/bin
export PATH=$PATH:/home/anirudh/Applications
export PATH=$PATH:/home/anirudh/.scripts
export fpath=($fpath /home/anirudh/.local/share/zsh/completions)

# Settings
export QT_STYLE_OVERRIDE=kvantum
export EDITOR=/usr/local/bin/nvim
export TERMINAL="alacritty"
export BROWSER="firefox"
export FILE="nautilus"
export GUIEDITOR="code"
export FZF_DEFAULT_OPTS="--height 40% --reverse"
export FZF_CTRL_T_OPTS="--preview '(bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500' --preview-window right:60% --select-1"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_COMMAND="fda"
export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="fdfind --hidden --follow --exclude .git"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export SUDO_ASKPASS="$HOME/.scripts/dmenupass"
export PIPENV_VENV_IN_PROJECT=1
