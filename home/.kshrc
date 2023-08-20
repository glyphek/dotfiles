# @(#).kshrc 1.0
# Base Korn Shell environment
# Approach:
#      shell            initializations go in ~/.kshrc
#      user             initializations go in ~/.profile
#      host / all_user  initializations go in /etc/profile
#      hard / software  initializations go in /etc/environment

[[ $- != *i* ]] && return
# options for interactive shells follow-------------------------

TTY=$(tty|cut -f3-4 -d/)
HISTFILE=$HOME/.sh_hist$(echo ${TTY} | tr -d '/')
PWD=$(pwd)
# aliases
alias ls='ls --color=auto'

export XDG_DATA_DIRS=" /usr/local/share:/usr/share"
export NNN_BMS='d:~/documents;u:/home/user/glyphe Uploads;D:~/temp/'
export NNN_SSHFS="sshfs -o follow_symlinks"        # make sshfs follow symlinks on the remote
export NNN_COLORS="2136"                           # use a different color for each context
export NNN_TRASH=0                                 # trash (needs trash-cli) instead of delete
export NNN_PLUG='f:finder;o:fzopen;p:preview-tui;d:diffs;t:nmount;v:imgview;n:nuke'
export NNN_USE_EDITOR=1
export NNN_COLORS='4231'
export VISUAL=nvim
n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    tmux new-session \nnn -C -a -P p "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
alias nnn="n"

PS1='[\u@\h \W]\$ '
export TERM="st-256color"
export COLORTERM="truecolor"

. "$HOME/.cargo/env"

export GOPROXY=direct
export GOSUMDB=off

HISTFILE="$HOME/.ksh_history"
HISTSIZE=5000
set -o vi

set +o allexport
