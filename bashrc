export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Colourize All the Things
alias ls='ls -CF --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='colordiff'

# Set some sane defaults
alias df='df -h'
alias du='du -ch'
alias mv='mv -v'
alias cp='cp -v'
alias rm='rm -v'
alias ln='ln -v'
alias diff='diff -u'
alias free='free -mlth'

# I am seriously lazy
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../../..'
alias .......='cd ../../../../../../..'
alias ........='cd ../../../../../../../..'
alias .........='cd ../../../../../../../../..'

# new commands
alias du1='du --max-depth=1'
alias ll='ls -lF'
alias la='ls -A'
alias pcinfo='inxi -v6 -c10'
alias grouplist='cut -d: -f1 /etc/group'

# git
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias changelog='git log `git log -1 --format=%H -- CHANGELOG*`..; cat CHANGELOG*'

# Create parent directories
alias mkdir='mkdir -pv'

# Continue downloads by default
alias wget='wget -c'

# handy shortcuts
alias showports='sudo netstat -tulpn'

# Case insensitive grepping!
alias igrep='grep -i'

# Search for only uncommented linkes
alias uncomment="grep -vE '^#|^$' "

# I hate Mondays...
alias fuck='sudo $(history -p \!\!)'

# Octal permissions
alias operms="stat -c '%A %a %n' "

# Useful for looking crap up
rtfm() { $@ --help 2> /dev/null || man $@ 2> /dev/null || open "http://www.google.com/search?q=$@"; }

# cd then ls immediately
function cd() { command cd "$1" && ls; }

# Parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# do not delete / or prompt if deleting more than 3 files at a time
alias rm='rm -I --preserve-root'

# Simple system update
alias upgrade='sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoremove && sudo apt-get autoclean && (sudo npm -g update || true) && (sudo gem update || true)'

# Use newer version
alias irssi='/usr/local/bin/irssi'


# Fortune time
if [ ${TERM} != 'dumb' ]; then
  if [ -x /usr/games/cowthink -a -x /usr/games/fortune -a -x /usr/games/lolcat ]; then
    fortune | cowthink | lolcat
  fi
fi
