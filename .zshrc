# SSH
ssh-add --apple-load-keychain

export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="/Users/romikabi/.oh-my-zsh"

ZSH_THEME=""

export EDITOR='nvim'

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

DISABLE_MAGIC_FUNCTIONS=true
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# PURE PROMPT
fpath+=(${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/pure)
autoload -U promptinit; promptinit
PURE_GIT_PULL=0
prompt pure

# Hide vi-mode indicator
export MODE_INDICATOR=' '
VI_MODE_SET_CURSOR=true

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

# Shadowing
alias git='/opt/homebrew/bin/git'
alias v='nvim'
alias vi='v'
alias vim='v'

# Shadowed mapping
alias git-apple='/usr/bin/git'
alias vim-apple='/usr/bin/vim'
alias vi-apple='/usr/bin/vi'

alias e='exec zsh'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'
alias vs='vim ~/dotfiles/scripts/setup.sh'
alias shownotremote='git remote prune origin && git branch -vv | grep '\''origin/.*: gone]'\'' | awk '\''{print $1}'\'''
alias prunenotremote='shownotremote | xargs git branch -d'
alias prunenotremoteforce='shownotremote | xargs git branch -D'
alias gplg='git log --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
alias gfx='git commit --amend --no-edit'
alias gsbu='git submodule update --init --recursive'
alias testyamb='ib Yamb_tests YandexMessengerCoreTests YandexMessengerClientTests && python src/yandex/ios/infra/parallel_test_runner.py -j3 -c "yamb#Yamb_tests:Yamb_tests_module" -c "yamb_core#YandexMessengerCoreTests:--osx-based" -c "yamb_client#YandexMessengerClientTests:--osx-based"  -p src/out/Debug-x64 --log-format simple'
alias gft='git cl format'
alias gdft='git diff --cached --name-only --diff-filter=d | xargs git cl format'
alias gdd='git diff --cached --name-only --diff-filter=d | xargs git diff'
alias gda='git diff --cached --name-only --diff-filter=d | xargs git add'

# Enhanced `git worktree add`, respects sparce checkout from the get-go
addtree() {
    git worktree add --no-checkout $@
    MAIN_GIT_DIR=`echo $(cd \`git rev-parse --git-dir\`; pwd -P)`
    pushd $MAIN_GIT_DIR/worktrees > /dev/null
    WORKTREE_DIR=`ls -tU -d $PWD/* | head -n1`
    ln -s $MAIN_GIT_DIR/info $WORKTREE_DIR/info
    TREE_GIT_DIR=`cat $WORKTREE_DIR/gitdir`
    TREE_DIR=`echo $TREE_GIT_DIR | rev | cut -d"/" -f 2- | rev`
    pushd $TREE_DIR > /dev/null
    git reset --hard > /dev/null
    popd > /dev/null
    popd > /dev/null
}

n() {
    osascript -e "display notification \"$([[ $? = 0 ]] && echo Success || echo Failure)\" with title \"$(history | tail -n1 | cut -d " " -f4-)\""
}

export PATH="$PATH:$HOME/Library/Python/3.7/bin"
export PATH="$PATH:$HOME/Projects/ios_tools/infra"
export PATH="$PATH:$HOME/Projects/depot_tools"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
test -e /Users/romikabi/.iterm2_shell_integration.zsh && source /Users/romikabi/.iterm2_shell_integration.zsh || true

# Haskell ghcup
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
