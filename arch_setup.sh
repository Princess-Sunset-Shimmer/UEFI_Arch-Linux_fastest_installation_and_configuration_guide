# USER #=====================================================================#

host_name="host"
user_name="user"
group="audio,video,storage"
remove_and_link_root_directory='on'

# NETWORK #==================================================================#

network_manager_auto_start='on'
network_optimization='on'
hblock='on'

# BOOT #=====================================================================#

kernel="/vmlinuz-linux"
ram_file_system="/initramfs-linux.img"
microcode="/amd-ucode.img"
silent_boot='on'
bootloader_auto_update='on'

# CPU #======================================================================#

side_channel_attack_mitigation='off'
irq_balance='on'

# RAM #======================================================================#

virtual_memory_optimization='on'
swap_memory_compression='on'

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

general_alias='on'
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

gcc='on'

github_cli='on'

calc='on'

# SYSTEM UTILITIES #=========================================================#

customize_top='on'

btop='on'

dust='on'

tldr='on'

less='off'
less_alias='on'

fastfetch='on'
interactive_shell_fastfetch='on'
fastfetch_clear='on'
customize_fastfetch='on'
fastfetch_logo="arch3"
customize_arch_logo='on'
fastfetch_separator=" | "
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

ffmpeg='on'

cmus='on'
customize_cmus='on'

# OTHER PACKAGES #===========================================================#

cmatrix='off'

#============================================================================#

command echo -e '\e[1;36;40m ***\e[1;34;40m generating <_pacman_> Config-File\e[1;36;40m ***\e[m'
if [[ ${progress_bar} == off ]]; then progress_bar='NoProgressBar'; else progress_bar='ILoveCandy'; fi
if [[ -n ${architecture} ]]; then architecture="Architecture = ${architecture}"; else architecture='Architecture = auto'; fi
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
command cat /etc/pacman.conf

command echo -e '\e[1;36;40m ***\e[1;34;40m installing Packages\e[1;36;40m ***\e[m'
if [[ ${hblock} == on ]]; then hblock=' hblock'; else hblock=''; fi
if [[ ${irq_balance} == on ]]; then irq_balance=' irqbalance'; else irq_balance=''; fi
if [[ ${nano} == on ]]; then nano=' nano'; else nano=''; fi
if [[ ${vim} == on ]]; then vim=' vim'; else vim=''; fi
if [[ ${gcc} == on ]]; then gcc=' gcc'; else gcc=''; fi
if [[ ${github_cli} == on ]]; then github_cli=' github-cli'; else github_cli=''; fi
if [[ ${calc} == on ]]; then calc=' calc'; else calc=''; fi
if [[ ${wget} == on ]]; then wget=' wget'; else wget=''; fi
if [[ ${transmission_remote} == on ]]; transmission_remote=' transmission-cli'; else transmission_remote=''; fi
if [[ ${pipewire_pulse} == on ]]; then pipewire_pulse=' pipewire-pulse'; else pipewire_pulse=''; fi
if [[ ${pipewire_alsa} == on ]]; then pipewire_alsa=' pipewire-alsa'; else pipewire_alsa=''; fi
if [[ ${alsa_utils} == on ]]; then alsa_utils=' alsa-utils'; else alsa_utils=''; fi
if [[ ${sof_firmware} == on ]]; then sof_firmware=' sof-firmware'; else sof_firmware=''; fi
if [[ ${pacman_contrib} == on ]]; then pacman_contrib=' pacman-contrib'; else pacman_contrib=''; fi
if [[ ${btop} == on ]]; then btop=' btop'; else btop=''; fi
if [[ ${dust} == on ]]; then dust=' dust'; else dust=''; fi
if [[ ${tldr} == on ]]; then tldr=' tldr'; else tldr=''; fi
if [[ ${less} == on ]]; then less=' less'; else less=''; fi
if [[ ${fastfetch} == on ]]; then fastfetch=' fastfetch'; else fastfetch=''; fi
if [[ ${tmux} == on ]]; then tmux=' tmux'; else tmux=''; fi
if [[ ${ffmpeg} == on ]]; then ffmpeg=' ffmpeg'; else ffmpeg=''; fi
if [[ ${cmus} == on ]]; then cmus=' cmus'; else cmus=''; fi
if [[ ${cmatrix} == on ]]; then cmatrix=' cmatrix'; else cmatrix=''; fi
if command pacman -Syu --color=always --noconfirm${hblock}${irq_balance}${nano}${vim}${gcc}${github_cli}${calc}${wget}${transmission_remote}${pipewire_alsa}${alsa_utils}${sof_firmware}${pacman_contrib}${btop}${dust}${tldr}${less}${fastfetch}${tmux}${ffmpeg}${cmus}${cmatrix}
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
    then command pacman -Runs --color=always --noconfirm hblock; command echo '' > /etc/hosts
    else command hblock; fi
[[ -z ${irq_balance} ]] && command pacman -Runs --color=always --noconfirm irqbalance
[[ -z ${nano} ]] && command pacman -Runs --color=always --noconfirm nano
if [[ -z ${vim} ]]; then command pacman --Runs --color=always --noconfirm vim
else
    command echo -e "runtime! archlinux.vim\n:set tabstop=${indent_size}\n:set shiftwidth=${indent_size}" > /etc/vimrc
    [[ ${line_number} == on ]] && command echo ':set number' >> /etc/vimrc
    [[ ${line_wrap} != on ]] && command echo ':set nowrap' >> /etc/vimrc
    [[ ${expand_tab} == on ]] && command echo ':set expandtab' >> /etc/vimrc
    [[ ${fold} == on ]] && command echo ':set foldmethod=indent' >> /etc/vimrc
    [[ ${hilight_current_line} == on ]] && command echo ':set cursorline' >> /etc/vimrc
    [[ ${enhance_search} == on ]] && command echo -e ':set incsearch\n:set hlsearch' >> /etc/vimrc
    command ls --color=always -l /etc/vimrc
fi
[[ -z ${gcc} ]] && command pacman -Runs --color=always --noconfirm gcc
[[ -z ${github_cli} ]] && command pacman -Runs --color=always --noconfirm github-cli
[[ -z ${calc} ]] && command pacman -Runs --color=always --noconfirm calc
if [[ -z ${wget} ]]; then command pacman -Runs --color=always --noconfirm wget; wget_alias='off'; fi
[[ -z ${transmission_remote} ]] && command pacman -Runs --color=always --noconfirm transmission-cli
[[ -z ${dust} ]] && command pacman -Runs --color=always --noconfirm dust
[[ -z ${pipewire_pulse} ]] && command pacman -Runs --color=always --noconfirm pipewire-pulse
[[ -z ${pipewire_alsa} ]] && command pacman -Runs --color=always --noconfirm pipewire-alsa
[[ -z ${alsa_utils} ]] && command pacman -Runs --color=always --noconfirm alsa-utils
[[ -z ${sof_firmware} ]] && command pacman -Runs --color=always --noconfirm sof-firmware
[[ -z ${pacman_contrib} ]] && command pacman -Runs --color=always pacman-contrib
if [[ -z ${btop} ]]; then command pacman -Runs --color=always --noconfirm btop; command rm -fr /home/"${user_name}"/.config/btop; fi
[[ -z ${tldr} ]] && command pacman -Runs --color=always --noconfirm tldr
if [[ -z ${less} ]]; then command pacman -Runs --color=always --noconfirm less; less_alias='off'; fi
if [[ -z ${fastfetch} ]]; then
    command pacman -Runs --color=always --noconfirm fastfetch
    customize_fastfetch='off'; interactive_shell_fastfetch='off'; fastfetch_clear='off'
    [[ -e /home/"${user_name}/.config/fastfetch" ]] && command rm -fr /home/"${user_name}"/.config/fastfetch
    else if [[ ${customize_fastfetch} == on ]]; then
        [[ -z ${fastfetch_logo} ]] && fastfetch_logo='arch3'
        [[ -z ${fastfetch_separator} ]] && fastfetch_separator=' | '
        [[ -z ${fastfetch_separator_color} ]] && fastfetch_separator_color='yellow'
        [[ -z ${fastfetch_system_name_color} ]] && fastfetch_system_name_color='blue'
        [[ -z ${fastfetch_system_info_color} ]] && fastfetch_system_info_color='cyan'
        [[ -z ${fastfetch_software_info_color} ]] && fastfetch_software_info_color='green'
        [[ -z ${fastfetch_hardware_info_color} ]] && fastfetch_hardware_info_color='magenta'
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
$2        /      ,.-*-..      \
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
        command cat << EOF > "/home/${user_name}/.config/fastfetch/config.jsonc"
{
"logo": {"source": "${fastfetch_logo}"},
"display": {
    "color": {"separator": "${fastfetch_separator_color}", "output": "${fastfetch_system_info_color}"},
    "separator": "${fastfetch_separator}"
    },
"modules": [ 
    {"type": "kernel", "key": " /\\\\rch Linux", "keyColor": "${fastfetch_system_name_color}"},
    {"type": "custom", "format": ">-----------<+>----------------------------------<", "outputColor": "separator"},
    {"type": "uptime", "key": "   Uptime   ", "keyColor": "${fastfetch_software_info_color}"},
    {"type": "shell", "key": "   Shell    ", "keyColor": "${fastfetch_software_info_color}"},
    {"type": "terminal", "key": "   Terminal ", "keyColor": "${fastfetch_software_info_color}"},
    {"type": "terminalfont", "key": "   Font     ", "keyColor": "${fastfetch_software_info_color}"},
    {"type": "packages", "key": "   Packages ", "keyColor": "${fastfetch_software_info_color}"},
    {"type": "localip", "key": "   Local IP ", "keyColor": "${fastfetch_software_info_color}"},
    {"type": "custom", "format": ">-----------<+>----------------------------------<", "outputColor": "separator"},
    {"type": "display", "key": "   Display  ", "keyColor": "${fastfetch_hardware_info_color}"},
    {"type": "cpu", "key": "   CPU      ", "keyColor": "${fastfetch_hardware_info_color}"},
    {"type": "gpu", "key": "   GPU      ", "keyColor": "${fastfetch_hardware_info_color}"},
    {"type": "memory", "key": "   RAM      ", "keyColor": "${fastfetch_hardware_info_color}"},
    {"type": "swap", "key": "   SWAP     ", "keyColor": "${fastfetch_hardware_info_color}"},
    {"type": "disk", "key": "   Disk     ", "keyColor": "${fastfetch_hardware_info_color}"},
    {"type": "battery", "key": "   Battery  ", "keyColor": "${fastfetch_hardware_info_color}"},
    {"type": "custom", "format": ">-----------<+>----------------------------------<", "outputColor": "separator"},
    "break",
    {"type":"colors", "paddingLeft": 9}
    ]
}
EOF
        command chown "${user_name}":"${user_name}" /home/"${user_name}"/.config/fastfetch/config.jsonc
        command ls --color=always -l /home/"${user_name}"/.config/fastfetch/config.jsonc
    fi
fi
if [[ -z ${tmux} ]]; then
    command pacman -Runs --color=always --noconfirm tmux; [[ -e /etc/tmux.conf ]] && command rm -f /etc/tmux.conf
    else if [[ ${customize_tmux} == on ]]; then
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
fi
[[ -z ${cmatrix} ]] && command pacman -Runs --color=always --noconfirm cmatrix
[[ -z ${ffmpeg} ]] && command pacman -Runs --color=always --noconfirm ffmpeg
if [[ -z ${cmus} ]]; then
    command pacman -Runs --color=always --noconfirm cmus; [[ -e /home/"${user_name}"/.config/cmus ]] && command rm -fr /home/"${user_name}"/.config/cmus
else
    command su -c "mkdir /home/\"${user_name}\"/.config/cmus" "${user_name}"
    if [[ ${customize_cmus} == on ]]; then
        command cat << EOF > "/home/${user_name}/.config/cmus/autosave"
set aaa_mode=all
set altformat_current= %F 
set altformat_playlist= %f%= %d 
set altformat_title=%f
set altformat_trackwin= %f%= %d 
set auto_expand_albums_follow=true
set auto_expand_albums_search=true
set auto_expand_albums_selcur=true
set auto_reshuffle=true
set buffer_seconds=10
set color_cmdline_attr=default
set color_cmdline_bg=default
set color_cmdline_fg=default
set color_cur_sel_attr=default
set color_error=lightred
set color_info=lightyellow
set color_separator=green
set color_statusline_attr=default
set color_statusline_bg=gray
set color_statusline_fg=black
set color_titleline_attr=default
set color_titleline_bg=cyan
set color_titleline_fg=blue
set color_trackwin_album_attr=bold
set color_trackwin_album_bg=default
set color_trackwin_album_fg=default
set color_win_attr=default
set color_win_bg=default
set color_win_cur=lightyellow
set color_win_cur_attr=default
set color_win_cur_sel_attr=default
set color_win_cur_sel_bg=magenta
set color_win_cur_sel_fg=lightyellow
set color_win_dir=lightblue
set color_win_fg=default
set color_win_inactive_cur_sel_attr=default
set color_win_inactive_cur_sel_bg=gray
set color_win_inactive_cur_sel_fg=lightyellow
set color_win_inactive_sel_attr=default
set color_win_inactive_sel_bg=yellow
set color_win_inactive_sel_fg=black
set color_win_sel_attr=default
set color_win_sel_bg=magenta
set color_win_sel_fg=lightgreen
set color_win_title_attr=default
set color_win_title_bg=blue
set color_win_title_fg=white
set confirm_run=true
set continue=true
set continue_album=true
set device=/dev/cdrom
set display_artist_sort_name=false
set dsp.alsa.device=default
set dsp.jack.resampling_quality=2
set dsp.jack.server_name=
set dsp.oss.device=
set follow=true
set format_clipped_text=…
set format_current= %a - %l%! - %n. %t%= %y 
set format_playlist= %-21%a %3n. %t%= %y %d %{?X!=0?%3X ?    }
set format_playlist_va= %-21%A %3n. %t (%a)%= %y %d %{?X!=0?%3X ?    }
set format_statusline= %{status} %{?show_playback_position?%{position} %{?duration?/ %{duration} }?%{?duration?%{duration} }}- %{total} %{?bpm>0?at %{bpm} BPM }%{?volume>=0?vol: %{?lvolume!=rvolume?%{lvolume},%{rvolume} ?%{volume} }}%{?stream?buf: %{buffer} }%{?show_current_bitrate & bitrate>=0? %{bitrate} kbps }%=%{?repeat_current?repeat current?%{?play_library?%{playlist_mode} from %{?play_sorted?sorted }library?playlist}} | %1{continue}%1{follow}%1{repeat}%1{shuffle} 
set format_title=%a - %l - %t (%y)
set format_trackwin=%3n. %t%= %y %d 
set format_trackwin_album= %l %= %{albumduration} 
set format_trackwin_va=%3n. %t (%a)%= %y %d 
set format_treewin=  %l
set format_treewin_artist=%a
set icecast_default_charset=ISO-8859-1
set id3_default_charset=ISO-8859-1
set input.cue.priority=50
set input.flac.priority=50
set input.modplug.priority=50
set input.vorbis.priority=50
set input.wav.priority=50
set lib_add_filter=
set lib_sort=albumartist date album discnumber tracknumber title filename play_count
set mixer.alsa.channel=PCM
set mixer.alsa.device=default
set mixer.oss.channel=PCM
set mixer.oss.device=
set mixer.pulse.restore_volume=1
set mouse=false
set mpris=true
set output_plugin=alsa
set passwd=
set pause_on_output_change=false
set pl_sort=
set play_library=true
set play_sorted=false
set repeat=true
set repeat_current=false
set replaygain=disabled
set replaygain_limit=true
set replaygain_preamp=0.000000
set resume=false
set rewind_offset=5
set scroll_offset=2
set set_term_title=true
set show_all_tracks=true
set show_current_bitrate=false
set show_hidden=false
set show_playback_position=true
set show_remaining_time=false
set shuffle=tracks
set skip_track_info=false
set smart_artist_sort=true
set softvol=false
set softvol_state=0 0
set start_view=tree
set status_display_program=
set stop_after_queue=false
set time_show_leading_zero=true
set tree_width_max=0
set tree_width_percent=33
set wrap_search=true
bind browser backspace browser-up
bind browser i toggle show_hidden
bind browser space win-activate
bind browser u win-update
bind common ! push shell 
bind common + vol +10%
bind common , seek -1m
bind common - vol -10%
bind common . seek +1m
bind common / search-start
bind common 1 view tree
bind common 2 view sorted
bind common 3 view playlist
bind common 4 view queue
bind common 5 view browser
bind common 6 view filters
bind common 7 view settings
bind common = vol +10%
bind common ? search-b-start
bind common B player-next-album
bind common C toggle continue
bind common D win-remove
bind common E win-add-Q
bind common F push filter 
bind common G win-bottom
bind common I echo {}
bind common L push live-filter 
bind common M toggle play_library
bind common N search-prev
bind common P win-mv-before
bind common U win-update-cache
bind common Z player-prev-album
bind common [ vol +1% +0
bind common ] vol +0 +1%
bind common ^B win-page-up
bind common ^C echo Type :quit<enter> to exit cmus.
bind common ^D win-half-page-down
bind common ^E win-scroll-down
bind common ^F win-page-down
bind common ^L refresh
bind common ^R toggle repeat_current
bind common ^U win-half-page-up
bind common ^Y win-scroll-up
bind common a win-add-l
bind common b player-next
bind common c player-pause
bind common delete win-remove
bind common down win-down
bind common e win-add-q
bind common end win-bottom
bind common enter win-activate
bind common f toggle follow
bind common g win-top
bind common h seek -5
bind common home win-top
bind common i win-sel-cur
bind common j win-down
bind common k win-up
bind common l seek +5
bind common left seek -5
bind common m toggle aaa_mode
bind common mlb_click_bar player-pause
bind common mlb_click_selected win-activate
bind common mouse_scroll_down win-down
bind common mouse_scroll_down_bar seek -5
bind common mouse_scroll_down_title right-view
bind common mouse_scroll_up win-up
bind common mouse_scroll_up_bar seek +5
bind common mouse_scroll_up_title left-view
bind common n search-next
bind common o toggle play_sorted
bind common p win-mv-after
bind common page_down win-page-down
bind common page_up win-page-up
bind common q quit -i
bind common r toggle repeat
bind common right seek +5
bind common s toggle shuffle
bind common space win-toggle
bind common t toggle show_remaining_time
bind common tab win-next
bind common u update-cache
bind common up win-up
bind common v player-stop
bind common x player-play
bind common y win-add-p
bind common z player-prev
bind common { vol -1% -0
bind common } vol -0 -1%
fset 90s=date>=1990&date<2000
fset classical=genre="Classical"
fset missing-tag=!stream&(artist=""|album=""|title=""|tracknumber=-1|date=-1)
fset mp3=filename="*.mp3"
fset ogg=filename="*.ogg"
fset ogg-or-mp3=ogg|mp3
fset unheard=play_count=0
factivate
EOF
        command chown "${user_name}":"${user_name}" /home/"${user_name}"/.config/cmus/autosave
        command ls --color=always -l /home/"${user_name}"/.config/cmus/autosave
    fi
fi

command echo -e '\e[1;36;40m ***\e[1;34;40m toggling Services\e[1;36;40m ***\e[m'
[[ ${mouse} == on ]] && command systemctl start gpm
command systemctl enable NetworkManager systemd-boot-update fstrim.timer gpm${irq_balance}
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
\e[1;35m                       `+.__  _...+'   | | ,--.|| |' k| || (_) || ,.`.,/  `| |(  C==<| '  `.,-.|  `+. +.
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
append_path () {
  case ":$PATH:" in
    *:"$1":*)
      ;;
    *)
      PATH="${PATH:+$PATH:}$1"
  esac
}
export PATH='/usr/local/sbin:/usr/local/bin:/usr/bin'
if [[ -d /etc/profile.d/ ]]; then
  for profile in /etc/profile.d/*.sh; do
    [[ -r $profile ]] && . "$profile"
  done
  unset profile
fi
[[ $- == *i* ]] && [[ -z $POSIXLY_CORRECT ]] && [[ ${0#-} != sh ]] && [[ -r /etc/bash.bashrc ]] && . /etc/bash.bashrc
unset -f append_path
unset TERMCAP
unset MANPATH
EOF
command ls --color=always -l /etc/profile
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
if [[ ${fastfetch_clear} == on ]]
    then command echo "alias clear='clear; tput cup 4 0; fastfetch'" > /etc/bash.bashrc
    else command echo '' > /etc/bash.bashrc; fi
[[ ${wget_alias} == on ]] && command echo "alias wget='wget -c'" >> /etc/bash.bashrc
[[ ${less_alias} == on ]] && command echo "alias less='less -r'" >> /etc/bash.bashrc
[[ ${general_alias} == on ]] && command cat << 'EOF' >> /etc/bash.bashrc
alias grep='grep --color=always'
alias diff='diff --color=always'
alias ip='ip --color=always'
alias rm='rm -f'
alias dd='dd status=progress'
alias ps='ps -uf'
alias pwd="pwd -LP | command grep --color=always '/\|'"
alias I='su -c'
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
  command lspci -tvvv "$@" |\
  command grep --color=always ']\|\[\|+\|-\||\|\\\|/\|' |\
  GREP_COLORS='ms=01;34'\
  command grep --color=always '\.\|:\|,\|' |\
  GREP_COLORS='ms=01;35'\
  command grep --color=always 'Audio\|' |\
  GREP_COLORS='ms=01;36'\
  command grep --color=always 'USB\|'
}
findmnt() {
  command findmnt "$@" |\
  command grep --color=always 'TARGET\|SOURCE\|FSTYPE\|OPTIONS\|' |\
  GREP_COLORS='ms=01;36'\
  command grep --color=always ',\|=\|' |\
  GREP_COLORS='ms=01;32'\
  command grep --color=always '/\|'
}
sha256sum() {
  command sha256sum "$@"
  command echo -e '\e[1;32;40m----------------------------------------------------------------\e[m\n'
}
EOF
[[ ${pacman_alias} == on ]] && command cat << 'EOF' >> /etc/bash.bashrc
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
EOF
[[ ${interactive_shell_top_bar} == on ]] && command cat << 'EOF' >> /etc/bash.bashrc
tbar_mid=$((($(command tput cols) - 6 >> 1)))
tbar_right=$((($(command tput cols) - 9)))
tty_name=$(command tty | command sed 's#/dev/##')
tbar() {
  bat_percent=$(command cat /sys/class/power_supply/BAT0/capacity)
  bat_format='\e[0;34;47m100% [II}'
  ((bat_percent < 100)) && bat_format=" \e[0;34;47m$bat_percent% [II\e[0;30;47m}"
  ((bat_percent < 64)) && bat_format=" \e[0;33;47m$bat_percent% [I\e[0;30;47mI}"
  ((bat_percent < 32)) && bat_format=" \e[0;31;47m$bat_percent% [\e[0;30;47mII}"
  command echo -e "\n\e[1B\e[2A\e[s\e[0;0H\e[0;34;47m\e[K <$tty_name> [$(command pwd -LP)]\e[0;${tbar_mid}H$(command date +'%I:%M %p')\e[0;${tbar_right}H$bat_format\e[u"
}
PROMPT_COMMAND=tbar
EOF
user_id='$EUID'
tmux_id='$TMUX'
[[ ${user_command_prompt_color} != *\e[*m* ]] && user_command_prompt_color='\e[1;35;44m'
[[ ${user_command_prompt_arrow_color} != *\e[*m* ]] && user_command_prompt_arrow_color='\e[0;36;40m'
[[ ${user_command_prompt_line_color} != *\e[*m* ]] && user_command_prompt_line_color='\e[1;36;40m'
[[ ${root_command_prompt_color} != *\e[*m* ]] && root_command_prompt_color='\e[0;31;43m'
[[ ${root_command_prompt_arrow_color} != *\e[*m* ]] && root_command_prompt_arrow_color='\e[0;31;40m'
[[ ${root_command_prompt_line_color} != *\e[*m* ]] && root_command_prompt_line_color='\e[1;33;40m'
[[ -n ${tmux} ]] && [[ ${interactive_shell_fastfetch} == on ]] && command cat << EOF >> /etc/bash.bashrc
PS1='\[\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[${user_command_prompt_line_color}\]'
PS0='\e[12C\e[1;32m|\\/|\n\e[12C\e[1;36m|  |\e[1;32;44m \h \e[1;34;40m\n\e[13C\\/\n\e[1;37m'
if [[ ${user_id} == 0 ]]
then
  PS1='\[\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[${root_command_prompt_line_color}\]'
  PS0='\e[12C\e[1;33m|\\/|\n\e[12C\e[1;31m|  |\e[1;32;43m \h \e[0;31;40m\n\e[13C\\/\n\e[1;37m'
else if [[ -z ${tmux_id} ]]
then
  command clear
  command tput cup 4 0
  command fastfetch
  fi
fi
if [[ -n ${tmux_id} ]]
then
  PROMPT_COMMAND=''
  PS1='\[\e[2B\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m\e[K <\l> [\w]\e[u${user_command_prompt_line_color}\]'
  [[ ${user_id} == 0 ]] && PS1='\[\e[2B\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m\e[K <\l> [\w]\e[u${root_command_prompt_line_color}\]'
fi
EOF
[[ -z ${tmux} ]] && [[ ${interactive_shell_fastfetch} == on ]] && command cat << EOF >> /etc/bash.bashrc
PS1='\[\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[${user_command_prompt_line_color}\]'
PS0='\e[12C\e[1;32m|\\/|\n\e[12C\e[1;36m|  |\e[1;32;44m \h \e[1;34;40m\n\e[13C\\/\n\e[1;37m'
if [[ ${user_id} == 0 ]]
then
  PS1='\[\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[${root_command_prompt_line_color}\]'
  PS0='\e[12C\e[1;33m|\\/|\n\e[12C\e[1;31m|  |\e[1;32;43m \h \e[0;31;40m\n\13C\\/\n\e[1;37m'
else
  command clear
  command tput cup 4 0
  command fastfetch
fi
EOF
[[ -n ${tmux} ]] && [[ ${interactive_shell_fastfetch} != on ]] && command cat << EOF >> /etc/bash.bashrc
PS1='\[\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[${user_command_prompt_line_color}\]'
PS0='\e[12C\e[1;32m|\\/|\n\e[12C\e[1;36m|  |\e[1;32;44m \h \e[1;34;40m\n\e[13C\\/\n\e[1;37m'
if [[ ${user_id} == 0 ]]
then
  PS1='\[\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[${root_command_prompt_line_color}\]'
  PS0='\e[12C\e[1;33m|\\/|\n\e[12C\e[1;31m|  |\e[1;32;43m \h \e[0;31;40m\n\e[13C\\/\n\e[1;37m'
else [[ -z ${tmux_id} ]] && command clear
fi
if [[ -n ${tmux_id} ]]
then
  PROMPT_COMMAND=''
  PS1='\[\e[2B\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m\e[K <\l> [\w]\e[u${user_command_prompt_line_color}\]'
  [[ ${user_id} == 0 ]] && PS1='\[\e[2B\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m\e[K <\l> [\w]\e[u${root_command_prompt_line_color}\]'
fi
EOF
[[ -z ${tmux} ]] && [[ ${interactive_shell_fastfetch} != on ]] && command cat << EOF >> /etc/bash.bashrc
PS1='\[\e[4C${user_command_prompt_arrow_color}__${user_command_prompt_color} \u ${user_command_prompt_arrow_color}\]\n   |__> \[${user_command_prompt_line_color}\]'
PS0='\e[12C\e[1;32m|\\/|\n\e[12C\e[1;36m|  |\e[1;32;44m \h \e[1;34;40m\n\e[13C\\/\n\e[1;37m'
if [[ ${user_id} == 0 ]]
then
  PS1='\[\e[4C${root_command_prompt_arrow_color}__${root_command_prompt_color} \u ${root_command_prompt_arrow_color}\]\n   |__> \[${root_command_prompt_line_color}\]'
  PS0='\e[12C\e[1;33m|\\/|\n\e[12C\e[1;31m|  |\e[1;32;43m \h \e[0;31;40m\n\e[13C\\/\n\e[1;37m'
else command clear
fi
EOF
command ls --color=always -l /etc/bash.bashrc
command . /etc/bash.bashrc

if [[ ${customize_top} == on ]]
    then command su -c "mkdir /home/\"${user_name}\"/.config/procps" "${user_name}"
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
    else [[ -e "/home/${user_name}"/.config/procps ]] && command rm -fr /home/"${user_name}"/.config/procps
fi

command echo -e "\n\e[1;36;40mset Passcode for \"${user_name}\":\e[m"
command passwd "${user_name}"
command reboot
