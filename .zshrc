# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="gozilla"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

source $HOME/.infinality-settings.sh

path=(/home/derek/Programs /home/derek/.cabal/bin $path)

export JAVA_OPTS="-Dfile.encoding=UTF8 -server -d64 -XX:+UnlockExperimentalVMOptions -XX:+UseCompressedOops -XX:+AggressiveOpts -XX:+DoEscapeAnalysis -XX:+UseG1GC -Xms64m -Xmx2g -XX:PermSize=64m -XX:MaxPermSize=512m"

export WINEARCH=win32

if [ "$PS1" ]; then
    export RSYNC_RSH=ss
    export EDITOR="emacs -nw"
    export VISUAL="emacs"
    alias ed="$EDITOR"

    alias psa="ps auxf"

    # due to git status being incorporated into oh-my-zsh themes, I
    # keep my actual git repo in a subdirectory of home. This alias
    # makes it easier to work with.
    alias githome="git --git-dir=\"$HOME/.home-git/.git\""

    # Keybindings
    bindkey "^[[3~" delete-char

    # For Gnome Terminal
    bindkey '^[OH' beginning-of-line
    bindkey '^[OF' end-of-line
fi

case $TERM in
    xterm)
        export TERM=xterm-256color
	;;
    putty)
        export TERM=putty-256color
        ;;
esac
