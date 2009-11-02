[[ -n "$terminfo[kdch1]" ]] && bindkey "$terminfo[kdch1]" delete-char
[[ -n "$terminfo[kbs]"   ]] && bindkey "$terminfo[kbs]"   backward-delete-char
[[ -n "$terminfo[kcub1]" ]] && bindkey "$terminfo[kcub1]" backward-char
[[ -n "$terminfo[kcuf1]" ]] && bindkey "$terminfo[kcuf1]" forward-char
[[ -n "$terminfo[khome]" ]] && bindkey "$terminfo[khome]" beginning-of-line
[[ -n "$terminfo[kend]"  ]] && bindkey "$terminfo[kend]"  end-of-line
[[ -n "$terminfo[kpp]"   ]] && bindkey "$terminfo[kpp]"   history-beginning-search-backward
[[ -n "$terminfo[knp]"   ]] && bindkey "$terminfo[knp]"   history-beginning-search-forward

case $TERM in
    xterm)
        export TERM=xterm-256color
        ;;
esac

export MAVEN_OPTS="-Xms256m -Xmx1024m"

export DEBEMAIL="derek@nebvin.ca"
export DEBFULLNAME="Derek Williams"
export GPGKEY="13F5913B"

typeset -U path
path=(/home/derek/Programs /sbin /usr/sbin $path)

typeset -U cdpath
cdpath=(. $cdpath)

WORDCHARS='*?_-,[]~\!#$%^(){}<>|`@+:'

setopt nobeep                  # No freaking beeping please
setopt autocd                  # Change dir if no command
setopt notify                  # Notify of background job completion
setopt automenu                # cycle completions
setopt nocheckjobs             # don't warn me about bg processes when exiting
setopt nohup                   # and don't kill them, either
#setopt listpacked              # compact completion lists
setopt nolisttypes             # show types in completion
setopt completeinword          # not just at the end
# setopt alwaystoend             # when complete from middle, move cursor
setopt correct                 # spelling correction
setopt printexitvalue          # alert me if something's failed

# History stuff
export HISTSIZE=5000
export SAVEHIST=5000
export HISTFILE=~/.zsh_history
setopt histignoredups        # ignore same commands run twice+
setopt appendhistory           # don't overwrite history
setopt incappendhistory
setopt histfindnodups

# If running interactively, then:
if [ "$PS1" ]; then
  # colour ls
  eval `dircolors`
  alias ls='ls --color=auto'

  # use ssh for rysnc
  export RSYNC_RSH=ssh

  export EDITOR="emacs -nw"
  export VISUAL="emacs"
  alias ed="$EDITOR"

  # colours in man output, emacs like bindings. nifty.
  export PAGER=less

  umask 022

  #
  # completion tweaking
  #

  # complete hostnames out of ssh's ~/.ssh/known_hosts
  autoload -U compinit; compinit
  autoload -U bashcompinit; bashcompinit

  zstyle ':completion:*' use-cache on
  zstyle ':completion:*' users resolve
  hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*})
  zstyle ':completion:*:hosts' hosts $hosts

  # use dircolours in completion listings
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

  # allow approximate matching
  zstyle ':completion:*' completer _complete _match _approximate
  zstyle ':completion:*:match:*' original only
  zstyle ':completion:*:approximate:*' max-errors 1 numeric
  zstyle ':completion:*' auto-description 'Specify: %d'
  zstyle ':completion:*' format 'Completing %d'
  zstyle ':completion:*' verbose true
  zstyle ':completion:*:functions' ignored-patterns '_*'
  zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns \
  '*?.(o|c~|zwc)' '*?~'

fi

precmd () {
  TITLECMD=""
  SCREENCMD="shell"
  settitle
}


setopt extended_glob
preexec () {
  CMD=${1[(wr)^(*=*|sudo|-*)]}
  SCREENCMD=$CMD
  TITLECMD=" - $CMD"
  settitle
}

settitle() {
  case $TERM in
    rxvt*|xterm*|putty*|konsole*)
    print -Pn "\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~$TITLECMD\a"
    ;;
    screen*)
    print -Pn "\e_%(!.-=*[ROOT]*=- | .)%n@%m:%~$TITLECMD\e\\"
    print -Pn "\ek$SCREENCMD\e\\"
    ;;
  esac
}

autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval $color='%{$fg_bold[${(L)color}]%}'
  eval DARK_$color='%{$fg_no_bold[${(L)color}]%}'
  (( count = $count + 1 ))
done
NO_COLOUR="%{$terminfo[sgr0]%}"
setopt prompt_subst

PROMPT='$DARK_CYAN%n$CYAN@$DARK_CYAN%m$NO_COLOUR > '
RPROMPT='$BLUE%~$NO_COLOUR'
