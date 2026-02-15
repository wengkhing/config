eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(starship init bash)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.bash 2>/dev/null || :

## auto activate mise
eval "$(mise activate bash)"

if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi

alias nv="nvim ."

EDITOR=nvim
