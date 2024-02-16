# installation
- step 0: [Make bootable USB and Boot live environment](#Make-bootable-USB-and-Boot-live-environment "goto Make-bootable-USB-and-Boot-live-environment")
- step 1: [connect internet](#connect-internet "goto connect-internet")
- step 2: [Create, Format and Mount new partitions](#Create-Format-and-Mount-new-partitions "goto Create-Format-and-Mount-new-partitions")
- step 3: [install arch linux](#install-arch-linux "goto install-arch-linux")
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
    - type `cfdisk` to open TUI partition editor then select `GPT`
    - then create partition on your drive as required as table below

partition name | partition type | partition size | partition purpose
:------------- | :------------- | :------------- | :----------------
/dev/sda1      | EFI system     | `300M` minium  | for kernel and bootloader
/dev/sda2      | Linux swap     | `512M` minium  | for swaping
/dev/sda3      | Linux root     | rest of drive  | for Arch

you can make [swap] partition as twice bigger as your total system memory size\
use `grep MemTotal /proc/meminfo` to check your total memory size

- format partions
```c
        mkfs.fat -F 32 /dev/sda1
        mkswap /dev/sda2
        mkfs.ext4 /dev/sda3
```
- mount partitions
```c
        mount --mkdir /dev/sda1 /mnt/boot/
        swapon /dev/sda2
        mount /dev/sda3 /mnt/
```
## .install arch linux
- install essential packages
```c
        pacstrap -K /mnt/ base linux-zen linux-firmware networkmanager amd-ucode grub efibootmgr
```
- - - -
[base](https://archlinux.org/packages/core/any/base/) is minimal arch\
[linux-zen](https://archlinux.org/packages/extra/x86_64/linux-zen/) is kernel. arch base + linux kernel = arch linux\
you can omit [linux-firmware](https://archlinux.org/packages/core/any/linux-firmware/) if you install arch linux on `VirtualBox`\
you can omit [networkmanager](https://archlinux.org/packages/extra/x86_64/networkmanager/) if you only use `systemd [ o < ]` to configure network\
[amd-ucode](https://archlinux.org/packages/core/any/amd-ucode/) provides `AMD microcode`. instead use [intel-ucode](https://archlinux.org/packages/extra/any/intel-ucode/) if you use intel chip\
[grub](https://archlinux.org/packages/core/x86_64/grub/) and [efibootmgr](https://archlinux.org/packages/core/x86_64/efibootmgr/) for installing Bootloader later
- - - -
- generate [fstab](https://wiki.archlinux.org/title/fstab) file
```c
        genfstab -U /mnt/ >> /mnt/etc/fstab
```
- install Bootloader
```c
        arch-chroot /mnt/
```
```c
        mount --mkdir /dev/sda1 /boot/efi/
        grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi/
        grub-mkconfig -o /boot/grub/grub/cfg
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
```bash
net.core.netdev_max_backlog=16384
net.core.somaxconn=8192
net.core.default_qdisc=cake
net.ipv4.ip_local_port_range=30000 65535
net.ipv4.udp_rmem_min=8192
net.ipv4.udp_wmem_min=8192
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
- set hostname
```c
        echo "your_new_hostname" > /etc/hostname
```
- create unpriviliged user
```c
        useradd -m user_name
        passwd user_name
```
- trim for SSD
```c
        systemctl enable fstrim.timer
```
- abandon core dump
```c
        kernel.core_pattern=/dev/null"
```
add above contents to your `/etc/sysctl.d/99-sysctl.conf` file; then
```c
        sysctl -p /etc/sysctl.d/99-sysctl.conf
```
- improve Virtual Memory performance
```bash
        vm.dirty_background_ratio=16
        vm.dirty_ratio=32
        vm.vfs_cache_pressure=32
```
add above contents to your `/etc/sysctl.d/99-sysctl.conf` file; then
```c
        sysctl -p /etc/sysctl.d/99-sysctl.conf
```
- generate [top](https://en.wikipedia.org/wiki/Top_(software)) command config file
```py
        top # open top task manager first
```
- use mouse in console
```c
        systemctl enable gpm
        systemctl start gpm
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
- set console font
```py
        ls /usr/share/kbd/consolefonts          # print available bitmap font files
        setfont font_name                       # test font temporary
        echo "font_name" >> /etc/vconsole.conf  # set font persistenct
```
- - - -
`pacman -Syu terminus-font` to install [terminus console font](https://terminus-font.sourceforge.net/)
- - - -
- irqbalance
```
        pacman -Syu irqbalance
        systemctl enable irqbalance
```
- put login ascii art in `/etc/issue`
- - - -
Licence: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
