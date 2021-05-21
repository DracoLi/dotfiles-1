# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color -h --group-directories-first"
  alias l="gls -lAhF --color"
  alias ll="gls -lF --color"
  alias la='gls -AF --color'
fi

alias ipaddress="ipconfig getifaddr en0"

aws-vault-session() {
  aws-vault exec "$@" --no-session
}
