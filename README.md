minimal **/\rch Linux** installation starting right now\
[installation](#installation "goto installation")\
[configuration](#configuration "goto configuration")
# installation
- step 0: [Make bootable USB and Boot live environment](#Make-bootable-USB-and-Boot-live-environment "goto Make-bootable-USB-and-Boot-live-environment")
- step 1: [Partition, Format, Mount and genfstab for your drive](#Partition,-Format,-Mount-and-genfstab-for-your-drive "goto Partition,-Format,-Mount-and-genfstab-for-your-drive")
- step 2: [connect internet](#connect-internet "goto connect-internet")
- step 3: [install Arch Linux](#install-Arch-Linux "goto install-Arch-Linux")
- step 4: [install Bootloader and enable Microcode updates](#install-Bootloader-and-enable-Microcode-updates "goto install-Bootloader-and-enable-Microcode-updates")
- step 5: [finish the installation](#finish-the-installation "goto finish-the-installation")
## .Make bootable USB and Boot live environment
- goto [official download page](https://archlinux.org/download/) to download **iso_file**
- check file SHA256
```c
        sha256sum /directory/archlinux.iso
```
- use either **GUI-Utility** like `rufus` and `etcher` or use `dd` to write your **image_file** to your ***USB-Flash-Drive***
```c
        dd if=/directory/archlinux.iso of=/dev/usb_flash_drive_file_name status=progress
```
- boot your built ***Bootable-USB*** then select `*Arch Linux install medium (x86_64, UEFI)`
## .Partition, Format, Mount and genfstab for your drive
- create new partition for drive
    - use `lsblk` to know your **Drive-Name** first, then
    - use `cfdisk` TUI-Partition-Editor to open your Drive, then select `GPT`
    - then create Partition on your Drive as suggested as table below

| Partition             | Mount on       | Size           | Purpose                                  |
| :-------------------- | :------------- | :------------- | :--------------------------------------- |
| /dev/your_drive_name1 | `/boot`        | `256M` minium  | for Kernel, Bootloader, EFI and Firmware |
| /dev/your_deive_name2 | [SWAP]         | `512M` minium  | for Swaping                              |
| /dev/your_drive_name3 | `/`            | rest of drive  | for whole /\rch base                     |
- - - -
`note`: you can make **[SWAP]** partition as twice bigger as your ***Total-System-Memory-Size***\
use `grep MemTotal /proc/meminfo` to check your ***Total-System-Memory-Size***\
`note`: if you have ***Multiple-Fast-Drives***, then create multiple smaller **[SWAP]** partitions on Multiple-Fast-Drives instead of using one giant **[SWAP]** partition on Single-Drive
- - - -
- format partions
```c
        mkfs.fat -F 32 /dev/your_drive_name1
        mkswap /dev/your_drive_name2
        mkfs.ext4 /dev/your_drive_name3
```
- mount partitions
```c
        mount /dev/your_drive_name3 /mnt
        mount --mkdir /dev/your_drive_name1 /mnt/boot
        swapon /dev/your_drive_name2
```
- - - -
`note`: the **Order** to mount your Partitions or Drives must obay the **Hierarchy** of File-System.\
mount `/` ***Root-Partition*** to `/mnt` first, then mount ***Sub-Partition*** next, and so on
- - - -
- generate [fstab](https://wiki.archlinux.org/title/fstab) ( File System TABle ) file
```c
        mkdir /mnt/etc
        genfstab -U /mnt > /mnt/etc/fstab
```
## .connect internet
***--Just-Wire-In-->***
## .install Arch Linux
- install essential packages
```c
        pacstrap -K /mnt base linux linux-firmware sof-firmware amd-ucode networkmanager
```
- - - -
[base](https://archlinux.org/packages/core/any/base/) is minimal Arch_Base\
[linux](https://archlinux.org/packages/core/x86_64/linux/) is kernel. Arch_Base + Linux_Kernel = Arch_Linux\
you can omit [linux-firmware](https://archlinux.org/packages/core/any/linux-firmware/) if you install Arch_Linux on `VirtualBox`\
[sof-firmware](https://archlinux.org/packages/extra/x86_64/sof-firmware/) for some newer laptops to get Working-Audio, it's **Optional** for Minimal-System to get Working-Audio\
[amd-ucode](https://archlinux.org/packages/core/any/amd-ucode/) provides `AMD microcode`. instead use [intel-ucode](https://archlinux.org/packages/extra/any/intel-ucode/) if you use **intel** chip\
you can omit [networkmanager](https://archlinux.org/packages/extra/x86_64/networkmanager/) if you only use `systemd [ o < ]` to configure network\
by this step, you can install other packages such as ***dust, btop, vim, tmux, calc, gcc, cmatrix, fastfetch, wget, rtorrent, elinks, cmus*** and whatever you need
- - - -
## .install Bootloader and enable Microcode updates
- write your ***Boot-Entry-File*** for Boot-Loader
```c
        mkdir -P /mnt/boot/loader/entries
        vim /mnt/boot/loader/entries/arch.conf
```
example minimal **Entry-File** contents:
```
linux /vmlinuz-linux
initrd /amd-ucode.img
initrd /initramfs-linux.img
options root=UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX rw
```
`linux` takes path to kernel; path is NOT `/boot/...` because we previously created partition for `/boot`\
`initrd` [initial ram disk](https://en.wikipedia.org/wiki/Initial_ramdisk); you need to load ***amd-ucode.img*** xor ***intel-ucode.img*** to RAM first before load ***initial-ram-file-system*** image\
`options` takes **Kernel-Parameters**; replace `UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX` to your own `/` ***Root-Partition-UUID***;\
which you can find it in previously generated ***fstab*** file, or you can run `findmnt -o UUID -n /` to show it

- write your ***Systemd-Boot*** Config-File
```c
        vim /mnt/boot/loader/loader.conf
```
example minimal **Systemd-Boot** Config-File contents:
```c
default arch.conf
editor no
```
this set ***Default-Entry-File*** to previously wrote ***arch.conf***, and no ***Boot-Entry-Editor***.\
you can write more Entry-Files with more Kernels than just one
- install ***Systemd-Boot-Loader***
```c
        arch-chroot /mnt
        bootctl install
```
## .finish the installation
- set **Root-Password**
```c
        passwd
```
- reboot
```
        exit
        reboot
```
congratulation, minimal **/\rch Linux** is successfully installed.\
you can login as `root` and configure your brand new **/\rch Linux** now
# configuration
- [user setup](#basic-setup "goto user-setup")
- [network](#network "goto network")
- [PACkage MANager](#PACkage-MANager "goto PACkage-MANager")
- [improve Booting performance](#improve-Booting-performance "goto improve-Booting-performance")
- [improve Storage performance](#improve-Storage-performance "goto improve-Storage-performance")
- [improve Memory performance](#improve-Memory-performance "goto improve-Memory-performance")
- [improve CPU performance](#improve-CPU-performance "goto improve-CPU-performance")
- [language and timezone](#language-and-timezone "goto language-and-timezone")
- [sound system](#sound-system "goto sound-system")
- [make linux console more awesome and cooler](#make-linux-console-more-awesome-and-cooler "goto make-linux-console-more-awesome-and-cooler")
- [other packages](#other-packages "goto other-packages")
## .user setup
- set **hostname**
```lua
        echo 'your_new_hostname' > /etc/hostname
```
- create **Unpriviliged-User**
```c
        useradd -m your_user_name
        passwd user_name
```
remove all `.bash*` for this Unprivileged-User
then switch to Unpriviliged-User and create `.config` directory
```py
        rm -f /home/your_user_name/.bash*
        su -c "mkdir /home/your_user_name/.config" your_user_name
```
then symbolically link Unpriviliged-User's `.config` to root's one
```py
        ln -s /home/your_user_name/.config /root/.config
```
xor you can **Remove** entire `/root` directory and **Link** entire `/home/your_user_name` to `/root`
```py
        rm -fr /root
        ln -s /home/your_user_name /root
```
## .network
- Auto-Start [network manager](https://archlinux.org/packages/extra/x86_64/networkmanager/)
```
        systemctl enable NetworkManager
        systemctl restart NetworkManager
        nmtui
```
- - - -
`note`: the **Connection-Config-File** generated by `nmtui` is placed at `/etc/NetworkManager/system-connections`
- - - -
- generate [hblock](https://github.com/hectorm/hblock) Hosts-File
```c
        pacman -Syu hblock
        hblock
```
- - - -
`note`: you can update `/etc/hosts` file by run `hblock` again
- - - -
- improve network **Performance** and **Security**
```lua
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
```
add Above-Contents to your `/etc/sysctl.d/99-sysctl.conf` file; then
```c
        sysctl -p /etc/sysctl.d/99-sysctl.conf
```
## .PACkage MANager
edit `/etc/pacman.conf` file:\
uncomment `ParrallelDownloads = 5` and change the number as you wish\
add `ILoveCandy`\
add below `pacman() alias` to your `/etc/bash.bashrc` file:
```bash
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
```
- - - -
`note`: by above `pacman() alias`, you can do ***Additional-Commands*** as below
```lua
INSTALL_PACKAGE:
        pacman upgrade
        pacman install package_name
REMOVE_PACKAGE:
        pacman remove package_name
        pacman autoremove
        pacman clean
QUERY_PACKAGE:
        pacman search keywords
        pacman search group group_name
        pacman info package_name
        pacman list
        pacman list installed
        pacman list available
        pacman list group
        pacman list orphan
```
- - - -
optionally install [pacman-contrib](https://archlinux.org/packages/extra/x86_64/pacman-contrib/) to extend ***pacman*** functionality
```
        pacman -Syu pacman-contrib
```
## improve Booting performance
open `/boot/loader/loader.conf` file\
add Kernel-Parameters `quiet` and `loglevel=0` to `options`
```lua
options root=UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX rw quiet loglevel=0
```
you can manually update systemd-boot by run command `bootctl update`
or you can enable `systemd-boot-update` service for auto updates
```c
        systemctl enable systemd-boot-update
```
## .improve Storage performance
- trim for SSD
```c
        systemctl enable fstrim.timer
```
- abandon Core-Dump
```lua
kernel.core_pattern=/dev/null
```
add Above-Contents to your `/etc/sysctl.d/99-sysctl.conf` file; then
```c
        sysctl -p /etc/sysctl.d/99-sysctl.conf
```
## .improve Memory performance
- improve Virtual-Memory performance
```lua
vm.dirty_background_ratio=16
vm.dirty_ratio=32
vm.vfs_cache_pressure=32
```
add Above-Contents to your `/etc/sysctl.d/99-sysctl.conf` file; then
```c
        sysctl -p /etc/sysctl.d/99-sysctl.conf
```
- turn on Swap-Memory-Compression

open `/boot/loader/loader.conf` file\
add `zswap.enabled=1` to `options`
```lua
options root=UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX rw quiet loglevel=0 zswap.enabled=1
```
## .improve CPU performance
- irq balance
```
        pacman -Syu irqbalance
        systemctl enable irqbalance
```
- turn off [meltdown_spectre_attack](https://meltdownattack.com/) mitigations

open `/boot/loader/loader.conf` file\
add `mitigations=off` to `options`
```lua
options root=UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX rw quiet loglevel=0 zswap.enabled=1 mitigations=off
```
## language and timezone
these are **optional** configurations
- set language

generate and use your appropriate locale
```py
        echo 'C.UTF-8 UTF-8' > /etc/locale.gen
        locale-gen
        echo 'LANG=C.UTF-8' > /etc/locale.conf
```
replace `C.UTF-8 UTF8` and `C.UTF-8` to your appreciation
- set Console-Font
```py
        ls /usr/share/kbd/consolefonts               # print available bitmap font files
        setfont font_name                            # test font temporary
        echo 'FONT=font_name' >> /etc/vconsole.conf  # set font persistenct
```
Optionally install [terminus-font](https://terminus-font.sourceforge.net/) for more Font choices
```py
        pacman -Syu terminus-font
```
- set Input-Keyboard-Layout
```lua
        echo 'KEYMAP=us' >> /etc/vconsole.conf
```
replace `us` to your appreciate Keyboard-Layout
- timezone

first to list the ***Timezone-File*** you'd like to pickup
```lua
        ls -alh /usr/share/zoneinfo | more
```
then pick one and Symbolically **link** it to `/etc/localtime`
```lua
        ln -sf /usr/share/your_picked_race_zone_file /etc/localtime
```
## .sound system
to get Working-Audio for [alsa]() supported application, you need install [pipewire-alsa]()
```py
        pacman -Syu pipewire-alsa
```
to get Working-Audio for [pulse]() supported application, you need install [pipewire-pulse]()
```py
        pacman -Syu pipewire-pulse
```
you can **Optionally** install [alsa-utils](https://archlinux.org/packages/extra/x86_64/alsa-utils/) for using `alsamixer`
```py
        pacman -Syu alsa-utils
```
- - - -
`note`: installing Sound-System is **Optional** if you don't need Working-Audio
- - - -
## .make linux console more awesome and cooler
- Login-Shell **Top-Bar** and **Background**

change your `/etc/issue` file contents to
```lua
\e[0;0H\e[0;30;45m <\l> [\e[1;36;45m/\\ \e[1;37;45march\e[1;36;45mlinux\e[0;36;45m \r\e[0;30;45m]\e[K\e[m
```
then you can append your ***Login-Text-Art*** in `/etc/issue` file
```lua
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
```
- System-Wide profile configuration

open `/etc/profile` and change contents to
```bash
append_path() {
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
```
- enhance Bash-Tab-Completion
```sh
set show-all-if-unmodified on
set show-all-if-ambiguous on
set colored-stats on
set visible-stats on
set mark-symlinked-directories on
set colored-completion-prefix on
set menu-complete-display-prefix on
```
add Above-Contents to your `/etc/inputrc` file
- use Mouse in console
```c
        systemctl enable gpm
        systemctl start gpm
```
- tmux Terminal-MUltipleXer

install [tmux](https://archlinux.org/packages/extra/x86_64/tmux/)
```sh
        pacman -Syu tmux
```
create System-Wide tmux Config-File 
```sh
        vim /etc/tmux.conf
```
```sh
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
```
add Above-Contents to your `/etc/tmux.conf` file\
then
```lua
        tmux source-file /etc/tmux.conf
```
- fastfetch

install [fastfetch](https://archlinux.org/packages/extra/x86_64/fastfetch/)
```py
        pacman -Syu fastfetch
```
add Below-Alias to `/etc/bash.bashrc`
```bash
alias clear='clear; tput cup 4 0; fastfetch'
```
- - - -
then you can use `clear` command as `fastfetch`.\
you even can feed `fastfetch` **--options** to `clear` command
- - - -
generate Config-File to `/home/your_user_name/.config/fastfetch/config.jsonc`
```py
        fastfetch --gen-config
```
and Create file `/home/your_user_name/.config/fastfetch/logo`
```py
        vim /home/your_user_name/.config/fastfetch/logo
```
then Draw /\\rch Cutie-Mark out ( i means Arch-Logo )
```lua
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
```
now Change the `config.jsonc` file contents to
```jsonc
{
"logo": {"source": "/home/your_user_name/.config/fastfetch/logo"},
"display": {
    "color": {"separator": "yellow", "output": "cyan"},
    "separator": " | "
    },
"modules": [ 
    {"type": "kernel", "key": " /\\rch Linux", "keyColor": "blue"},
    {"type": "custom", "format": ">-----------<+>----------------------------------<", "outputColor": "separator"},
    {"type": "uptime", "key": "   Uptime   ", "keyColor": "green"},
    {"type": "shell", "key": "   Shell    ", "keyColor": "green"},
    {"type": "terminal", "key": "   Terminal ", "keyColor": "green"},
    {"type": "terminalfont", "key": "   Font     ", "keyColor": "green"},
    {"type": "packages", "key": "   Packages ", "keyColor": "green"},
    {"type": "localip", "key": "   Local IP ", "keyColor": "green"},
    {"type": "custom", "format": ">-----------<+>----------------------------------<", "outputColor": "separator"},
    {"type": "display", "key": "   Display  ", "keyColor": "magenta"},
    {"type": "cpu", "key": "   CPU      ", "keyColor": "magenta"},
    {"type": "gpu", "key": "   GPU      ", "keyColor": "magenta"},
    {"type": "memory", "key": "   RAM      ", "keyColor": "magenta"},
    {"type": "swap", "key": "   SWAP     ", "keyColor": "magenta"},
    {"type": "disk", "key": "   Disk     ", "keyColor": "magenta"},
    {"type": "battery", "key": "   Battery  ", "keyColor": "magenta"},
    {"type": "custom", "format": ">-----------<+>----------------------------------<", "outputColor": "separator"},
    "break",
    {"type":"colors", "paddingLeft": 9}
    ]
}
```
- - - -
`note`: Thanks for [Carter Li](https://github.com/CarterLi) and other Related-Developers, Configuration like Above has been added to ***Official-Fastfetch-Exsamples***\
now you can directly test it by run `fastfetch --load-config examples/22.jsonc` along with trying out other developer's config too
- - - -
- System-Wide bash configuration

ensure all User-Specific bash Config-File `~/.bashrc` have been removed\
then open `/etc/bash.bashrc` and Clear up all Default-Contents inside and Follow the configuration below
- general command alias
```bash
alias ip='ip --color=always'
alias grep='grep --color=always'
alias diff='diff --color=always'
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
```
add above alias to your `/etc/bash.bashrc` file\
then you can run `. /etc/bash.bashrc` to see the changes
- make Command-Prompt awesome

open `/etc/bash.bashrc` file\
change original `PS1` configuration to
```sh
PS1="\[\e[4C\e[0;36;40m__\e[1;35;44m \u \e[0;36;40m\]\n   |__> \[\e[1;36;40m\]"
PS0='\e[12C\e[1;32m|\\/|\n\e[12C\e[1;36m|  |\e[1;32;44m \h \e[1;34;40m\n\e[13C\\/\n\e[1;37m'
if [[ $EUID == 0 ]]
then
  PS1="\[\e[4C\e[0;31;40m__\e[0;31;43m \u \e[0;31;40m\]\n   |__> \[\e[1;33;40m\]"
  PS0='\e[12C\e[1;33m|\\/|\n\e[12C\e[1;31m|  |\e[1;32;43m \h \e[0;31;40m\n\e[13C\\/\n\e[1;37m'
else
  command clear
fi
```
then you can run `. /etc/bash.bashrc` to see the changes
- Interactive-Shell **Top-Bar**
```bash
tbar_mid=$( (( $(tput cols) - 6 >> 1 )) )
tbar_right=$( (( $(tput cols) - 9 )) )
tty_name=$(tty | sed 's#/dev/##')

tbar() {
  bat_percent=$(cat /sys/class/power_supply/BAT0/capacity)
  bat_format="\e[0;34;47m100% [II}"
  ((bat_percent < 100)) && bat_format=" \e[0;34;47m$bat_percent% [II\e[0;30;47m}"
  ((bat_percent < 64)) && bat_format=" \e[0;33;47m$bat_percent% [I\e[0;30;47mI}"
  ((bat_percent < 32)) && bat_format=" \e[0;31;47m$bat_percent% [\e[0;30;47mII}"
  echo -e "\n\e[1B\e[2A\e[s\e[0;0H\e[0;34;47m\e[K <$tty_name> [$(pwd)]\e[0;${tbar_mid}H$(date +"%I:%M %p")\e[0;${tbar_right}H$bat_format\e[u"
}

PROMPT_COMMAND=tbar
```
add Above-Contents to `/etc/bash.bashrc`\
and if you use `tmux` then append Contents-Below
```bash
if [[ -n $TMUX ]]; then
  PROMPT_COMMAND=''
  PS1="\[\e[2B\e[4C\e[0;36;40m__\e[1;35;44m \u \e[0;36;40m\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m\e[K <\l> [\w]\e[u\e[1;36;40m\]"
  [[ $EUID == 0 ]] && PS1="\[\e[2B\e[4C\e[0;31;40m__\e[0;31;43m \u \e[0;31;40m\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m\e[K <\l> [\w]\e[u\e[1;33;40m\]"
fi
```
then run `. /etc/bash.bashrc` to see the changes
## .other packages
- generate [top](https://en.wikipedia.org/wiki/Top_(software)) command Config-File
```py
        top # open top task manager first
```
- - - -
suggested configuration:\
press key `Z` once to turn on color view and\
press `Shift` + `Z` to toggle your color favor\
press key `T` twice to get solid CPU usage graph\
press key `M` once to get Memory usage graph\
press `Shift` + `M` to show tasks by Memory usage\
press `Shift` + `V` to get COMMAND hierarchy view\
press key `D` once to set refresh delay, lower to 0.1 or higher above 3.0\
press key `B` once switch to hilight mode then\
press key `X` once to hilight tasks sorting column\
press `Shift` + `W` to generate config file for current user
- - - -
- wget

install [wget](https://archlinux.org/packages/extra/x86_64/wget/)
```py
        pacman -Syu wget
```
useful wget alias to add into `/etc/bash.bashrc`
```bash
alias wget='wget -c'
```
- vim minimal configuration
```lua
:set number
:set nowrap
:set cursorline
:set foldmethod=indent
:set expandtab
:set tabstop=4
:set shiftwidth=4
:set incsearch
:set hlsearch
```
add Above-Contents to your `/etc/vimrc` file
- - - -
Licence: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
