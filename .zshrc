# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/romikabi/.oh-my-zsh"

ZSH_THEME=""

export EDITOR='vim'

# Vi mode for command line
bindkey -v

# reduce the timeout between switching modes
export KEYTIMEOUT=1

# zsh-syntax-highlighting should be last
plugins=(
  git
  vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# PURE PROMPT
fpath+=("$HOME/.zsh/pure")
autoload -U promptinit; promptinit
prompt pure

# Hide vi-mode indicator
export MODE_INDICATOR=' '

# AUTOCOMPLETE
ZSH_AUTOSUGGEST_STRATEGY=(history)
bindkey '^ ' autosuggest-accept
bindkey '^[[[CE' autosuggest-execute
bindkey '^L' forward-word
bindkey '^H' backward-delete-word 

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'
