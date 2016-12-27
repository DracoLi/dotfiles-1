# Activate autoenv if installed by homebrew
if brew ls --versions autoenv > /dev/null; then
  source $(brew --prefix autoenv)/activate.sh
fi
