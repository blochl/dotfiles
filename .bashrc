#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# For ssh-agent, activated by: 'systemctl --user enable ssh-agent.service --now' (openssh 9.4p1-3 and up)
# (Works after adding the line 'AddKeysToAgent yes' to the needed keys in ~/.ssh/config)
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

et() { (gvim -geometry 110x70 "$@" &) }

alias ls='ls --color=auto'
alias vi='vim'

## Original prompt
PS1='[\u@\h \W]\$ '

## Error-notifying prompt
PS1="${PS1%\\\$ }\$(last_exit=\"\$?\";(( last_exit == 0 )) || printf \"\[\e[1;31m\](err: %d)\[\e[0m\]\" \${last_exit})\\\$ "
## The below REPLACES the line above on Ubuntu specifically!
## Purpose: to print the prompt in purple instead of green if HISTFILE is unset,
## and you might want to unset it while running some routine commands, in order
## not to contaminate the history with them.
#PS1="\$(last_exit=\"\$?\";(( last_exit == 0 )) || printf \"\[\e[1;31m\](err: %d)\[\e[0m\] \" \${last_exit})${PS1}"
#PS1="${PS1/32m/\$([ -n \"\${HISTFILE\}\" ] \&\& printf \'32m\' || printf \'35m\')}"
