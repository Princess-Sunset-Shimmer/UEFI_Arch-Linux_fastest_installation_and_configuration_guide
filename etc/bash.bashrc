alias ip='ip --color=always'
alias grep='grep --color=always'
alias diff='diff --color=always'
alias rm='rm -f'
alias wget='wget -c'
alias dd='dd status=progress'
alias ps='ps -uf'

ls() {
  command ls --color=always -FAXlh "$@" |\
  command grep --color=always '^b\|:\|\.\|root\|' |\
  GREP_COLORS='ms=01;34'\
  command grep --color=always '^d\|/\|_\|' |\
  GREP_COLORS='ms=01;32'\
  command grep --color=always '^total\|-\|>\|' |\
  GREP_COLORS='ms=01;36'\
  command grep --color=always '^l\|' |\
  GREP_COLORS='ms=01;33'\
  command grep --color=always '^c\|*\|'
}

cd() {
 command cd "$@"; ls
}

file() {
  command file "$@" |\
  command grep --color=always 'block\|/\|-\|+\|' |\
  GREP_COLORS='ms=01;34'\
  command grep --color=always 'directory\|:\|\.\|,\|#\|)\|(\|_\|' |\
  GREP_COLORS='ms=01;36'\
  command grep --color=always 'link\|' |\
  GREP_COLORS='ms=01;33'\
  command grep --color=always 'character\|'
}

cat() {
  command cat "$@" |\
  command grep --color=always '\.\|,\|;\|:\|_\|}\|{\|)\|(\|]\|\[\|\\\|\$\|#\|?\|!\|@\|`\|"\|' |\
  command grep --color=always "'\|" |\
  GREP_COLORS='ms=01;34'\
  command grep --color=always '+\|-\|*\|/\|%\|=\|>\|<\|&\||\|\^\|~\|'
}

lsblk() {
  command lsblk "$@" |\
  command grep --color=always ']\|\[\|RM\|RO\|FS\|disk\|%\|' |\
  GREP_COLORS='ms=01;34'\
  command grep --color=always '^NAME\|SIZE\|TYPE\|SWAP\|\.\|:\|/\|-\|VER\|AVAIL\|UUID\|USE\|'
}

lspci() {
  command lspci -tv "$@" |\
  command grep --color=always ']\|\[\|+\|-\||\|\\\|/\|' |\
  GREP_COLORS='ms=01;34'\
  command grep --color=always '\.\|:\|,\|'
}

findmnt() {
  command findmnt "$@" |\
  command grep --color=always 'TARGET\|SOURCE\|FSTYPE\|OPTIONS\|' |\
  GREP_COLORS='ms=01;36'\
  command grep --color=always ',\|=\|' |\
  GREP_COLORS='ms=01;32'\
  command grep --color=always '/\|'
}

pacman() {
  case $1 in
    upgrade)
      shift 1; command pacman --color=always -Syu $@
      ;;
    install)
      shift 1; command pacman --color=always -S $@
      ;;
    remove)
      shift 1; command pacman --color=always -Runs $@
      ;;
    autoremove)
      orph="$(command pacman -Qdtq)"
      if [[ -n $2 ]] || [[ -n $orph ]]; then
        shift 1; command pacman --color=always -Runs $@ $orph
      else echo '0 package removed'; fi
      ;;
    clean)
      shift 1; command pacman --color=always -Scc $@
      ;;
    search)
      if [[ $2 == group ]]; then
        shift 2; command pacman --color=always -Sgg $@
      else shift 1; command pacman --color=always -Ss $@; fi
      ;;
    info)
      shift 1; command pacman --color=always -Sii $@
      ;;
    list)
      case $2 in
        installed)
          shift 2; command pacman --color=always -Qet $@
          ;;
        available)
          shift 2; command pacman --color=always -Qs $@
          ;;
        orphan)
          shift 2; command pacman --color=always -Qdt $@
          ;;
        group)
          shift 2; command pacman --color=always -Qg $@
          ;;
        *)
          shift 1; command pacman --color=always -Q $@
          ;;
      esac
      ;;
    *)
      command pacman --color=always $@
      ;;
  esac
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
