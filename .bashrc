#
# ~/.bashrc
#

# If not running interactively, don't do anything
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

# Colorize tools
alias ls='ls --color=auto'
alias ip='ip --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

PROMPT_DIRTRIM=4
PS1='[\u@\h \w]\$ '

# stty werase ^W
shopt -s autocd
shopt -s histappend
shopt -s lithist # preserve mulitline history

# Enter tmux copy-mode by `scrolling` buffer without chords
bind -x '"\C-u":tmux copy-mode'
