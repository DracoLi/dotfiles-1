# Activate direnv if installed by homebrew
if brew ls --versions direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi
