# Misc.-Scripts
## Random shell and Python scripts
These are random scripts I've written that don't belong to any particular project. They're mostly used for automation on my Linux machine, for utility or to address specific problems.

``updates.bash``  
Since I'm running Arch, I have a number of packages that came from the Arch User Repository as well as other locations (e.g. TeXlive, snap, etc.). This script lets me run all necessary updaters at once, instead of having to run each command separately. In addition, it automates mounting the EFI partition during the updates, in case a firmware or kernel update is needed, to ensure everything gets updated appropriately as needed.

``fix-boot-menu.bash``  
I've had it happen multiple times where I've left a hard drive clone connected to my PC, only to have the computer load the EFI bootloader off of that HDD, which overwrites the OS options on the main hard drive. My files are all still there, but the computer doesn't have the necessary boot files anymore to boot the OS. This script, meant to be run in a live boot (preferably while chroot'ed to the Linux install's root account) re-adds the missing boot entry to the EFI partition, and rebuilds grub for good measure. It's still required to manually shift the newly added entry where it's needed, but this should allow the OS to once again boot.

``dupedetector.py``  
I wrote this script mainly as a way to cut down on duplicate images in various folders. Often I'll find that I have the exact same image stored more than once with different filenames, and this at least lets me find duplicates of various images and files. It works in two parts: First it computes the SHA-256 checksum of all files in the folder I'm scanning, and prints out the instances where more than one file has the same checksum. I can use this to quickly remove exact duplicates of various files. Using file checksums, this can be extended to be used in virtually any folder to detect where the same file might be saved more than once.  
The second part is a bit more prone to false positives, but works well for the most part. I mainly have this second part for situations where I've saved the same image, but one version is a .jpg preview while the other is the original-quality .png. This largely depends on the base filename matching, and as a result doesn't catch everything.  
I'd like to work this script out more to analyze file data (like image pixel information) to detect possible duplicates, even if the files have completely different names.

Eventually I plan to add dotfiles to this as well, so if I need a reinstall I can easily redownload them.