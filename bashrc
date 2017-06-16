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
export PATH=$PATH:$GOPATH/bin:$HOME/.local/bin:$HOME/bin:/usr/local/go/bin

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

source ~/.bash_aliases
if [ -e /etc/bash_completion ]; then 
  source /etc/bash_completion
fi

if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi

