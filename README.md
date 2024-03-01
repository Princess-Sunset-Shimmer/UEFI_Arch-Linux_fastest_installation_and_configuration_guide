# installation
- step 0: [Make bootable USB and Boot live environment](#Make-bootable-USB-and-Boot-live-environment "goto Make-bootable-USB-and-Boot-live-environment")
- step 1: [connect internet](#connect-internet "goto connect-internet")
- step 2: [Create, Format and Mount new partitions](#Create-Format-and-Mount-new-partitions "goto Create-Format-and-Mount-new-partitions")
- step 3: [install Arch linux](#install-Arch-linux "goto install-Arch-linux")
- step 4: [finish the installation](#finish-the-installation "goto finish-the-installation")
## .Make bootable USB and Boot live environment
- goto [official download page](https://archlinux.org/download/) to download iso file
- check file SHA256
```c
        sha256sum /directory/archlinux.iso
```
- use either GUI utility like `rufus` and `etcher` or use CLI `dd` to write your image file to your USB flash drive
```c
        dd if=/directory/archlinux.iso of=/dev/usb_flash_drive_file_name status=progress
```
- boot your built bootable USB then select `*Arch Linux install medium (x86_64, UEFI)`
## .connect internet
- just wire in
## .Create, Format and Mount new partitions
- create new partition for drive
    - use `lsblk` to print your drive name first, then
    - use `cfdisk` to open TUI partition editor then select `GPT`
    - then create partition on your drive as suggested as table below

| Partition             | Type           | Size           | Purpose                             |
| :-------------------- | :------------- | :------------- | :---------------------------------- |
| /dev/your_drive_name1 | EFI system     | `256M` minium  | for Kernel, Bootloader and Firmware |
| /dev/your_deive_name2 | Linux Swap     | `512M` minium  | for Swaping                         |
| /dev/your_drive_name3 | Linux Root     | rest of drive  | for Arch                            |

you can make [swap] partition as twice bigger as your total system memory size\
use `grep MemTotal /proc/meminfo` to check your total memory size

- format partions
```c
        mkfs.fat -F 32 /dev/your_drive_name1
        mkswap /dev/your_drive_name2
        mkfs.ext4 /dev/your_drive_name3
```
- mount partitions
```c
        mount /dev/your_drive_name3 /mnt/
        mount --mkdir /dev/your_drive_name1 /mnt/boot/
        swapon /dev/your_drive_name2
```
the Order to mount your drive must obay the Hierarchy of File System\
mount Root-partition first, then mount Sub-partition next, and so on
## .install Arch linux
- install essential packages
```c
        pacstrap -K /mnt/ base linux-zen linux-firmware sof-firmware amd-ucode networkmanager grub efibootmgr
```
- - - -
[base](https://archlinux.org/packages/core/any/base/) is minimal Arch\
[linux-zen](https://archlinux.org/packages/extra/x86_64/linux-zen/) is kernel. Arch base + linux kernel = Arch linux\
you can omit [linux-firmware](https://archlinux.org/packages/core/any/linux-firmware/) if you install arch linux on `VirtualBox`\
[sof-firmware](https://archlinux.org/packages/extra/x86_64/sof-firmware/) for newer some laptops to get working audio\
[amd-ucode](https://archlinux.org/packages/core/any/amd-ucode/) provides `AMD microcode`. instead use [intel-ucode](https://archlinux.org/packages/extra/any/intel-ucode/) if you use intel chip\
you can omit [networkmanager](https://archlinux.org/packages/extra/x86_64/networkmanager/) if you only use `systemd [ o < ]` to configure network\
[grub](https://archlinux.org/packages/core/x86_64/grub/) and [efibootmgr](https://archlinux.org/packages/core/x86_64/efibootmgr/) for installing Bootloader later\
by this step, you can install other packages such as vim, tmux, gcc, cmatrix, fastfetch, wget, rtorrent, elinks, cmus and whatever you need
- - - -
- generate [fstab](https://wiki.archlinux.org/title/fstab) ( File System TABle ) file
```c
        genfstab -U /mnt/ > /mnt/etc/fstab
```
- install Bootloader
```c
        arch-chroot /mnt/
```
```c
        mount --mkdir /dev/your_drive_name1 /boot/efi/
        grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi/
        grub-mkconfig -o /boot/grub/grub.cfg
```
## .finish the installation
- set root password
```c
        passwd
```
- reboot
```
        exit
        reboot
```
congratulation, minimal Arch Linux is successfully installed. you can login as root and configure your brand new Arch Linux now
# configuration
- [basic setup](#basic-setup "goto basic-setup")
- [network](#network "goto network")
- [PACkage MANager](#PACkage-MANager "goto PACkage-MANager")
- [improve Booting performance](#improve-Booting-performance "goto improve-Booting-performance")
- [improve Storage performance](#improve-Storage-performance "goto improve-Storage-performance")
- [improve Memory performance](#improve-Memory-performance "goto improve-Memory-performance")
- [improve CPU performance](#improve-CPU-performance "goto improve-CPU-performance")
- [make console more awesome and cooler](#make-console-more-awesome-and-cooler "goto make-console-more-awesome-and-cooler")
- [other](#other "goto other")
## .basic setup
- set hostname
```lua
        echo 'your_new_hostname' > /etc/hostname
```
- create unpriviliged user
```c
        useradd -m user_name
        passwd user_name
```
## .network
- network manager
```
        systemctl enable NetworkManager
        systemctl restart NetworkManager
        nmtui
```
- generate [hblock](https://github.com/hectorm/hblock) file
```c
        pacman -Syu hblock
        hblock
```
- - - -
you can update hblock file by run `hblock` again
- - - -
- improve network performance and security
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
add above contents to your `/etc/sysctl.d/99-sysctl.conf` file; then
```c
        sysctl -p /etc/sysctl.d/99-sysctl.conf
```
## .PACkage MANager
edit `/etc/pacman.conf` file:\
uncomment `Color` xor insteadly add `alias pacman='pacman --color=always'` to your `/etc/bash.bashrc` file\
uncomment `ParrallelDownloads = 5` and change the number as you wish\
add `ILoveCandy`
## improve Booting performance
reboot then press `C` when `grub menu` show out to enter `grub console`\
then `videoinfo` to print all supported resolutions for grub\
remember the lowest supported resolution such example as `640x480`\
open `/etc/default/grub` file\
change `GRUB_GFXMODE` to your supported lowest resolution
```lua
GRUB_GFXMODE=640x480
```
change `GRUB_TIMEOUT` to `0`
```lua
GRUB_TIMEOUT=0
```
change `GRUB_TIMEOUT_STYLE` to `hidden`
```lua
GRUB_TIMEOUT_STYLE=hidden
```
modify the `GRUB_CMDLINE_LINUX_DEFAULT` to
```lua
GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=0"
```
delete `part_msdos` MBR modules in `GRUB_PRELOAD_MODULES` ( UEFI use GPT )
```lua
GRUB_PRELOAD_MODULES="part_gpt"
```
then regenerate `grub.cfg` file
```c
        grub-mkconfig -o /boot/grub/grub.cfg
```
## .improve Storage performance
- trim for SSD
```c
        systemctl enable fstrim.timer
```
- abandon core dump
```lua
kernel.core_pattern=/dev/null
```
add above contents to your `/etc/sysctl.d/99-sysctl.conf` file; then
```c
        sysctl -p /etc/sysctl.d/99-sysctl.conf
```
## .improve Memory performance
- improve Virtual Memory performance
```lua
vm.dirty_background_ratio=16
vm.dirty_ratio=32
vm.vfs_cache_pressure=32
```
add above contents to your `/etc/sysctl.d/99-sysctl.conf` file; then
```c
        sysctl -p /etc/sysctl.d/99-sysctl.conf
```
- turn on swap memory compression

open `/etc/default/grub` file\
add `zswap.enabled=1` to `GRUB_CMDLINE_LINUX_DEFAULT`
```lua
GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=0 zswap.enabled=1"
```
then regenerate `grub.cfg` file
```c
        grub-mkconfig -o /boot/grub/grub.cfg
```
## .improve CPU performance
- irqbalance
```
        pacman -Syu irqbalance
        systemctl enable irqbalance
```
- turn off [meltdown spectre attack](https://meltdownattack.com/) mitigations off

open `/etc/default/grub` file\
add `mitigations=off` to `GRUB_CMDLINE_LINUX_DEFAULT`
```lua
GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=0 zswap.enabled=1 mitigations=off"
```
then regenerate `grub.cfg` file
```c
        grub-mkconfig -o /boot/grub/grub.cfg
```
## .make console more awesome and cooler
- login shell

change your `/etc/issue` file contents to
```lua
\e[0;0H\e[0;30;35 <\l> [/\\rch Linux \r]\e[K\e[m
```
then you can append your login text art in `/etc/issue` file
```py
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
- set console font
```py
        ls /usr/share/kbd/consolefonts          # print available bitmap font files
        setfont font_name                       # test font temporary
        echo 'font_name' >> /etc/vconsole.conf  # set font persistenct
```
- - - -
`pacman -Syu terminus-font` to install [terminus console font](https://terminus-font.sourceforge.net/)
- - - -
- use mouse in console
```c
        systemctl enable gpm
        systemctl start gpm
```
- system wide bash configuration
remove all user specific config bash file `~/.bashrc`
then open `/etc/bash.bashrc` and only keep `[[ $- != *i* ]] && return`
follow the configuration below
- command alias
```sh
alias ls='ls --color=always -al'
alias ip='ip --color=always'
alias grep='grep --color=always'
alias diff='diff --color=always'
alias pacman='pacman --color=always'
alias rm='rm -f'
alias wget='wget -c'
alias dd='dd status=progress'
alias ps='ps -uf'
alias lspci='lspci -tv'
```
add above alias to your `/etc/bash.bashrc` file\
then `source /etc/bash.bashrc` to see the changes
- make command prompt awesome

open `/etc/bash.bashrc` file\
change original `PS1` configuration to
```sh
PS1="\[\e[2B\e[4C\e[0;36;40m__\e[1;35;44m \u \e[0;36;40m\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m <\l> [\w]\e[K\e[u\e[0;36;40m\]"
PS0='\e[12C\e[1;32m|\\/|\n\e[12C\e[1;36m|  |\e[1;32;44m \h \e[1;34;40m\n\e[13C\\/\n\e[1;35m'
if [[ $EUID != 0 ]]
then
        PS1="\[\e[2B\e[4C\e[1;33;40m__\e[0;31;43m \u \e[1;33;40m\]\n   |__> \[\e[s\e[0;0H\e[0;34;47m <\l> [\w]\e[K\e[u\e[1;33;40m\]"
        ps0='\e[12C\e[1;33m|\\/|\n\e[12C\e[1;31m|  |\e[1;32;43m \h \e[0;31;40m\n\e[13C\\/\n\e[1;35m'
else
        clear
fi
```
then `source /etc/bash.bashrc` to see the changes
- enhance bash tab completion
```sh
set show-all-if-unmodified on
set show-all-if-ambiguous on
set colored-stats On
set visible-stats On
set mark-symlinked-directories On
set colored-completion-prefix On
set menu-complete-display-prefix On
```
add above contents to your `/etc/inputrc` file
## .other
- generate [top](https://en.wikipedia.org/wiki/Top_(software)) command config file
```py
        top # open top task manager first
```
- - - -
suggested configuration:\
press key `T` twice to get solid CPU usage graph\
press key `M` once to get Memory usage graph\
press `Shift` + `V` to get COMMAND hierarchy view\
press `Shift` + `M` to show tasks by Memory usage\
press key `D` once to set refresh delay, lower to 0.1 or higher above 3.0\
press key `B` once switch to hilight mode then\
press key `X` once to hilight tasks sorting column\
press key `Y` once to hilight running tasks row\
press key `Z` once to turn on color view and\
press `Shift` + `Z` to toggle your color favor\
press `Shift` + `W` to generate config file for current user
- - - -
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
add above contents to your `/etc/vimrc` file
- - - -
Licence: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
