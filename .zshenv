export DOTPATH=$HOME/src/github.com/kato-taketo/dotfiles
export ZDOTDIR=$DOTPATH/zsh

. $ZDOTDIR/.zshenv

# Source Mercari-specific settings if file exists
[ -f "$DOTPATH/.zshenv.mercari" ] && source "$DOTPATH/.zshenv.mercari"
