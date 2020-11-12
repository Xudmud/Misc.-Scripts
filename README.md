# Misc.-Scripts
## Random shell and Python scripts
These are random scripts I've written that don't belong to any particular project. They're mostly used for automation on my Linux machine, mostly for utility or to address specific problems.

``updates.bash``  
Since I'm running Arch, I have a number of packages that came from the Arch User Repository as well as other locations (e.g. TeXlive, snap, etc.). This script lets me run all necessary updaters at once, instead of having to run each command separately. In addition, it automates mounting the EFI partition during the updates, in case a firmware or kernel update is needed, to ensure everything gets updated appropriately as needed.

Eventually I plan to add dotfiles to this as well, so if I need a reinstall I can easily redownload them.

``fix-boot-menu.bash``
I've had it happen multiple times where I've left a hard drive clone connected to my PC, only to have the computer load the EFI bootloader off of that HDD, which overwrites the OS options on the main hard drive. My files are all still there, but the computer doesn't have the necessary boot files anymore to boot the OS. This script, meant to be run in a live boot (preferably while chroot'ed to the Linux install's root account) re-adds the missing boot entry to the EFI partition, and rebuilds grub for good measure. It's still required to manually shift the newly added entry where it's needed, but this should allow the OS to once again boot.