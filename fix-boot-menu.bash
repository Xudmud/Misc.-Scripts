#!/usr/bin/env bash
# Quick script to reinstall grub, in case the EFI menu gets overwritten.
# ONLY RUN THIS IN A LIVE BOOT AS CHROOT
ESP=/efi

# First mount the EFI partition
mount /dev/sda1 $ESP

# Next install grub
grub-install --target=x86_64-efi --efi=directory=$ESP --bootloader-id=arch

# Now run the config.
grub-mkconfig -o /boot/grub/grub.cfg

# Should be all that's needed.
echo "Done! Don't forget to adjust the EFI boot order in BIOS!"