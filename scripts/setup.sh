#!/bin/bash

usage() {
    cat <<USAGE | column -t -s "|"
Usage: `basename $0` [options]

Options:
|-f, --force|don't stop executing if file already exists
|-n, --no-backup|don't create backups for existing files, ignored if --force is missing 
|--verbose|print debug messages
|-h, --help|pring this message
USAGE
}

log() {
    if [ $VERBOSE -eq 1 ]; then
        echo "$1"
    fi
}

args=`getopt \
    -o hnf \
    --long --verbose \
    --long --help \
    --long --no-backup \
    --long --force \
    -- $*`

if [ $? -ne 0 ]; then
    usage
    exit
fi

VERBOSE=0
FORCE=0
NO_BACKUP=0
UNKNOWN_ARGS=""

for i
do
    case "$i" in
        -f|--force)
            FORCE=1
            ;;

        -n|--no-backup)
            NO_BACKUP=1
            ;;

        --verbose)
            VERBOSE=1
            ;;

        -h|--help)
            usage
            exit;;

        *)
            UNKNOWN_ARGS+="$i "
            ;;
    esac
    shift
done

log "Force: $FORCE"
log "No backup: $NO_BACKUP"
log "Verbose: $VERBOSE"
log "Unknown args: $UNKNOWN_ARGS"
log ""

exists() {
    if [ -e "$1" ] || [ -h "$1" ] || [ -d "$1" ]; then
        return 1
    else
        return 0
    fi
}

move() {
    exists "$1"
    if [ $? -eq 1 ]; then
        mv "$1" "$2"
        log "Moved $1 to $2"
    fi
}

remove() {
    exists "$1"
    if [ $? -eq 1 ]; then
        rm "$1"
        log "Removed $1"
    fi
}

link() {
    remove "$2"
    ln -s "$1" "$2"
    log "Created symlink from at $2 to $1"
}

# Create symlinks

DOT_VIM="$HOME/.vim"
DOT_CONFIG="${XDG_CONFIG_HOME:=$HOME/.config}"
DOT_VIMRC="$HOME/.vimrc"
NVIM="$DOT_CONFIG/nvim"
INIT_VIM="$DOT_VIM/init.vim"
DOT_ZSHRC="$HOME/.zshrc"

FILES_TO_WRITE=("$DOT_VIMRC" "$NVIM" "$INIT_VIM" "$DOT_ZSHRC")

# check that there are no interrupting files
if [ $FORCE -eq 0 ]; then
    SHOULD_EXIT=0
    for file in ${FILES_TO_WRITE[*]}
    do
        exists "$file"
        if [ $? -eq 1 ]; then
            log "$file is present"
            SHOULD_EXIT=1
        fi
    done

    if [ $SHOULD_EXIT -eq 1 ]; then
        echo "INTERRUPTED: files are present, use --force to proceed anyway"
        exit 1
    fi
fi

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/sindresorhus/pure.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/pure

# create directories
mkdir -p "$DOT_CONFIG"
mkdir -p "$DOT_VIM"

# backup files if needed
if [ $NO_BACKUP -eq 0 ] && [ $FORCE -eq 1 ]; then
    BACKUP_SUFFIX=".backup `date`"
    for file in ${FILES_TO_WRITE[*]}
    do
        move "$file" "$file$BACKUP_SUFFIX"
    done
fi

SCRIPT_DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) >/dev/null 2>&1 && pwd )
DOTFILES_DIR=$( cd $SCRIPT_DIR && git rev-parse --show-toplevel )

# create symlinks
link "$DOTFILES_DIR/.vimrc" "$DOT_VIMRC"
link "$DOTFILES_DIR/.zshrc" "$DOT_ZSHRC"
link "$DOT_VIM" "$NVIM"
link "$DOT_VIMRC" "$INIT_VIM"

# install vim plugins
vim +'PlugInstall --sync' +qa

# apply .zshrc
exec zsh

chsh -s /bin/zsh
