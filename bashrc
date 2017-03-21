# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# PATH Time
export EDITOR='vim'
export VISUAL='vim'
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$HOME/.local/bin:$HOME/bin

# cd then ls immediately, show git branch if approperiate
function cd() {
  if [ -n "$1" ]; then
    builtin cd "$1";
  else
    builtin cd ~;
  fi
  if [ -d "./.git" ]; then
    GIT_STATUS=$(git branch --color | grep \* | cut --complement -f 1 -d ' ')
    echo "Git Branch: ${GIT_STATUS}";
  fi
  ls;
}

# disable crontab -r
function crontab {
  /usr/bin/crontab "${@/-r/-e}"
}

# Show Open Files
function openfiles {
  if [ "${1}" = "-h" ]; then
    echo -e "Usage: openfiles [r|w|m|R|W] regex\n    -r    opened for reading or read/write\n    -w    opened for writing or read/write\n    -m    accessed from memory (includes running command)\n    -R    opened for reading only\n    -W    opened for writing only"
    return
  fi
  if [ "$#" = "0" ]; then
    echo "Process signature/regex required."
    return
  fi
  MODE="(w|u)"
  ACTION="for writing"
  if [ "${1}" = "r" ]; then
    MODE="(r|u)"
    ACTION="for reading"
    shift
  elif [ "${1}" = "R" ]; then
    MODE="r"
    ACTION="for reading (only)"
    shift
  elif [ "${1}" = "W" ]; then
    MODE="w"
    ACTION="for writing (only)"
    shift
  elif [ "${1}" = "m" ]; then
    MODE="(txt|mem)"
    ACTION="in memory"
    shift
  elif [ "${1}" = "w" ]; then
    shift
  fi
  if [ "${MODE}" != "(txt|mem)" ]; then
    MODE="[0-9]+${MODE}"
  fi
  PIDS=$(pgrep -d "," -f "${@}")
  if [ "${PIDS}" = "" ]; then
    echo "No processes found matching '${@}'."
    return
  fi
  OPENFILES=$(sudo lsof -PXn -p ${PIDS} | egrep "${MODE}[A-Za-z]* +REG" | awk '{print $9}' | egrep -v "^\[" | sort | uniq);
  if [ "${OPENFILES}" = "" ]; then
    echo "No files opened ${ACTION}."
  else
    echo "Files opened ${ACTION}:"
    sudo ls -ahl $OPENFILES
  fi
}

# Listening Ports
function listening {
  if [ "${1}" = "-h" ]; then
    echo "Usage: listening [t|tcp|u|udp] [ps regex]"
    return
  fi
  DISP="both"
  NSOPTS="tu"
  if [ "${1}" = "t" -o "${1}" = "tcp" ]; then
    DISP="tcp"
    NSOPTS="t"
    shift
  elif [ "${1}" = "u" -o "${1}" = "udp" ]; then
    DISP="udp"
    NSOPTS="u"
    shift
  fi
  FILTER="${@}"
  PORTS_PIDS=$(sudo netstat -"${NSOPTS}"lnp | tail -n +3 | tr -s ' ' | sed -n 's/\(tcp\|udp\) [0-9]* [0-9]* \(::\|0\.0\.0\.0\|127\.[0-9]*\.[0-9]*\.[0-9]*\):\([0-9]*\) .* \(-\|\([0-9-]*\)\/.*\)/\3 \1 \5 \2/p' | sed 's/\(::\|0\.0\.0\.0\)/EXTERNAL/' | sed 's/127\.[0-9]*\.[0-9]*\.[0-9]*/LOCALHOST/' | sort -n | tr ' ' ':' | sed 's/::/:-:/' | sed 's/:$//' | uniq)
  PS=$(sudo ps -e --format '%p %a')
  echo -e '   Port - Protocol - Interface - Program\n-----------------------------------------------'
  for PORT_PID in ${PORTS_PIDS}; do
    PORT=$(echo ${PORT_PID} | cut -d':' -f1)
    PROTOCOL=$(echo ${PORT_PID} | cut -d':' -f2)
    PID=$(echo ${PORT_PID} | cut -d':' -f3)
    INTERFACE=$(echo ${PORT_PID} | cut -d':' -f4)
    if [ "${PROTOCOL}" != "${DISP}" -a "${DISP}" != "both" ]; then
      continue
    fi
    if [ "${PID}" = "-" ]; then
      if [ "${FILTER}" != "" ]; then
        continue
      fi
      printf "%7s - %8s - %9s - -\n" "${PORT}" "${PROTOCOL}" "${INTERFACE}"
    else
      PROG=$(echo "${PS}" | grep "^ *${PID}" | grep -o '[0-9] .*' | cut -d' ' -f2-)
      if [ "${FILTER}" != "" ]; then
        echo "${PROG}" | grep -q "${FILTER}"
        if [ $? -ne 0 ]; then
          continue
        fi
      fi
      printf "%7s - %8s - %9s - %s\n" "${PORT}" "${PROTOCOL}" "${INTERFACE}" "${PROG}"
    fi
  done
}

# Setup my prompt
## Normal User
if [[ $EUID -ne 0 ]]; then
  export PS1="\[$(tput bold)\]\[$(tput setaf 0)\]-\[$(tput setaf 6)\] \h \[$(tput setaf 0)\]| \t |\[$(tput setaf 6)\] \W\[$(tput setaf 0)\] -\\$ \[$(tput sgr0)\]\[$(tput sgr0)\]"
else
## root
  export PS1="\[$(tput bold)\]\[$(tput setaf 0)\]-\[$(tput setaf 1)\] \h \[$(tput setaf 0)\]| \t |\[$(tput setaf 1)\] \W\[$(tput setaf 0)\] -\\$ \[$(tput sgr0)\]\[$(tput sgr0)\]"
fi

# Man page colours:
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
export LESS=cR

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
