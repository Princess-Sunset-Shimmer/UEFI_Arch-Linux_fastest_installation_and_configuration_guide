[[ $- != *i* ]] && return

alias ip='ip --color=always'
alias grep='grep --color=always'
alias diff='diff --color=always'
alias pacman='pacman --color=always'
alias rm='rm -f'
alias wget='wget -c'
alias dd='dd status=progress'
alias ps='ps -uf'

ls() {
  command ls --color=always -alh $@|sort|grep '^b\|:\|\.\|root\|'|GREP_COLORS='ms=01;34' grep '^d\|-\|>\|/\|_\|'|GREP_COLORS='ms=01;32' grep '^total\|'|GREP_COLORS='ms=01;36' grep '^l\|'|GREP_COLORS='ms=01;33' grep '^c\|'
}

file() {
  command file $@|grep '/\|-\|+\|'|GREP_COLORS='ms=01;34' grep ':\|\.\|,\|#\|)\|(\|_\|'
}

cat() {
  command cat $@|grep '\.\|,\|;\|:\|_\|}\|{\|)\|(\|]\|\[\|\\\|\$\|#\|?\|!\|@\|`\|"\|'|grep "'\|"|GREP_COLORS='ms=01;34' grep '+\|-\|*\|/\|%\|=\|>\|<\|&\||\|\^\|~\|'
}

lsblk() {
  command lsblk $@|grep ']\|\[\|RM\|RO\|FS\|disk\|%\|'|GREP_COLORS='ms=01;34' grep '^NAME\|SIZE\|TYPE\|SWAP\|\.\|:\|/\|-\|VER\|AVAIL\|UUID\|USE\|'
}

lspci() {
  command lspci -tv $@|grep ']\|\[\|+\|-\||\|\\\|/\|'|GREP_COLORS='ms=01;34' grep '\.\|:\|,\|'
}

PS1="\[\e[2B\e[4C\e[0;36;40m__\e[1;35;44m \u \e[0;36;40m\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m <\l> [\w]\e[K\e[u\e[0;36;40m\]"
PS0='\e[12C\e[1;32m|\\/|\n\e[12C\e[1;36m|  |\e[1;32;44m \h \e[1;34;40m\n\e[13C\\/\n\e[1;37m'
if [[ $EUID == 0 ]]
then
  PS1="\[\e[2B\e[4C\e[1;33;40m__\e[0;31;43m \u \e[1;33;40m\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m <\l> [\w]\e[K\e[u\e[1;33;40m\]"
  ps0='\e[12C\e[1;33m|\\/|\n\e[12C\e[1;31m|  |\e[1;32;43m \h \e[0;31;40m\n\e[13C\\/\n\e[1;37m'
else
  clear
fi
