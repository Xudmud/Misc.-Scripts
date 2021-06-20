#!/usr/bin/env bash
# This script is specific to my system and needs, 
echo "-------------------"
# Uncomment the one you need for your package manager

# dnf
#sudo dnf upgrade

# Figure out the zypper equivalent.
#sudo zypper up

# apt
#sudo apt update
#echo "-------------------"
#sudo apt dist-upgrade

# pacman
# MOUNT THE EFI PARTITION! So the boot files write properly.
sudo mount /dev/sda1 /efi
sudo pacman -Syu

# Set the start directory to where the command was invoked.
STARTDIR=$PWD

# AUR-specific commands
# Replace the directory with the directory your AUR packages live in.
AURDIR=~/AUR
# cd into each AUR directory, do a git pull, rebuild if necessary.
echo "--------------------"
echo "Updating AUR packages..."
cd $AURDIR
for D in $(find . -maxdepth 1 -type d)
do
    if [ "$D" != "." ] && [ "$D" != ".." ] && [ "$D" != "./IGNORE" ]
    then
        (
            cd "$D"
            echo "$D"
            # Do a fetch.
            git fetch
            # Check if a merge/rebuild is needed by comparing heads
            HEADHASH=$(git rev-parse HEAD)
            UPSTREAMHASH=$(git rev-parse master@{upstream})
            if [ "$HEADHASH" != "$UPSTREAMHASH" ]
            then
                # Merge and rebuild
                git merge
                # TODO: Tweak to work with split packages.
                if [ "$PWD" == "/home/xudmud/AUR/discord-rpc-api" ]
                then
                    # discord-rpc-api generates two packages: discord-rpc-api and discord-rpc-api-static.
                    # Only one of these can be installed at once, so the user needs to manually install one.
                    # Just generate the packages but don't install anything.
                    makepkg -s
                    echo "discord-rpc-api requires update. Manually run pacman -U."
                else
                    makepkg -si
                fi
            # OpenRCT2 has build updates that don't necessarily affect the AUR package. Always try to update.
            elif [ "$PWD" == "/home/xudmud/AUR/openrct2-git" ]
            then
                git merge
                makepkg -si
            else
                echo "Up to date"
            fi
        )
    fi
done

# Go back to the start directory.
cd "$STARTDIR"

# Unmount the EFI partition, we're done with it.
sudo umount /efi

# Update ClamAV definitions
echo "-------------------"
sudo freshclam

# Snap refresh
#echo "-------------------"
#sudo snap refresh

# TeXLive updater. Start with updating the updater.
echo "-------------------"
sudo tlmgr update --self
# Then look for package updates.
echo "-------------------"
sudo tlmgr update -all

echo "-------------------"
# Reboot should only be necessary if there was a kernel update.
# Check if there was one.
CURVER=$(uname -r)
PACVER=$(pacman -Q linux | awk '{print $2}')

# Output the results from uname -r and pacman -Q linux.
echo "Kernel versions reported:"
echo "uname:  $CURVER"
echo "pacman: $PACVER"
echo "If the versions are different, please reboot!"

# uname -r and pacman -Q linux have slightly different outputs.
# TODO: Compare just the numeric version numbers. At worst, has to be done visually.
#if [ $CURVER == $PACVER ]
#then
#    # If no kernel update, just print done.
#    echo "Done!"
#else
#    # If there was a kernel update, prompt the user to reboot.
#    printf "Done! \033[0;31mKernel updated, please reboot.\n\033[00m"
#fi
echo "Done!"
