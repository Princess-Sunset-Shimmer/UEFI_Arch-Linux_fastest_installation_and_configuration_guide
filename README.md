# installation step
installation
- step 0: [Make bootable USB and Boot live environment](#Make-bootable-USB-and-Boot-live-environment "goto Make-bootable-USB-and-Boot-live-environment")
- step 1: [connect internet](#connect-internet "goto connect-internet")
- step 2: [Partition, Format and mount the disk](#Partition,-Format-and-mount-the-disk "goto Partition,-Format-and-mount-the-disk")
- step 3: [install arch linux](#installation "goto install arch linux")
- step 4: [reboot](#reboot "goto reboot")

configuration
# installation
## Make bootable USB and Boot live environment
1. goto [official download page](https://archlinux.org/download/) to download iso file
2. check file SHA256
```asm
        sha256sum /directory/archlinux.iso
```
3. use either GUI utility like `rufus` and `etcher` or use CLI `dd` to write your image file to your USB flash drive
```asm
        dd if=/directory/archlinux.iso of=/dev/usb_flash_drive_file_name status=progress
```
4. boot your bootable USB flash drive you just made and select `*Arch Linux install medium (x86_64, UEFI)` then continue
## connect insternet
just wire in
## Partition, Format and mount the disk

## install arch linux
## reboot
# configuration
