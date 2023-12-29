# installation step
installation
- step 0: [Make bootable USB and Boot live environment](#Make-bootable-USB-and-Boot-live-environment "goto Make-bootable-USB-and-Boot-live-environment")
- step 1: [connect internet](#connect-internet "goto connect-internet")
- step 2: [Partition, Format and mount the disk](#Partition-Format-and-mount-the-disk "goto Partition-Format-and-mount-the-disk")
- step 3: [install arch linux](#installation "goto install arch linux")
- step 4: [reboot](#reboot "goto reboot")

configuration
# installation
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
- boot your bootable USB you just made and select `*Arch Linux install medium (x86_64, UEFI)` then continue
## .connect internet
- just wire in
## .Partition, Format and mount the disk
- create new partition for drive
    - type `cfdisk` to open TUI partition editor then select `GPT`
    - then create partition on your drive as required as table below

partition name | partition type | partition size | partition purpose
:------------- | :------------- | :------------- | :----------------
/dev/sda1      | EFI system     | `300M` minium  | for install kernel and bootloader
/dev/sda2      | Linux swap     | `512M` minium  | for swaping
/dev/sda3      | Linux root     | rest of drive  | for install Arch

you can make [swap] partition as twice bigger as your total system memory size, use `grep MemTotal /proc/meminfo` to check your total memory size

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
        pacstrap -K /mnt/ base linux-zen linux-firmware networkmanager grub efibootmgr
```
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
## .reboot
- set root password
```c
        passwd
```
- reboot
```
        exit
        reboot
```

# configuration
