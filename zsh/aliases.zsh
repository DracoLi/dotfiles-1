alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command

# mkdir and cd combined in one
function mkdircd () { mkdir -p "$@" && cd "$@"; }
