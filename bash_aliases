# Colourize All the Things
alias ls='ls -CF --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='colordiff'
alias less='less -R'

# Set some sane defaults
alias df='df -h'
alias du='du -ch'
alias mv='mv -v'
alias cp='cp -v'
alias rm='rm -v'
alias ln='ln -v'
alias diff='diff -u'
alias free='free -mlth'

# Never run as root, always sudo
alias su='su -'
alias sudo='sudo ' #Fix alias post-sudo

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

# Generate some random passwords
alias pass='pwgen -s1 18 5'

# Get IPv4 address
alias ipv4="ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print \$2}' | cut -f1  -d'/'"

# Create parent directories
alias mkdir='mkdir -pv'

# Continue downloads by default
alias wget='wget -c --content-disposition'

# handy shortcuts
alias showports='sudo netstat -tulpn'

# Case insensitive grepping!
alias igrep='grep -i'

# List running services
alias servicelist='systemctl --no-page --no-legend --plain -t service --state=running'

# Search for only uncommented linkes
alias uncomment="grep -vE '^#|^$' "

# I hate Mondays...
alias fuck='sudo $(history -p \!\!)'

# Octal permissions
alias operms="stat -c '%A %a %n' "

# Parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# do not delete / or prompt if deleting more than 3 files at a time
alias rm='rm -I --preserve-root'

# External Tools
alias weather='curl wttr.in/Halifax'
alias moon=' curl wttr.in/Moon'
