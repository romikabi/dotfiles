ssh-add -A

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

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

# ALIAS
alias git='/usr/local/bin/git'
alias git-apple='/usr/bin/git'
alias shownotremote='git remote prune origin && git branch -vv | grep '\''origin/.*: gone]'\'' | awk '\''{print $1}'\'''
alias prunenotremote='git remote prune origin && git branch -vv | grep '\''origin/.*: gone]'\'' | awk '\''{print $1}'\'' | xargs git branch -D'
alias prunenotremoteforce='git remote prune origin && git branch -vv | grep '\''origin/.*: gone]'\'' | awk '\''{print $1}'\'' | xargs git branch -D'
alias releaseprune='git remote prune origin && git branch -vv | grep '\''origin/release-.*]'\'' | awk '\''{print $1}'\'' | xargs git branch -d'
alias releasepruneforce='git remote prune origin && git branch -vv | grep '\''origin/release-.*]'\'' | awk '\''{print $1}'\'' | xargs git branch -D'
alias ghist='git log --pretty=format:'\''%h %ad | %s%d [%an]'\'' --graph --date=short'
alias gplg='git log --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias gfx='git commit --amend --no-edit'
alias gcom='git checkout master'
alias gsbu='git submodule update --init --recursive'
alias gcomp='git checkout master && git pull && gsbu'

export PATH="$PATH:$HOME/Library/Python/3.7/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
