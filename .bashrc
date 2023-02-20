#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if ! pgrep -u "${USER}" ssh-agent > /dev/null
then
    ssh-agent > ~/.ssh-agent-data
fi
if [ -z "${SSH_AGENT_PID}" ]
then
    eval "$(<~/.ssh-agent-data)"
fi

et() { (gvim -geometry 110x70 "$@" &) }

alias ls='ls --color=auto'
alias vi='vim'
## Original prompt
PS1='[\u@\h \W]\$ '

## Error-notifying prompt
PS1="${PS1%\\\$ }\$(last_exit=\"\$?\";(( last_exit == 0 )) || printf \"\[\e[1;31m\](err: %d)\[\e[0m\]\" \${last_exit})\\\$ "
