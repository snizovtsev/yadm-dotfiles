#
# ~/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
[[ $- != *i* ]] && return

if [[ -f /usr/share/doc/pkgfile/command-not-found.bash ]]; then
	. /usr/share/doc/pkgfile/command-not-found.bash
fi

if [[ -r /usr/share/doc/mcfly/mcfly.bash ]]; then
	. /usr/share/doc/mcfly/mcfly.bash
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

#
# Configure functions and aliases
#

use_color=true
if ${use_color} ; then
	alias grep='grep --color=auto'
	alias egrep='egrep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias diff='diff --color=auto'
	alias ip='ip --color=auto'
	alias ls='ls --color=auto'
fi

#
# Configure PROMPT and history
#

# Save each command to the history file as it's executed.
# This does mean sessions get interleaved when reading later on, but this
# way the history is always up to date.  History is not synced across live
# sessions though; that is what `history -n` does.
# Disabled by default due to concerns related to system recovery when $HOME
# is under duress, or lives somewhere flaky (like NFS).  Constantly syncing
# the history will halt the shell prompt until it's finished.
PROMPT_COMMAND='history -a'

# Huge history
HISTSIZE=500 # Longer sessions is probably an accident copy-paste
HISTFILESIZE=10000

# Helpful history
HISTCONTROL="ignoredups:ignorespace"
HISTTIMEFORMAT='%F %T ' # Enable timestamping and show it in ISO 8601 format
export HISTIGNORE="ls:bg *:fg *:df *"

# If set to a number greater than zero, the value is used as the number of
# trailing directory components to retain when expanding the \w and \W prompt
# string escapes. Characters removed are replaced with an ellipsis.
PROMPT_DIRTRIM=4

YELLOW="\[$(tput setaf 3)\]"
RESET="\[$(tput sgr0)\]"
PROMPT_MARKER=" "
#PS1="${YELLOW}[${RESET}\u@\h \w${YELLOW}]${RESET}\$${PROMPT_MARKER}"
PS1="\$${PROMPT_MARKER}"
PROMPT_COMMAND=~/mimir
unset YELLOW RESET

#
# Configure bash behaviour
#

shopt -s autocd       # cd without cd
shopt -s checkwinsize # check the terminal size when it regains control
shopt -s globstar     # turn on recursive globbing
shopt -s histappend   # append history file, don't overwrite it
shopt -s cmdhist      # preserve mulitline commands in the history 
shopt -s lithist      # ... and store them as embedded newlines
shopt -s histverify   # verify history expansions before executing

#
# Configure keyboard bindings
#

# Enter tmux copy-mode and jump to the start of last PROMPT
bind -x "\"\\C-u\":tmux copy-mode; tmux send-keys -X search-backward \"${PROMPT_MARKER}\""

# stty werase ^W

#
# Try to keep environment pollution down
#
unset use_color PROMPT_MARKER
