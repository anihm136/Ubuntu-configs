cf() {
  local file


  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
    if [[ -d $file ]]
    then
      cd -- $file
    else
      cd -- ${file:h}
    fi
  fi
}

#
# # ex - archive extractor
# # usage: ex <file>
ext ()
{
  if [[ -f $1 ]] || [[ -z $1(#qN) ]] ; then
    local ext_path=$(dirname $1)
    case $1 in
      *.tar.bz2)   tar xjf $1 -C $ext_path    ;;
      *.tar.gz)    tar xzf $1 -C $ext_path    ;;
      *.tar.xz)    tar xf $1 -C $ext_path   ;;
      *.bz2)       bunzip2 $1            ;;
      *.rar)       unrar x $1 $ext_path      ;;
      *.gz)        gunzip $1             ;;
      *.tar)       tar xf $1 -C $ext_path    ;;
      *.tbz2)      tar xjf $1 -C $ext_path    ;;
      *.tgz)       tar xzf $1 -C $ext_path    ;;
      *.zip)       unzip $1 -d $ext_path     ;;
      *.Z)         uncompress $1         ;;
      *.7z)        7z x $1 -o $ext_path      ;;
      *)           echo "'$1' cannot be extracted via ext()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "bat --style=numbers --color=always {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}" --preview-window right:60%:wrap
}

e() {
  if [[ -n "$@" ]]; then
    nvim $@
  else
    local files="$(fzf -m)"
    local args=("${(f)files}")
    [ -n "$args" ] && nvim ${args[@]}
  fi
}

mcp() {
  local fro=()
  local to=()
  local flags=()
  local dest=false
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -d)
        dest=true
        ;;
      -*)
        flags+=("$1")
        ;;
      *)
        if [[ $dest == true ]]; then
          to+=("${(q)1}")
        else
          fro+=($1)
        fi
        ;;
    esac
    shift
  done
  echo $to | xargs -n 1 cp $flags $fro
}

mmv() {
  local fro=()
  local to=()
  local flags=()
  local dest=false
  local args=$@
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -d)
        dest=true
        ;;
      -*)
        flags+=("$1")
        ;;
      *)
        if [[ $dest == true ]]; then
          to+=("${(q)1}")
        else
          fro+=($1)
        fi
        ;;
    esac
    shift
  done
  mcp $args && rm $fro
}

dlm() {
  youtube-dl -f ${2:-"m4a"} $1 --add-metadata
}