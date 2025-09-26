# USER #=====================================================================#

host_name="host"
user_name="user"
group="audio,video,storage"
remove_and_link_root_directory='on'

# NETWORK #==================================================================#

network_manager_auto_start='on'
network_optimization='on'
hblock='on'
hblock_auto_update='on'

# BOOT #=====================================================================#

kernel="/vmlinuz-linux"
ram_file_system="/initramfs-linux.img"
microcode="/amd-ucode.img"
silent_boot='on'
bootloader_auto_update='on'

# CPU #======================================================================#

side_channel_attack_mitigation='off'
irq_balance='on'
ananicy_cpp='on'

# RAM #======================================================================#

virtual_memory_optimization='on'
swap_memory_compression='on'
preload='on'

# STORAGE #==================================================================#

ssd_trim='on'
abandon_core_dump_file='on'

# LANGUAGE AND TIMEZONE #====================================================#

language="C.UTF-8 UTF-8"
keyboard=""
font=""
timezone=""

# SOUND #====================================================================#

pipewire_pulse='off'
pipewire_alsa='on'
alsa_utils='on'
sof_firmware='off'

# TERMINAL #=================================================================#

login_shell_top_bar='on'
login_shell_text_graph='on'

interactive_shell_top_bar='on'

enhance_tab_completion='on'
mouse='off'

user_command_prompt_color=""
user_command_prompt_arrow_color=""
user_command_prompt_line_color=""
root_command_prompt_color=""
root_command_prompt_arrow_color=""
root_command_prompt_line_color=""

tmux='on'
customize_tmux='on'

# PACKAGE MANAGER #==========================================================#

progress_bar='on'
parallel_download='on'
architecture=""
pacman_contrib='on'
pacman_alias='on'
pacman_fzf_alias='on'

chaotic_aur='on'
multilib='off'

reflector='on'
reflector_customization='on'
reflector_autostart='on'

# DEVOLEPER UTILITIES #======================================================#

nano='off'

vim='on'
line_number='on'
line_wrap='off'
hilight_current_line='off'
fold='on'
enhance_search='on'
expand_tab='on'
indent_size='4'
indent='on'

base_devel='on'
cmake='on'
git='on'
github_cli='on'

calc='on'

# SYSTEM UTILITIES #=========================================================#

general_alias='on'

fzf='on'
fzf_alias='on'

customize_top='on'

btop='on'

dust='on'

tldr='on'

less='on'
less_alias='on'

fastfetch='on'
interactive_shell_fastfetch='on'
fastfetch_clear_alias='on'
customize_fastfetch='on'
fastfetch_style="1"
customize_arch_logo='on'
fastfetch_logo="arch3"
fastfetch_separator="[> "
fastfetch_separator_color="yellow"
fastfetch_system_name_color="blue"
fastfetch_system_info_color="cyan"
fastfetch_software_info_color="green"
fastfetch_hardware_info_color="magenta"

# NETWORK UTILITIES #========================================================#

wget='on'
wget_alias='on'

transmission_remote='on'

# MEDIA UTILITIES #==========================================================#

mpv='on'
youtube_dl='on'

ytfzf='on'

cmus='off'

cava='on'

# OTHER PACKAGES #===========================================================#

cmatrix='on'

calcurse='on'
cal_colors='on'
cal_alias='on'

#============================================================================#

command echo -e '\e[1;36;40m ***\e[1;34;40m generating <_pacman_> Config-File\e[1;36;40m ***\e[m'
if [[ ${progress_bar} == off ]]; then progress_bar='NoProgressBar'; else progress_bar='ILoveCandy'; fi
if [[ -n ${architecture} ]]; then architecture="Architecture = ${architecture}"; else architecture='Architecture = auto'; fi
[[ ${pacman_fzf_alias} == on ]] && pacman_alias='off'
command cat << EOF > /etc/pacman.conf
[options]
HoldPkg = pacman glibc
${architecture}
CheckSpace
${progress_bar}
SigLevel = Required DatabaseOptional
LocalFileSigLevel = Optional
EOF
[[ ${parallel_download} == on ]] && command echo 'ParallelDownloads = 8' >> /etc/pacman.conf
command cat << EOF >> /etc/pacman.conf
[core]
Include = /etc/pacman.d/mirrorlist
[extra]
Include = /etc/pacman.d/mirrorlist
EOF
if [[ ${chaotic_aur} == on ]]; then
    command pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    command pacman-ley --lsign-key 3056513887B78AEB
    command pacman -U --color=always --noconfirm https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst
    if command pacman -U --color=always --noconfirm https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst; then
        command cat << 'EOF' >> /etc/pacman.conf
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
    else
        command echo -e '\e[0;31;40m Setup Fail: unsuccessfully append Chaotic-AUR repo\e[m'
        command exit 1
    fi
else
    command pacman -Runs --color=always --noconfirm chaotic-keyring chaotic-mirrorlist
fi
[[ ${multilib} == on ]] && command cat << 'EOF' >> /etc/pacman.conf
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF
command cat /etc/pacman.conf

command echo -e '\e[1;36;40m ***\e[1;34;40m installing Packages\e[1;36;40m ***\e[m'
if [[ ${hblock} == on ]]; then hblock=' hblock'; else hblock=''; fi
if [[ ${irq_balance} == on ]]; then irq_balance=' irqbalance'; else irq_balance=''; fi
if [[ ${ananicy_cpp} == on ]]; then ananicy_cpp=' ananicy-cpp'; else ananicy_cpp=''; fi
if [[ ${preload} == on ]]; then preload=' preload'; else preload=''; fi
if [[ ${nano} == on ]]; then nano=' nano'; else nano=''; fi
if [[ ${vim} == on ]] || [[ ${general_alias} == on ]]; then vim=' vim'; else vim=''; fi
if [[ ${base_devel} == on ]]; then base_devel=' base-devel'; else base_devel=''; fi
if [[ ${cmake} == on ]]; then cmake=' cmake'; else cmake='';fi
if [[ ${git} == on ]]; then git=' git'; else git=''; fi
if [[ ${github_cli} == on ]]; then github_cli=' github-cli'; else github_cli=''; fi
if [[ ${calc} == on ]]; then calc=' calc'; else calc=''; fi
if [[ ${fzf} == on ]] || [[ ${general_alias} == on ]] || [[ ${pacman_fzf_alias} == on ]]; then fzf=' fzf'; else fzf=''; fi
if [[ ${wget} == on ]]; then wget=' wget'; else wget=''; fi
if [[ ${transmission_remote} == on ]]; then transmission_remote=' transmission-cli'; else transmission_remote=''; fi
if [[ ${pipewire_pulse} == on ]]; then pipewire_pulse=' pipewire-pulse'; else pipewire_pulse=''; fi
if [[ ${pipewire_alsa} == on ]]; then pipewire_alsa=' pipewire-alsa'; else pipewire_alsa=''; fi
if [[ ${alsa_utils} == on ]]; then alsa_utils=' alsa-utils'; else alsa_utils=''; fi
if [[ ${sof_firmware} == on ]]; then sof_firmware=' sof-firmware'; else sof_firmware=''; fi
if [[ ${pacman_contrib} == on ]]; then pacman_contrib=' pacman-contrib'; else pacman_contrib=''; fi
if [[ ${reflector} == on ]]; then reflector=' reflector'; else reflector=''; fi
if [[ ${btop} == on ]]; then btop=' btop'; else btop=''; fi
if [[ ${dust} == on ]]; then dust=' dust'; else dust=''; fi
if [[ ${tldr} == on ]]; then tldr=' tldr'; else tldr=''; fi
if [[ ${less} == on ]]; then less=' less'; else less=''; fi
if [[ ${fastfetch} == on ]]; then fastfetch=' fastfetch'; else fastfetch=''; fi
if [[ ${tmux} == on ]]; then tmux=' tmux'; else tmux=''; fi
if [[ ${mpv} == on ]]; then mpv=' mpv'; else mpv=''; fi
if [[ ${youtube_dl} == on ]]; then youtube_dl=' youtube-dl-git'; else youtube_dl=''; fi
if [[ ${ytfzf} == on ]]; then ytfzf=' ytfzf'; else ytfzf=''; fi
if [[ ${cmus} == on ]]; then cmus=' cmus'; else cmus=''; fi
if [[ ${cava} == on ]]; then cava=' cava'; else cava=''; fi
if [[ ${cmatrix} == on ]]; then cmatrix=' cmatrix'; else cmatrix=''; fi
if [[ ${calcurse} == on ]]; then calcurse=' calcurse'; else calcurse=''; fi
if command pacman -Syyu --color=always --noconfirm${hblock}${irq_balance}${nano}${vim}${base_devel}${cmake}${git}${github_cli}${calc}\
${fzf}${wget}${transmission_remote}${pipewire_alsa}${alsa_utils}${sof_firmware}${pacman_contrib}${reflector}\
${btop}${dust}${tldr}${less}${fastfetch}${tmux}${mpv}${youtube_dl}${ytfzf}${cmus}${cava}${cmatrix}${calcurse}${ananicy_cpp}${preload}
then command echo -e '\e[1;32;40m packages successfully be installed\e[m'
else command echo -e '\e[0;31;40m Setup Fail: <_pacman_> did not finish work\e[m'; command exit 1; fi

command echo -e '\e[1;36;40m ***\e[1;34;40m creating User\e[1;36;40m ***\e[m'
[[ -z ${host_name} ]] && host_name='host'
command echo "${host_name}" > /etc/hostname; command cat /etc/hostname
[[ -z ${user_name} ]] && user_name='user'
command userdel "${user_name}"
command useradd -m "${user_name}"; [[ -n ${group} ]] && command usermod -aG "${group}" "${user_name}";
command rm -f /home/"${user_name}"/.bash*; command su -c "mkdir /home/\"${user_name}\"/.config" "${user_name}"
command ls --color=always -FAXhl /home/"${user_name}"
if [[ ${remove_and_link_root_directory} == on ]]
    then command cd /; command rm -fr /root; command ln -sf /home/"${user_name}" /root; command file /root; fi

command echo -e '\e[1;36;40m ***\e[1;34;40m configuring Packages\e[1;36;40m ***\e[m'
if [[ -z ${hblock} ]]
    then command pacman -Runs --color=always --noconfirm hblock; command echo '' > /etc/hosts; hblock_auto_update='off'
    else command hblock; fi
[[ -z ${irq_balance} ]] && command pacman -Runs --color=always --noconfirm irqbalance
[[ -z ${ananicy_cpp} ]] && command pacman -Runs --color=always --noconfirm ananicy-cpp
[[ -z ${preload} ]] && command pacman -Runs --color=always --noconfirm preload
[[ -z ${nano} ]] && command pacman -Runs --color=always --noconfirm nano
if [[ -z ${vim} ]]; then command pacman --Runs --color=always --noconfirm vim
else
    command echo -e "runtime! archlinux.vim\n:set tabstop=${indent_size}\n:set softtabstop=${indent_size}\n:set shiftwidth=${indent_size}" > /etc/vimrc
    [[ ${line_number} == on ]] && command echo ':set number' >> /etc/vimrc
    [[ ${line_wrap} != on ]] && command echo ':set nowrap' >> /etc/vimrc
    [[ ${expand_tab} == on ]] && command echo ':set expandtab' >> /etc/vimrc
    [[ ${indent} == on ]] && command echo ":set autoindent\n:set smartindent" >> /etc/vimrc
    [[ ${fold} == on ]] && command echo ':set foldmethod=indent' >> /etc/vimrc
    [[ ${hilight_current_line} == on ]] && command echo ':set cursorline' >> /etc/vimrc
    [[ ${enhance_search} == on ]] && command echo -e ':set incsearch\n:set hlsearch' >> /etc/vimrc
    command ls --color=always -l /etc/vimrc
fi
[[ -z ${base_devel} ]] && command pacman -Runs --color=always --noconfirm base-devel
[[ -z ${cmake} ]] && command pacman -Runs --color=always --noconfirm cmake
[[ -z ${git} ]] && command pacman -Runs --color=always --noconfirm git
[[ -z ${github_cli} ]] && command pacman -Runs --color=always --noconfirm github-cli
[[ -z ${calc} ]] && command pacman -Runs --color=always --noconfirm calc
if [[ -z ${fzf} ]]; then fzf_alias='off'; command pacman -Runs --color=always --noconfirm fzf; fi
if [[ -z ${wget} ]]; then command pacman -Runs --color=always --noconfirm wget; wget_alias='off'; fi
[[ -z ${transmission_remote} ]] && command pacman -Runs --color=always --noconfirm transmission-cli
[[ -z ${dust} ]] && command pacman -Runs --color=always --noconfirm dust
[[ -z ${pipewire_pulse} ]] && command pacman -Runs --color=always --noconfirm pipewire-pulse
[[ -z ${pipewire_alsa} ]] && command pacman -Runs --color=always --noconfirm pipewire-alsa
[[ -z ${alsa_utils} ]] && command pacman -Runs --color=always --noconfirm alsa-utils
[[ -z ${sof_firmware} ]] && command pacman -Runs --color=always --noconfirm sof-firmware
[[ -z ${pacman_contrib} ]] && command pacman -Runs --color=always pacman-contrib
if [[ -z ${reflector} ]]
    then command pacman -Runs --color=always reflector
    else [[ ${reflector_customization} == on ]] && command cat << 'EOF' > /etc/xdg/reflector/reflector.conf
--save /etc/pacman.d/mirrorlist
--protocol https
--ipv4
--latest 8
--sort rate
EOF
fi
if [[ -z ${btop} ]]; then
    command pacman -Runs --color=always --noconfirm btop
    command rm -vfr /home/"${user_name}"/.config/btop
fi
[[ -z ${tldr} ]] && command pacman -Runs --color=always --noconfirm tldr
if [[ -z ${less} ]]; then command pacman -Runs --color=always --noconfirm less; less_alias='off'; fi
if [[ -z ${fastfetch} ]]; then
    command pacman -Runs --color=always --noconfirm fastfetch
    customize_fastfetch='off'; interactive_shell_fastfetch='off'; fastfetch_clear_alias='off'
    [[ -e /home/"${user_name}/.config/fastfetch" ]] && command rm -vfr /home/"${user_name}"/.config/fastfetch
elif [[ ${customize_fastfetch} == on ]]; then
    command su -c "mkdir /home/\"${user_name}\"/.config/fastfetch" "${user_name}"
    if [[ ${customize_arch_logo} == on ]]; then
        command cat << 'EOF' | command cat > "/home/${user_name}/.config/fastfetch/logo"
                  .
                 / \
                /   \
               /     \
              /       \
             />,       \
            /  `*.      \
           /      `      \
          /               \
         /                 \
$2        /      ,.-+-..      \
       /      ,/'   `\.      \
      /      .|'     `|.   _  \
     /       :|.     ,|;    `+.\
    /        .\:     ;/,      "<\
   /     __,--+"     "+--.__     \
  /  _,+'"                 "'+._  \
 /,-'                           `-.\
'                                   '
EOF
        command chown "${user_name}":"${user_name}" /home/"${user_name}"/.config/fastfetch/logo
        fastfetch_logo="/home/${user_name}/.config/fastfetch/logo"
    fi
    case ${fastfetch_style} in
        1)
            [[ -z ${fastfetch_logo} ]] && fastfetch_logo='arch3'
            [[ -z ${fastfetch_separator} ]] && fastfetch_separator='[> '
            [[ -z ${fastfetch_separator_color} ]] && fastfetch_separator_color='yellow'
            [[ -z ${fastfetch_system_name_color} ]] && fastfetch_system_name_color='blue'
            [[ -z ${fastfetch_system_info_color} ]] && fastfetch_system_info_color='cyan'
            [[ -z ${fastfetch_software_info_color} ]] && fastfetch_software_info_color='green'
            [[ -z ${fastfetch_hardware_info_color} ]] && fastfetch_hardware_info_color='magenta'
            command cat << EOF > "/home/${user_name}/.config/fastfetch/config.jsonc"
{
  "logo":{"source":"${fastfetch_logo}"},
  "display":{
    "color":{"separator":"${fastfetch_separator_color}", "output":"${fastfetch_system_info_color}"},
    "separator":"${fastfetch_separator}",
    "percent":{"type":["num","bar"},
    "bar":{"char":{"elapsed":"I", "char.total":"_"}, "border":{"left":"{", "border.right":"}"}, "width":16}
  },
  "modules":[ 
    {"type":"kernel", "key":"   /\\\\rch  ", "keyColor":"${fastfetch_system_name_color}"},
    {"type":"custom", "format":"/~~~~~~~~~~\\\\___________________________/", "outputColor":"separator"},
    {"type":"uptime", "key":"  Uptime    ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"shell", "key":"  Shell     ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"terminal", "key":"  Terminal  ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"terminalfont", "key":"  Font      ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"packages", "key":"  Packages  ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"localip", "key":"  Local IP  ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"custom", "format":"\\\\__________/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\\\\", "outputColor":"separator"},
    {"type":"display", "key":"  Display ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{7} {1}x{2} ({13} ppi) {3}Hz"},
    {"type":"cpu", "key":"  CPU     ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{1} ({3}C{4}T) {6} ~ {7}"},
    {"type":"gpu", "key":"  GPU     ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{6} {2}"},
    {"type":"memory", "key":"  RAM     ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{4} {3} > {1} / {2} >"},
    {"type":"swap", "key":"  SWAP    ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{4} {3} > {1} / {2} >"},
    {"type":"disk", "key":"  Disk    ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{13} {3} > {1} / {2} > {9} >"},
    {"type":"battery", "key":"  Battery ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{10} {4} > {5} >"},
    {"type":"custom", "format":"/~~~~~~~~~~\\\\______________________________________________________/", "outputColor":"separator"},
    "break",
    {"type":"colors", "paddingLeft":8}
  ]
}
EOF
            ;;
        *)
            [[ -z ${fastfetch_logo} ]] && fastfetch_logo='arch3'
            [[ -z ${fastfetch_separator} ]] && fastfetch_separator=' | '
            [[ -z ${fastfetch_separator_color} ]] && fastfetch_separator_color='yellow'
            [[ -z ${fastfetch_system_name_color} ]] && fastfetch_system_name_color='blue'
            [[ -z ${fastfetch_system_info_color} ]] && fastfetch_system_info_color='cyan'
            [[ -z ${fastfetch_software_info_color} ]] && fastfetch_software_info_color='green'
            [[ -z ${fastfetch_hardware_info_color} ]] && fastfetch_hardware_info_color='magenta'
            command cat << EOF > "/home/${user_name}/.config/fastfetch/config.jsonc"
{
  "logo":{"source":"${fastfetch_logo}"},
  "display":{
    "color":{"separator":"${fastfetch_separator_color}", "output":"${fastfetch_system_info_color}"},
    "separator":"${fastfetch_separator}"
  },
  "modules":[ 
    {"type":"kernel", "key":" /\\\\rch Linux", "keyColor":"${fastfetch_system_name_color}"},
    {"type":"custom", "format":">-----------<+>----------------------------------<", "outputColor":"separator"},
    {"type":"uptime", "key":"   Uptime   ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"shell", "key":"   Shell    ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"terminal", "key":"   Terminal ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"terminalfont", "key":"   Font     ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"packages", "key":"   Packages ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"localip", "key":"   Local IP ", "keyColor":"${fastfetch_software_info_color}"},
    {"type":"custom", "format":">-----------<+>----------------------------------<", "outputColor":"separator"},
    {"type":"display", "key":"   Display  ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{7} {1}x{2} ({13} ppi) {3}Hz"},
    {"type":"cpu", "key":"   CPU      ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{1} ({3}C{4}T) {6} ~ {7}"},
    {"type":"gpu", "key":"   GPU      ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{6} {2}"},
    {"type":"memory", "key":"   RAM      ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{4} {3} > {1} / {2} >"},
    {"type":"swap", "key":"   SWAP     ", "keyColor":"${fastfetch_hardware_info_color}", "format":"{4} {3} > {1} / {2} >"},
    {"type":"disk", "key":"   Disk     ", "keyColor":"${fastfetch_hardware_info_color}", "format": "{13} {3} > {1} / {2} > {9} >"},
    {"type":"battery", "key":"   Battery  ", "keyColor":"${fastfetch_hardware_info_color}", "format": "{10} {4} > {5} >"},
    {"type":"custom", "format":">-----------<+>----------------------------------<", "outputColor":"separator"},
    "break",
    {"type":"colors", "symbole":"block", "paddingLeft":9}
  ]
}
EOF
            ;;
    esac
    command chown "${user_name}":"${user_name}" /home/"${user_name}"/.config/fastfetch/config.jsonc
    command cat -n /home/"${user_name}"/.config/fastfetch/logo | command grep --color=always '[0-9]\|'
    command ls --color=always -l /home/"${user_name}"/.config/fastfetch/config.jsonc
fi
if [[ -z ${tmux} ]]; then
    command pacman -Runs --color=always --noconfirm tmux; [[ -e /etc/tmux.conf ]] && command rm -f /etc/tmux.conf
elif [[ ${customize_tmux} == on ]]; then
    command cat << 'EOF' > /etc/tmux.conf
set -g pane-border-status bottom
set -g pane-border-style fg=white
set -g pane-active-border-style fg=brightcyan
set -g pane-border-format ""
set -g status-style bg=black
set -g status-justify centre
set -g status-right "#[fg=brightblue]%I:%M %p "
set -g status-left " #[fg=brightblue]TMUX-#S"
set -g window-status-current-format "#[fg=brightmagenta]#{?window_zoomed_flag,( #I ),(#I)}"
set -g window-status-format "#[fg=magenta] #I "
set -g message-style bg=black,fg=white
set -g clock-mode-colour magenta
EOF
    command ls --color=always -l /etc/tmux.conf
    command tmux source-file /etc/tmux.conf
fi
if [[ -z ${mpv} ]];then
    command pacman -Runs --color=always --noconfirm mpv
    command rm -vfr /home/"${user_name}"/.config/mpv
else
    command su -c "mkdir /home/\"${user_name}\"/.config/mpv" "${user_name}"
fi
[[ -z ${youtube_dl} ]] && command pacman -Runs --color=always --noconfirm youtube-dl-git
[[ -z ${ytfzf} ]] && command pacman -Runs --color=always --noconfirm ytfzf
if [[ -z ${cmus} ]]; then
    command pacman -Runs --color=always --noconfirm cmus
    [[ -e /home/"${user_name}"/.config/cmus ]] && command rm -vfr /home/"${user_name}"/.config/cmus
fi
[[ -z ${cava} ]] && command pacman -Runs --color=always --noconfirm cava
[[ -z ${cmatrix} ]] && command pacman -Runs --color=always --noconfirm cmatrix
if [[ -z ${calcurse} ]]; then
    cal_alias='off'
    command pacman -Runs --color=always --noconfirm calcurse
    command rm -vfr /home/"${user_name}"/.config/calcurse
fi
if [[ ${cal_colors} == on ]]; then
    command mkdir /etc/terminal-colors.d
    command cat << 'EOF' > /etc/terminal-colors.d/cal.scheme
header 1;33;40
today 0;30;42
workday 1;37;40
weekend 0;31;40
EOF
fi
if [[ ${customize_top} == on ]]; then
    command su -c "mkdir /home/\"${user_name}\"/.config/procps" "${user_name}"
    command cat << EOF > "/home/${user_name}/.config/procps/toprc"
top's Config File (Linux processes with windows)
Id:k, Mode_altscr=0, Mode_irixps=1, Delay_time=1.0, Curwin=0
Def	fieldscur=  75   81  103  105  119  123  129  137  111  117  115  139   76   78   82   84   86   88   90   92 
		    94   96   98  100  106  108  112  120  124  126  130  132  134  140  142  144  146  148  150  152 
		   154  156  158  160  162  164  166  168  170  172  174  176  178  180  182  184  186  188  190  192 
		   194  196  198  200  202  204  206  208  210  212  214  216  218  220  222  224  226  228  230  232 
		   234  236  238  240  242  244  246  248  250  252  254  256  258  260  262  264  266  268  270  272 
	winflags=195382, sortindx=21, maxtasks=0, graph_cpus=2, graph_mems=1, double_up=0, combine_cpus=0, core_types=0
	summclr=1, msgsclr=3, headclr=1, taskclr=3
Job	fieldscur=  75   77  115  111  117   80  103  105  137  119  123  128  120   79  139   82   84   86   88   90 
		    92   94   96   98  100  106  108  112  124  126  130  132  134  140  142  144  146  148  150  152 
		   154  156  158  160  162  164  166  168  170  172  174  176  178  180  182  184  186  188  190  192 
		   194  196  198  200  202  204  206  208  210  212  214  216  218  220  222  224  226  228  230  232 
		   234  236  238  240  242  244  246  248  250  252  254  256  258  260  262  264  266  268  270  272 
	winflags=195892, sortindx=0, maxtasks=0, graph_cpus=0, graph_mems=0, double_up=0, combine_cpus=0, core_types=0
	summclr=6, msgsclr=6, headclr=7, taskclr=6
Mem	fieldscur=  75  117  119  120  123  125  127  129  131  154  132  156  135  136  102  104  111  139   76   78 
		    80   82   84   86   88   90   92   94   96   98  100  106  108  112  114  140  142  144  146  148 
		   150  152  158  160  162  164  166  168  170  172  174  176  178  180  182  184  186  188  190  192 
		   194  196  198  200  202  204  206  208  210  212  214  216  218  220  222  224  226  228  230  232 
		   234  236  238  240  242  244  246  248  250  252  254  256  258  260  262  264  266  268  270  272 
	winflags=195892, sortindx=21, maxtasks=0, graph_cpus=0, graph_mems=0, double_up=0, combine_cpus=0, core_types=0
	summclr=5, msgsclr=5, headclr=4, taskclr=5
Usr	fieldscur=  75   77   79   81   85   97  115  111  117  137  139   82   86   88   90   92   94   98  100  102 
		   104  106  108  112  118  120  122  124  126  128  130  132  134  140  142  144  146  148  150  152 
		   154  156  158  160  162  164  166  168  170  172  174  176  178  180  182  184  186  188  190  192 
		   194  196  198  200  202  204  206  208  210  212  214  216  218  220  222  224  226  228  230  232 
		   234  236  238  240  242  244  246  248  250  252  254  256  258  260  262  264  266  268  270  272 
	winflags=195892, sortindx=3, maxtasks=0, graph_cpus=0, graph_mems=0, double_up=0, combine_cpus=0, core_types=0
	summclr=3, msgsclr=3, headclr=2, taskclr=3
Fixed_widest=0, Summ_mscale=1, Task_mscale=0, Zero_suppress=0, Tics_scaled=0
EOF
    command chown "${user_name}":"${user_name}" /home/"${user_name}"/.config/procps/toprc
    command ls --color=always -l /home/"${user_name}"/.config/procps/toprc
    else [[ -e "/home/${user_name}"/.config/procps ]] && command rm -vfr /home/"${user_name}"/.config/procps
fi

command echo -e '\e[1;36;40m ***\e[1;34;40m toggling Services\e[1;36;40m ***\e[m'
[[ ${mouse} == on ]] && command systemctl start gpm
if [[ ${reflector_autostart} == on ]]; then reflector_autostart=' reflector reflector.timer'; else reflector_autostart=''; fi
if [[ ${hblock_auto_update} == on ]]; then hblock_auto_update=' hblock.timer'; else hblock_auto_update=''; fi
command systemctl enable NetworkManager systemd-boot-update fstrim.timer gpm${irq_balance}${reflector_autostart}${ananicy_cpp}${preload}${hblock_auto_update}
if [[ ${network_manager_auto_start} != on ]]; then network_manager_auto_start=' NetworkManager'; else network_manager_auto_start=''; fi
if [[ ${bootloader_auto_update} != on ]]; then bootloader_auto_update=' systemd-boot-update'; else bootloader_auto_update=''; fi
if [[ ${ssd_trim} != on ]]; then ssd_trim=' fstrim.timer'; else ssd_trim=''; fi
if [[ ${mouse} != on ]]; then mouse=' gpm'; else mouse=''; fi 
service_list="${network_manager_auto_start}${bootloader_auto_update}${ssd_trim}${mouse}"
[[ -n ${service_list} ]] && command systemctl disable${service_list}

command echo -e '\e[1;36;40m ***\e[1;34;40m configuring Run-Time-Kernel-Parameters\e[1;36;40m ***\e[m'
[[ -e /etc/sysctl.d/99-sysctl.conf ]] && command rm -f /etc/sysctl.d/99-sysctl.conf
[[ ${abandon_core_dump_file} == on ]] && command echo 'kernel.core_pattern=/dev/null' > /etc/sysctl.d/99-sysctl.conf
[[ ${virtual_memory_optimization} == on ]] && command cat << 'EOF' >> /etc/sysctl.d/99-sysctl.conf
vm.dirty_background_ratio=16
vm.dirty_ratio=32
vm.vfs_cache_pressure=32
EOF
[[ ${network_optimization} == on ]] && command cat << 'EOF' >> /etc/sysctl.d/99-sysctl.conf
net.core.netdev_max_backlog=16384
net.core.somaxconn=8192
net.core.default_qdisc=cake
net.core.rmem_default=16777216
net.core.rmem_max=33554432
net.core.wmem_default=16777216
net.core.wmem_max=33554432
net.core.optmem_max=65536
net.ipv4.ip_local_port_range=30000 65535
net.ipv4.udp_rmem_min=8192
net.ipv4.udp_wmem_min=8192
net.ipv4.tcp_rmem=8192 262144 536870912
net.ipv4.tcp_wmem=8192 262144 536870912
net.ipv4.tcp_fastopen=3
net.ipv4.tcp_max_syn_backlog=8192
net.ipv4.tcp_max_tw_buckets=2000000
net.ipv4.tcp_tw_reuse=1
net.ipv4.tcp_fin_timeout=10
net.ipv4.tcp_slow_start_after_idle=0
net.ipv4.tcp_keepalive_time=60
net.ipv4.tcp_keepalive_intvl=10
net.ipv4.tcp_keepalive_probes=6
net.ipv4.tcp_mtu_probing=1
net.ipv4.tcp_sack=1
net.ipv4.tcp_congestion_control=bbr
net.ipv4.tcp_syncookies=1
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.all.send_redirects=0
net.ipv4.conf.default.accept_redirects=0
net.ipv4.conf.default.send_redirects=0
net.ipv4.conf.all.secure_redirects=0
net.ipv4.conf.default.secure_redirects=0
net.ipv4.icmp_echo_ignore_all=1
EOF
command sysctl -p /etc/sysctl.d/99-sysctl.conf

command echo -e '\e[1;36;40m ***\e[1;34;40m configuring [ O < ] systemd-boot\e[1;36;40m ***\e[m'
command echo -e 'default arch.conf\neditor no' > /boot/loader/loader.conf
command cat /boot/loader/loader.conf
if [[ ${silent_boot} != on ]]; then silent_boot=''; else silent_boot=' quiet loglevel=0'; fi
if [[ ${swap_memory_compression} != on ]]; then swap_memory_compression=''; else swap_memory_compression=' zswap.enabled=1'; fi
if [[ ${side_channel_attack_mitigation} == off ]]; then side_channel_attack_mitigation=' mitigations=off'; else side_channel_attack_mitigation=''; fi
command echo "linux ${kernel}" > /boot/loader/entries/arch.conf
[[ -n ${microcode} ]] && command echo "initrd ${microcode}" >> /boot/loader/entries/arch.conf
command cat << EOF >> /boot/loader/entries/arch.conf
initrd ${ram_file_system}
options root=UUID=$(command findmnt -o UUID -n /) rw${silent_boot}${swap_memory_compression}${side_channel_attack_mitigation}
EOF
command cat /boot/loader/entries/arch.conf

command echo -e '\e[1;36;40m ***\e[1;34;40m set system Language and Keyboard\e[1;36;40m ***\e[m'
set_locale() {
    command echo "LANG=$1" > /etc/locale.conf
}
if [[ -n ${language} ]]; then
    command echo "${language}" > /etc/locale.gen
    command locale-gen
    set_locale ${language}
else
    command echo 'C.UTF-8 UTF-8' > /etc/locale.gen
    command locale-gen
    command echo 'LANG=C.UTF-8' > /etc/locale.conf
fi
unset -f set_locale
command echo '' > /etc/vconsole.conf
[[ -n ${keyboard} ]] && command echo "KEYMAP=${keyboard}" >> /etc/vconsole.conf
[[ -n ${font} ]] && command echo "FONT=${font}" >> /etc/vconsole.conf
[[ -e /etc/localtime ]] && command rm -f /etc/localtime
[[ -n ${timezone} ]] && command ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime

command echo -e '\e[1;36;40m ***\e[1;34;40m configuring Terminal and Environment\e[1;36;40m ***\e[m'
command echo '\e[0;0H\e[0;30;45m <\l> [\e[1;36;45m/\\ \e[1;37;45march\e[1;36;45mlinux\e[0;36;45m \r\e[0;30;45m]\e[K\e[m' > /etc/issue
[[ ${login_shell_top_bar} != on ]] && echo '' > /etc/issue
if [[ ${login_shell_text_graph} == on ]]; then
command cat << 'EOF' >> /etc/issue
\e[1;36m                                  __,.-------..._
\e[0;36m                            ,.-+'"" _,..+++++++._`" +._
\e[0;32m                          ,/" ,.-+'"            '""+-._`'+.
\e[1;32m                        ./" ,/        __,.--+""+--..__ `+. `'+
\e[1;33m                      ,/' ,/      _,-_;:--+''""''+-.._`-. `+. `'
\e[0;33m                     ,/ ,/      /',+'                 '+.`.  `+.`'
\e[0;31m                    ,/ ,/     /'./     ,_.-.++'""'++._   `.`+. `+.`'
\e[1;31m                  ,/' ,/.    /'.'   ./' _,.-++""+--.._`+.  `. +  `.`'
\e[1;35m             ___,/',----.`. /./    /','"     _....._  `+.`.  `.`. `.`'+
\e[0;35m          ,/'"___ /      `.' |.   /,/      ,'       `'.  +.`. `.`   `.`'
\e[0;34m        ,|' ./,__`__ ,_ __ l. ^--' _`.____/.           `.___`. `.`.  `.`+
\e[1;34m       ./  ,l | ,', || v / / ,-.  (_)  _-_   _-_  ,-.  ,---. `. `;`.  `.`+  @
\e[1;36m       '|  'l |_"_"_/^7 / /' | |  | | (_ _) (_ _) | |  ( ^__; `.__;`_   _ `+---.
\e[0;36m        `+. `.       (Y/ /'  |__) |_|  |__)  |__) |__) `.__,' ,-==-. "+"  ,-==-."+.
\e[0;32m           `> `+.     ` /',-+^^^^+-.      ,-====-.     ,-=-.  `.   `. '   /    |;`|;
\e[1;32m      _,.-+"_,--_ `+. ,/''          `.   /       `.   /     |. `.   `.   /    /' /'
\e[1;33m   ,;' ,.-'"     `.  '  /      .     '.  |         ;  |     |;  `.   `. /    /' /'
\e[0;33m  / ,/'            `.  .     .' `.    '; |      .   ; |     |;   `.    v    /' /'
\e[0;31m,',/.'      _._     `..|    /  .  ;    ;.|      |`.  '|     |;    `.   '   /' /'
\e[1;31m| |.      /'   `.    `.|    '--^--     |,|      |;`.  '     |;     `.     /' /'
\e[1;35m`.`.     |'  .   |    ||              /, |      |; `.       |;      )    /' /'
\e[0;35m `.`.    `.__^__/'   /, `.____.-.___,/,  |      |;  `.      |;     /    /' /'
\e[0;34m  `.`.             _/,   ,.-+- .  '      |      |;   `.     |;    /    /' /'
\e[1;34m   `.`.      _,.-'"    ,/        `+.     |      |;    `.___,'    /    /' /'
\e[1;36m    `.`.     `.      ,/             `.   `.____,'       """   ,.'    /' /'
\e[0;36m     `.`.     `.    ,|        ,,==._   "+-......__       _,.-"     ," /"
\e[0;32m      `.`.     `.   |        //    `."+__        '""""""'      _,+' ,"
\e[1;32m       `.`.    /',  '|       K       |.  '''--+...__   _,.=--'"  ,/'       _,.-=+"""""++-..
\e[1;33m        `.`.__/',^.  `.      "       |'            '""''      ,+'       ,+'         ,-.    `+.
\e[0;33m         `._'','   +. `.      `._,   /' .__    _.      _     <       ,+'   ,+-.     `. |     '`+.
\e[0;31m           ``'      `. `.          /',  `. """" |     (_)  ___`+._.+'      | /' ___  | |     _  '`+.
\e[1;31m                     `.   +-___-+"' ,^.  | c===-'_  _ ,-. / _ `+,-._    __ | |/'   `.| |__  (_)___.`'.
\e[1;35m                       `+.__  _...+'   | | ,--.|| |' )| || (_) || ,.`.,/  `| |(  C==<| '  `.,-.|  `+. +.
\e[0;35m                           '''       ,'  | |    | ./" | || ._,-;| || ||  ()  |>==u  )| ,^. || || D  ). `.
\e[0;34m                                   ,/   /__|.  ,|_|.  |_| `.__/,|_||_| `._/|_|.`._./'|_| |_||_|| ._/+   '.
\e[1;34m                                 ,'          +  _  ,-.   ,-.  ,--.   ,++-.-+. _                | |'     '.
\e[1;36m                                .|           I [_' | `+ / , ||_--.`.(  ()  ./(_) .---.         | |      /.
\e[0;36m                                +.           I ._] | . ` /| | ,--' | +___; | ,-./'   `+       ,|_|.    ,+
\e[0;32m                                `+                 | |`./ | ||  () |. __,+ | | ||  C==<               ,+
\e[1;32m                                 `|.              ,|_|.  ,|_|`.__/|_||___,/' |_|`+.__./             ,+
\e[1;33m                                    +.........._________________________________________________,.+'\e[m
EOF
else command echo -e '\n\n\n\n\n\n' >> /etc/issue; fi
command ls --color=always /etc/issue
command cat << 'EOF' > /etc/profile
export PATH='/usr/local/sbin:/usr/local/bin:/usr/bin'
append_path () {
  case ":$PATH:" in
    *:"$1":*) ;;
    *)        PATH="${PATH:+$PATH:}$1"
  esac
}
[[ -d /etc/profile.d/ ]] && for profile in /etc/profile.d/*.sh
do
  [[ -r $profile ]] && . "$profile"
done
unset profile
unset -f append_path
unset TERMCAP
unset MANPATH
[[ $- == *i* ]] && [[ -z $POSIXLY_CORRECT ]] && [[ ${0#-} != sh ]] && [[ -r /etc/bash.bashrc ]] && . /etc/bash.bashrc
EOF
command ls --color=always -l /etc/profile
command echo '' > /etc/bash.bash_logout
command ls --color=always -l /etc/bash.bash_logout
command cat << 'EOF' > /etc/inputrc
set meta-flag on
set input-meta on
set convert-meta off
set output-meta on
EOF
[[ ${enhance_tab_completion} == on ]] && command cat << 'EOF' >> /etc/inputrc
set show-all-if-unmodified on
set show-all-if-ambiguous on
set colored-stats on
set visible-stats on
set mark-symlinked-directories on
set colored-completion-prefix on
set menu-complete-display-prefix on
EOF
command ls --color=always -l /etc/inputrc
command echo '' > /etc/bash.bashrc
user_id='$EUID'
tmux_id='$TMUX'
[[ ${user_command_prompt_color} != *\e[*m* ]] && user_command_prompt_color='\e[1;35;44m'
[[ ${user_command_prompt_arrow_color} != *\e[*m* ]] && user_command_prompt_arrow_color='\e[0;36;40m'
[[ ${user_command_prompt_line_color} != *\e[*m* ]] && user_command_prompt_line_color='\e[1;36;40m'
[[ ${root_command_prompt_color} != *\e[*m* ]] && root_command_prompt_color='\e[0;31;43m'
[[ ${root_command_prompt_arrow_color} != *\e[*m* ]] && root_command_prompt_arrow_color='\e[0;31;40m'
[[ ${root_command_prompt_line_color} != *\e[*m* ]] && root_command_prompt_line_color='\e[1;33;40m'
[[ -n ${tmux} ]] && [[ ${interactive_shell_fastfetch} == on ]] && command cat << EOF > /etc/bash.bashrc
PS1='\[\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[${user_command_prompt_line_color}\]'
PS0='\e[12C\e[1;32m|\\/|\n\e[12C\e[1;36m|  |\e[1;32;44m \h \e[1;34;40m\n\e[13C\\/\n\e[1;37m'
if [[ ${user_id} == 0 ]]
then
  PS1='\[\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[${root_command_prompt_line_color}\]'
  PS0='\e[12C\e[1;33m|\\/|\n\e[12C\e[1;31m|  |\e[1;32;43m \h \e[0;31;40m\n\e[13C\\/\n\e[1;37m'
elif [[ -z ${tmux_id} ]]
then
  command clear; command tput cup 4 0; command fastfetch
fi
if [[ -n ${tmux_id} ]]
then
  PROMPT_COMMAND=''
  PS1='\[\e[2B\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m\e[K <\l> [\w]\e[u${user_command_prompt_line_color}\]'
  [[ ${user_id} == 0 ]] && PS1='\[\e[2B\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m\e[K <\l> [\w]\e[u${root_command_prompt_line_color}\]'
fi
EOF
[[ -z ${tmux} ]] && [[ ${interactive_shell_fastfetch} == on ]] && command cat << EOF > /etc/bash.bashrc
PS1='\[\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[${user_command_prompt_line_color}\]'
PS0='\e[12C\e[1;32m|\\/|\n\e[12C\e[1;36m|  |\e[1;32;44m \h \e[1;34;40m\n\e[13C\\/\n\e[1;37m'
if [[ ${user_id} == 0 ]]
then
  PS1='\[\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[${root_command_prompt_line_color}\]'
  PS0='\e[12C\e[1;33m|\\/|\n\e[12C\e[1;31m|  |\e[1;32;43m \h \e[0;31;40m\n\13C\\/\n\e[1;37m'
else
  command clear; command tput cup 4 0; command fastfetch
fi
EOF
[[ -n ${tmux} ]] && [[ ${interactive_shell_fastfetch} != on ]] && command cat << EOF > /etc/bash.bashrc
PS1='\[\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[${user_command_prompt_line_color}\]'
PS0='\e[12C\e[1;32m|\\/|\n\e[12C\e[1;36m|  |\e[1;32;44m \h \e[1;34;40m\n\e[13C\\/\n\e[1;37m'
if [[ ${user_id} == 0 ]]
then
  PS1='\[\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[${root_command_prompt_line_color}\]'
  PS0='\e[12C\e[1;33m|\\/|\n\e[12C\e[1;31m|  |\e[1;32;43m \h \e[0;31;40m\n\e[13C\\/\n\e[1;37m'
else
  [[ -z ${tmux_id} ]] && command clear
fi
if [[ -n ${tmux_id} ]]
then
  PROMPT_COMMAND=''
  PS1='\[\e[2B\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m\e[K <\l> [\w]\e[u${user_command_prompt_line_color}\]'
  [[ ${user_id} == 0 ]] && PS1='\[\e[2B\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m\e[K <\l> [\w]\e[u${root_command_prompt_line_color}\]'
fi
EOF
[[ -z ${tmux} ]] && [[ ${interactive_shell_fastfetch} != on ]] && command cat << EOF > /etc/bash.bashrc
PS1='\[\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[${user_command_prompt_line_color}\]'
PS0='\e[12C\e[1;32m|\\/|\n\e[12C\e[1;36m|  |\e[1;32;44m \h \e[1;34;40m\n\e[13C\\/\n\e[1;37m'
if [[ ${user_id} == 0 ]]
then
  PS1='\[\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[${root_command_prompt_line_color}\]'
  PS0='\e[12C\e[1;33m|\\/|\n\e[12C\e[1;31m|  |\e[1;32;43m \h \e[0;31;40m\n\e[13C\\/\n\e[1;37m'
else
  command clear
fi
EOF
[[ ${interactive_shell_top_bar} == on ]] && command cat << 'EOF' >> /etc/bash.bashrc
tbar() {
  local tbar_mid=$((($COLUMNS - 6 >> 1)))
  local tbar_right=$((($COLUMNS - 9)))
  local tty_name=$(command tty | command sed 's#/dev/##')
  local bat_percent=$(command cat /sys/class/power_supply/BAT0/capacity)
  local bat_format='\e[0;34;47m100% [II}'
  ((bat_percent < 100)) && bat_format=" \e[0;34;47m$bat_percent% [II\e[0;30;47m}"
  ((bat_percent < 64)) && bat_format=" \e[0;33;47m$bat_percent% [I\e[0;30;47mI}"
  ((bat_percent < 32)) && bat_format=" \e[0;31;47m$bat_percent% [\e[0;30;47mII}"
  command echo -e "\n\e[1B\e[2A\e[s\e[0;0H\e[0;34;47m\e[K <$tty_name> [$(command pwd -LP)]\e[0;${tbar_mid}H$(command date +'%I:%M %p')\e[0;${tbar_right}H$bat_format\e[u"
}
PROMPT_COMMAND=tbar
EOF
if [[ ${fastfetch_clear_alias} == on ]]; then
    command cat << EOF > "/home/${user_name}/.config/fastfetch/config_small.jsonc"
{
  "logo":{"source":"arch_small"},
  "display":{
    "color":{"output":"cyan"},
    "separator":""
  },
  "modules":[
    {"type":"kernel", "key":"[_/\\\\arch___> ", "keyColor":"blue"},
    {"type":"packages", "key":"[_Packages_> ", "keyColor":"green", "outputColor":"white"},
    {"type":"localip", "key":"[_Local_IP_> ", "keyColor":"green", "outputColor":"white"},
    {"type":"memory", "key":"[_RAM______> ", "keyColor":"magenta", "format":"[{3}] {1} / {2}"},
    {"type":"swap", "key":"[_SWAP_____> ", "keyColor":"magenta", "format":"[{3}] {1} / {2}"},
    {"type":"disk", "key":"[_Disk_____> ", "keyColor":"magenta", "format":"[{3}] {1} / {2} {9}"},
    {"type":"battery", "key":"[_Battery__> ", "keyColor":"magenta", "format":"[{4}] {5}"},
    "break",
    {"type":"colors", "paddingLeft":9, "symbol":"circle"}
  ]
}
EOF
    command chown "${user_name}":"${user_name}" /home/"${user_name}"/.config/fastfetch/config_small.jsonc
    command ls --color=always -l /home/"${user_name}"/.config/fastfetch/config_small.jsonc
    command cat << 'EOF' >> /etc/bash.bashrc
alias fastfetch='ffsc="--config $HOME/.config/fastfetch/config_small.jsonc"; (( $COLUMNS > 128 )) && ffsc=""; fastfetch $ffsc'
alias clear='clear; command tput cup 4 0; fastfetch'
EOF
fi
[[ ${wget_alias} == on ]] && command echo "alias wget='wget -c'" >> /etc/bash.bashrc
[[ ${less_alias} == on ]] && command echo -e "alias less='less -r'\nalias more='less -r'" >> /etc/bash.bashrc
[[ ${general_alias} == on ]] && command cat << 'EOF' >> /etc/bash.bashrc
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias pwd="pwd -LP | command grep --color=auto '/\|'"
alias mount='mount -v'
alias umount='umount -v'
alias mkdir='mkdir -v'
alias mv='mv -v'
alias cp='cp -v'
alias rm='rm -vf'
alias dd='dd status=progress'
alias ps='ps --sort size -uf'
alias I='su -c'
ls() {
  command ls --color=always -FAXlh "$@" |\
  command grep --color=always '^b\|:\|\.\|root\|' | GREP_COLORS='ms=01;34'\
  command grep --color=always '^d\|/\|_\|' | GREP_COLORS='ms=01;32'\
  command grep --color=always '^total\|-\|>\|' | GREP_COLORS='ms=01;36'\
  command grep --color=always '^l\|' | GREP_COLORS='ms=01;33'\
  command grep --color=always '^c\|*\|'
}
cd() {
  command cd "$@" && ls
}
lsblk() {
  command lsblk "$@" |\
  command grep --color=always ']\|\[\|RM\|RO\|FS\|disk\|%\|\.\|:\|-\|' | GREP_COLORS='ms=01;34'\
  command grep --color=always '^NAME\|SIZE\|TYPE\|SWAP\|VER\|AVAIL\|UUID\|USE\|/\|└\|├\|─\|'
}
lspci() {
  command lspci -tvvv "$@" |\
  command grep --color=always ']\|\[\|+\|-\||\|\\\|/\|' | GREP_COLORS='ms=01;34'\
  command grep --color=always '\.\|:\|,\|' | GREP_COLORS='ms=01;35'\
  command grep --color=always 'Audio\|' | GREP_COLORS='ms=01;36'\
  command grep --color=always 'USB\|'
}
cat() {
  case $@ in
    *-c*|*--color*) 
      command cat -n $(command echo $@ | command sed 's#--color##g' | command sed 's#-c##g') |\
      command grep --color=always '\.\|,\|;\|:\|_\|}\|{\|)\|(\|]\|\[\|\\\|\$\|#\|?\|!\|@\|`\|"\|' |\
      command grep --color=always "'\|" | GREP_COLORS='ms=01;34'\
      command grep --color=always '+\|-\|*\|/\|%\|=\|>\|<\|&\||\|\^\|~\|' ;;
    *)command cat "$@" ;;
  esac
}
sha256sum() {
  command sha256sum "$@"
  command echo -e '\e[1;32;40m----------------------------------------------------------------\e[m\n'
}
file() {
  command file "$@" |\
  command grep --color=always 'block\|/\|-\|+\|' | GREP_COLORS='ms=01;34'\
  command grep --color=always 'directory\|:\|\.\|,\|#\|)\|(\|_\|' | GREP_COLORS='ms=01;36'\
  command grep --color=always 'link\|' | GREP_COLORS='ms=01;33'\
  command grep --color=always 'character\|'
}
findmnt() {
  command findmnt "$@" |\
  command grep --color=always 'TARGET\|SOURCE\|FSTYPE\|OPTIONS\|' | GREP_COLORS='ms=01;36'\
  command grep --color=always '│\|└\|├\|─\|,\|=\|' | GREP_COLORS='ms=01;32'\
  command grep --color=always '/\|'
}
find() {
  local line=$(command printf '%*s' $((($COLUMNS - 8))) | command tr ' ' _)
  local files=$(command find "$@" 2> /dev/null | command grep --color=always '\.\|' | GREP_COLORS='ms=01;34' command grep --color=always '/\|' |\
    command fzf -m --ansi -e --cycle --color=16 --layout=reverse-list --header=$line --border --border-label=$line\
    --preview="printf '\e[1;35;40m'; file {}; echo -e '\e[0;36;40m'$line; printf '\e[0;31;40m'
      [[ -f {} ]] && cat -n {} | GREP_COLORS='ms=01;32' grep --color=always '[0-9]\|' | grep --color=always '+\|-\|*\|/\|%\|=\|>\|<\|&\||\|\^\|~\|'"\
    --preview-window=up,50% --preview-label=$line --preview-label-pos=bottom)
  if [[ -n $files ]]; then command vim $files; else command echo "$files"; fi
}
history() {
  case $1 in
  '')local hcmd=$(\
    command history | command grep --color=always '[0-9]\|' | command fzf --ansi --color=16 -e --layout=reverse-list --cycle --border\
      --header=$(command printf '%*s' $((($COLUMNS - 8))) | command tr ' ' -) | command awk '{$1=""}1')
    command printf '\n'; eval $hcmd ;;
  -h|help|--help)
    command history --help | command grep --color=always '\[\|\]\|\-\|' ;;
  *)command history $@ ;;
  esac
}
kill() {
  case $1 in
  -l|-L) shift 1; command kill -l $@ | command grep --color=always '[0-9]\|' ;;
  -h|help|--help) command kill --help | command grep --color=always '\-\|\[\|\]\||\|' ;;
  *) if [[ -n $2 ]]; then command kill $@
    else local pid=$(\
      command ps -aux |\
      command fzf -m -e --color=16 --cycle --layout=reverse-list --border --header=$(command printf '%*s' $((($COLUMNS - 8))) | command tr ' ' -) |\
      command awk '{print $2}'); [[ -n $pid ]] && command kill $1 $pid
    fi ;;
  esac
}
EOF
[[ ${fzf_alias} == on ]] && command cat << 'EOF' >> /etc/bash.bashrc
fzf() {
  case $@ in
  -h|*help*|*--help*) command fzf -h | command grep --color=always '\-\|\[\|\]\|' ;;
  *--no-logo*) command fzf -m --ansi --cycle --color=16 --layout=reverse-list --border --header=$(command printf '%*s' $((($COLUMNS - 8))) | command tr ' ' '=') $(command echo "$@" | command sed 's#--no-logo##g') ;;
  *) command fzf -m --ansi --cycle --color=16 --layout=reverse-list --border --header=$(command printf '%*s' $((($COLUMNS - 8))) | command tr ' ' '=') --preview="echo -e \"\
  \e[1;32;40m          _._     \e[1;37;40m  _._
  \e[1;32;40m         j7~*^    \e[1;37;40m j7~*^
  \e[1;31;40m zx   \e[1;32;40m  a0bo aod/ \e[1;37;40ma0bo
  \e[1;31;40m \\\`*b.\e[1;32;40m    M\\\"  \\\`Z7\e[1;37;40m   M\\\"
  \e[1;31;40m j7/  \e[1;32;40m  ,N'  /7   \e[1;37;40m,N'
  \e[1;31;40m \\\`'  \e[1;32;40m   ;U  /Ebad\e[1;37;40m ;U
\e[0;30;47m command-line FuZzy Finder \e[m\"" --preview-window=up,7 $@ ;;
  esac
}
EOF
[[ ${cal_alias} == on ]] && command cat << 'EOF' >> /etc/bash.bashrc
cal() {
  case $1 in
    -1|month|--month|single|--single|one|--one)
      command echo -e '\e[m-C-C-C-C-C-C-C-C-C-C-.\n---------------------|'
      command cal --color=always -1
      command echo -e '\e[m_____________________|' ;;
    -3|three|--three|triple|--triple)
      command echo -e '\e[m-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-.\n-----------------------------------------------------------------|'
      command cal --color=always -3
      command echo -e '\e[m_________________________________________________________________|' ;;
    -y|-12|year|--year)
      command echo -e '\e[m-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-C-.\n-------------------------------------------------------------------|\e[1;31;40m'
      command cal --color=always -y
      command echo -e '\e[m___________________________________________________________________|' ;;
    help|--help|-h)
      command echo -e 'Options:\e[1;35;40m- - - - - - - - - - - - - - - - - - - - - - + - - - - - - - - - - - - - - - - -\e[1;37;40m
  -1, month, single, one, --month, --single, --one  \e[1;35;40m| \e[1;37;40mshow single month calendar
  -3, three, --three                                \e[1;35;40m| \e[1;37;40mshow triple month calendar
  -y, -12, year, --year                             \e[1;35;40m| \e[1;37;40mshow twelve month calendar
\e[1;35;40m- - - - - - - - - - - - - - - - - - - - - - - - - - + - - - - - - - - - - - - - - - - -\e[m'
      command calcurse -h | command sed 's#calcurse#cal#g' | command grep --color=always '\-\|' ;;
    *)command calcurse "$@" ;;
  esac
}
EOF
[[ ${pacman_alias} == on ]] && command cat << 'EOF' >> /etc/bash.bashrc
pacman() {
  command echo -e "\e[0;34;40m -===================================================================-
  \e[0;31;40m ,-.\e[0;36;40m   _ __   __ _  ___ _ _ __   __ _ _ _    \e[1;33;40m,--.
  \e[0;31;40m| OO|\e[0;36;40m | '_ \\ / _\` |/ __| ' \`  \`:/ _\` | ' \`: \e[1;33;40m/ _,-\` ,-. ,-. ,-. ,''.
  \e[0;31;40m|   |\e[0;36;40m | |_) | (_| | (__| || || | (_| | || | \e[1;33;40m\\  \`-, '-' '-' '-' '..'
  \e[0;31;40m'^^^'\e[0;36;40m | .__/ \\__,_|\\___|_||_||_|\\__,_|_||_|  \e[1;33;40m\`--'
       \e[0;36;40m |_|\e[0;34;40m
 -===================================================================-\e[m"
  case $1 in
    upgrade|update)
      shift 1; command pacman --color=always -Syu $@ ;;
    install)
      shift 1
      if [[ $@ == *.pkg.tar.zst* ]]
      then command pacman --color=always -U $@
      else command pacman --color=always -S $@
      fi ;;
    remove|purge|uninstall)
      shift 1; command pacman --color=always -Runs $@ ;;
    autoremove)
      local orph="$(command pacman -Qdtq)"
      if [[ -n $2 ]] || [[ -n $orph ]]
      then shift 1; command pacman --color=always -Runs $@ $orph
      else echo ' 0 package removed'
      fi ;;
    clean)
      shift 1; command pacman --color=always -Scc $@ ;;
    search)
      case $2 in
        group|--group)
          shift 2
          if [[ -n $@ ]]
          then command pacman --color=always -Sgg $@
          else command pacman --color=always -Sgg | command awk '{print $1}' | command uniq
          fi ;;
        *)shift 1; command pacman --color=always -Ss $@ ;;
      esac ;;
    info|show)
      shift 1; command pacman --color=always -Sii $@ ;;
    list)
      case $2 in
        explicit|--explicit|user-installed|--user-installed|manual-installed|--manual-installed)
          shift 2
          if [[ -z $@ ]]
          then command pacman --color=always -Qe
          else command pacman --color=always -Qlkk $@
          fi ;;
        all|-all|installed|--installed)
          shift 2
          if [[ -z $@ ]]
          then command pacman --color=always -Qs
          else command pacman --color=always -Qlkk $@
          fi ;;
        orphan|--orphan)
          shift 2; command pacman --color=always -Qdt $@ ;;
        group|--group)
          shift 2; command pacman --color=always -Qg $@ ;;
        *)shift 1
          if [[ -z $@ ]]
          then command pacman --color=always -Qs
          else command pacman --color=always -Qlkk $@
          fi ;;
      esac ;;
    version|--version|-V)
      command pacman -V\
        | GREP_COLORS='ms=01;33' command grep --color=always "\.\|-\|/\|_\|'\|" \
        | GREP_COLORS='ms=01;33' command grep --color=always '\\\|' ;;
    help|--help|-h)
      shift 1
      [[ -z $@ ]] && command echo -e "\e[0;32;40mnew pacman alias:\e[0;34;40m_______________________|________________\e[m
    pacman upgrade [package(s)]\e[0;34;40m.........|..\e[mupgrade System and install New Package
    pacman install <package(s)>\e[0;34;40m.........|..\e[minstall New Package
    pacman remove <package(s)>\e[0;34;40m..........|..\e[mpurge Package and Dependency
    pacman autoremove [package(s)]\e[0;34;40m......|..\e[mremove Package and Orphan
    pacman clean\e[0;34;40m........................|..\e[mclean all cach
    pacman search [keyword(s)]\e[0;34;40m..........|..\e[msearch by keyword
    pacman info [package(s)]\e[0;34;40m............|..\e[mshow detail info of package
    pacman list [package(s)]\e[0;34;40m............|..\e[mlist all installed package
    pacman list explicit [package(s)]\e[0;34;40m...|..\e[mlist all explicit installed package
    pacman list orphan [package(s)]\e[0;34;40m.....|..\e[mlist orphan package
    pacman list group [group(s)]\e[0;34;40m........|..\e[mlist package group
    pacman version\e[0;34;40m......................|..\e[mshow pacman version
    pacman help [option(s)]\e[0;34;40m.............|..\e[mshow help sheat of option
\e[0;34;40m----------------------------------------|----------------\e[m"
      command pacman -h $@ | command grep --color=always '\-\|' ;;
    ''|logo|--logo) ;;
    *)command pacman --color=always $@ ;;
  esac
}
EOF
[[ ${pacman_fzf_alias} == on ]] && command cat << 'EOF' >> /etc/bash.bashrc
pacman() {
  local logo="\e[0;34;40m -===================================================================-
  \e[0;31;40m ,-.\e[0;36;40m   _ __   __ _  ___ _ _ __   __ _ _ _    \e[1;33;40m,--.
  \e[0;31;40m| OO|\e[0;36;40m | '_ \\ / _\` |/ __| ' \`  \`:/ _\` | ' \`: \e[1;33;40m/ _,-\` ,-. ,-. ,-. ,''.
  \e[0;31;40m|   |\e[0;36;40m | |_) | (_| | (__| || || | (_| | || | \e[1;33;40m\\  \`-, '-' '-' '-' '..'
  \e[0;31;40m'^^^'\e[0;36;40m | .__/ \\__,_|\\___|_||_||_|\\__,_|_||_|  \e[1;33;40m\`--'
       \e[0;36;40m |_|\e[0;34;40m
 -===================================================================-\e[m"
  local logo_fzf="
\e[0;34;40m-===================================================================-
 \e[0;31;40m ,-.\e[0;36;40m   _ __   __ _  ___ _ _ __   __ _ _ _    \e[1;33;40m,--.
 \e[0;31;40m| OO|\e[0;36;40m | '_ \\\\ / _\\\` |/ __| ' \\\`  \\\`:/ _\\\` | ' \\\`: \e[1;33;40m/ _,-\\\` ,-. ,-. ,-. ,''.
 \e[0;31;40m|   |\e[0;36;40m | |_) | (_| | (__| || || | (_| | || | \e[1;33;40m\\\\  \\\`-, '-' '-' '-' '..'
 \e[0;31;40m'^^^'\e[0;36;40m | .__/ \\\\__,_|\\\\___|_||_||_|\\\\__,_|_||_|  \e[1;33;40m\\\`--'
      \e[0;36;40m |_|\e[0;34;40m
-===================================================================-\e[m"
  local btm='  _____________________________________________________________________'
  local line="$(command printf '%*s' $((($COLUMNS / 2))) | command tr ' ' -)"
  case $1 in
  upgrade|update) shift 1; command echo -e "$logo"; command pacman --color=always -Syu $@ ;;
  install) shift 1; command echo -e "$logo"
    if [[ $@ == *.pkg.tar.zst* ]]; then command pacman --color=always -U $@
      else command pacman --color=always -S $@; fi ;;
  remove|purge|uninstall) shift 1; command echo -e "$logo"; command pacman --color=always -Runs $@ ;;
  autoremove) command echo -e "$logo"; local orph="$(command pacman -Qdtq)"
    if [[ -n $2 ]] || [[ -n $orph ]]; then shift 1; command pacman --color=always -Runs $@ $orph
      else echo ' 0 package removed'; fi ;;
  clean) shift 1; command echo -e "$logo"; command pacman --color=always -Scc $@ ;;
  info|show) shift 1; command echo -e "$logo"; command pacman --color=always -Sii $@ ;;
  search) case $2 in
    group|--group) shift 2
      if [[ -z $@ ]]
      then local gp=$(command pacman --color=always -Sgg | command awk '{print $1}' | command uniq | command fzf --ansi --color=16 --layout=reverse-list --cycle -e --border --header=$line\
        --preview="echo -e \"$logo_fzf\"; pacman --color=always -Sgg {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom)
        if [[ -n $gp ]]; then local pkg=$(command pacman -Sgg $gp | command awk '{print $2}' | command fzf --ansi --color=16 --layout=reverse-list --cycle -e --border --header=$line\
          --preview="echo -e \"$logo_fzf\"; pacman --color=always -Ss {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom); fi
      else local gp=$(command pacman --color=always -Sgg | command awk '{print $1}' | command uniq | command fzf --ansi --color=16 --layout=reverse-list --cycle -e -q "$@" --border --header=$line\
        --preview="echo -e \"$logo_fzf\"; pacman --color=always -Sgg {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom)
        if [[ -n $gp ]]; then local pkg=$(command pacman -Sgg $gp | command awk '{print $2}' | command fzf --ansi --color=16 --layout=reverse-list --cycle -e --border --header=$line\
          --preview="echo -e \"$logo_fzf\"; pacman --color=always -Ss {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom); fi
      fi; if [[ -n $pkg ]]; then command echo -e "\n$logo"; command pacman -Sii $pkg; else command printf '\n'; fi ;;
    '') shift 1; local pkg=$(command pacman --color=always -Ssq | command fzf --ansi --color=16 --layout=reverse-list --cycle -e --border --header=$line\
      --preview="echo -e \"$logo_fzf\"; pacman --color=always -Ss {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom)
      if [[ -n $pkg ]]; then command echo -e "\n$logo"; command pacman -Sii $pkg; else command printf '\n'; fi ;;
    *) shift 1; local pkg=$(command pacman --color=always -Ssq | command fzf --ansi --color=16 --layout=reverse-list --cycle -e -q "$@" --border --header=$line\
      --preview="echo -e \"$logo_fzf\"; pacman --color=always -Ss {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom)
      if [[ -n $pkg ]]; then command echo -e "\n$logo"; command pacman -Sii $pkg; else command printf '\n'; fi ;;
    esac ;;
  list) case $2 in
    explicit|--explicit|user-installed|--user-installed|manual-installed|--manual-installed) shift 2
      if [[ -n $@ ]]
      then local pkg=$(command pacman --color=always -Qeq | command fzf --ansi --color=16 --layout=reverse-list --cycle -e -q "$@" --border --header=$line\
        --preview="echo -e \"$logo_fzf\"; pactree -c {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom)
      else local pkg=$(command pacman --color=always -Qeq | command fzf --ansi --color=16 --layout=reverse-list --cycle -e --border --header=$line\
        --preview="echo -e \"$logo_fzf\"; pactree -c {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom)
      fi; if [[ -n $pkg ]]; then command echo -e "\n$logo"; command pacman --color=always -Qlkk $pkg; else command printf '\n'; fi ;;
    all|--all|installed|--installed) shift 2
      if [[ -n $@ ]]
      then local pkg=$(command pacman --color=always -Qq | command fzf --ansi --color=16 --layout=reverse-list --cycle -e -q "$@" --border --header=$line\
        --preview="echo -e \"$logo_fzf\"; pactree -c {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom)
      else local pkg=$(command pacman --color=always -Qq | command fzf --ansi --color=16 --layout=reverse-list --cycle -e --border --header=$line\
        --preview="echo -e \"$logo_fzf\"; pactree -c {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom)
      fi; if [[ -n $pkg ]]; then command echo -e "\n$logo"; command pacman --color=always -Qlkk $pkg; else command printf '\n'; fi ;;
    orphan|--orphan) command echo -e "$logo"; shift 2; command pacman --color=always -Qdt $@ ;;
    group|--group) command echo -e "$logo"; shift 2; command pacman --color=always -Qg $@ ;;
    *) shift 1
      if [[ -n $@ ]]
      then local pkg=$(command pacman --color=always -Qq | command fzf --ansi --color=16 --layout=reverse-list --cycle -e -q "$@" --border --header=$line\
        --preview="echo -e \"$logo_fzf\"; pactree -c {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom)
      else local pkg=$(command pacman --color=always -Qq | command fzf --ansi --color=16 --layout=reverse-list --cycle -e --border --header=$line\
        --preview="echo -e \"$logo_fzf\"; pactree -c {}" --preview-window=left,69 --preview-label="$btm" --preview-label-pos=1:bottom)
      fi; if [[ -n $pkg ]]; then command echo -e "\n$logo"; command pacman --color=always -Qlkk $pkg; else command printf '\n'; fi ;;
      esac ;;
  version|--version|-V) command echo -e "$logo"; command pacman -V\
    | GREP_COLORS='ms=01;33' command grep --color=always "\.\|-\|/\|_\|'\|" \
    | GREP_COLORS='ms=01;33' command grep --color=always '\\\|' ;;
  help|--help|-h) command echo -e "$logo"; shift 1
    [[ -z $@ ]] && command echo -e "\e[0;32;40mnew pacman alias:\e[0;34;40m_______________________|________________\e[m
    pacman upgrade [package(s)]\e[0;34;40m.........|..\e[mupgrade System and install New Package
    pacman install <package(s)>\e[0;34;40m.........|..\e[minstall New Package
    pacman remove <package(s)>\e[0;34;40m..........|..\e[mpurge Package and Dependency
    pacman autoremove [package(s)]\e[0;34;40m......|..\e[mremove Package and Orphan
    pacman clean\e[0;34;40m........................|..\e[mclean all cach
    pacman search [keyword(s)]\e[0;34;40m..........|..\e[msearch by keyword
    pacman info [package(s)]\e[0;34;40m............|..\e[mshow detail info of package
    pacman list [package(s)]\e[0;34;40m............|..\e[mlist all installed package
    pacman list explicit [package(s)]\e[0;34;40m...|..\e[mlist all explicit installed package
    pacman list orphan [package(s)]\e[0;34;40m.....|..\e[mlist orphan package
    pacman list group [group(s)]\e[0;34;40m........|..\e[mlist package group
    pacman version\e[0;34;40m......................|..\e[mshow pacman version
    pacman help [option(s)]\e[0;34;40m.............|..\e[mshow help sheat of option
\e[0;34;40m----------------------------------------|----------------\e[m"
    command pacman -h $@ | command grep --color=always '\-\|' ;;
  ''|logo|--logo) command echo -e "$logo" ;;
  *) command echo -e "$logo"; command pacman --color=always $@ ;;
  esac
}
EOF
command ls --color=always -l /etc/bash.bashrc
command . /etc/bash.bashrc

command echo -e "\n\e[1;36;40mset Passcode for \"${user_name}\":\e[m"
command passwd "${user_name}"
command reboot
