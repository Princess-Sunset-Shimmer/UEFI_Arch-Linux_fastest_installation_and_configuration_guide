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
- boot your bootable USB you just made then select `*Arch Linux install medium (x86_64, UEFI)` and continue
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
you can omit [networkmanager](https://archlinux.org/packages/extra/x86_64/networkmanager/) if you only use `systemd [ o < ]` to configure ethernet\
[amd-ucode](https://archlinux.org/packages/core/any/amd-ucode/) enable `AMD microcode` updates. instead use [intel-ucode](https://archlinux.org/packages/extra/any/intel-ucode/) if you use intel chip\
[grub](https://archlinux.org/packages/core/x86_64/grub/) and [efibootmgr](https://archlinux.org/packages/core/x86_64/efibootmgr/) for installing Bootloader later
- - - -
- generate [fstab](https://wiki.archlinux.org/title/fstab) file
```c
        genfstab -U //mnt/ >> /mnt/etc/fstab
```
- install bootloader
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
- trim for SSD
```c
        systemctl enable fstrim.timer
```
- abandon core dump
```c
        echo kernel.core_pattern=/dev/null >> /etc/sysctl.d/50-coredump.conf
        sysctl -p /etc/sysctl.d/50-coredump.conf
```
- networkmanager
```
        systemctl enable NetworkManager
        systemctl restart NetworkManager
        nmtui
```
- create unpriviliged user
```c
        useradd -m user_name
        passwd user_name
```
- irqbalance
```
        pacman -Syu irqbalance
        systemctl enable irqbalance
```
- general purpose mouse
```c
        pacman -Syu gpm
        systemctl enable gpm
```
- put login ascii art in `/etc/issue`
- - - -
Licence: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
