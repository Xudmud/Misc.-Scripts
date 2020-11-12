#!/usr/bin/env bash
# This script is specific to my system, but I'm putting it up as a code snippet.
echo "-------------------"
#Uncomment the one you need for your package manager

#dnf
#sudo dnf upgrade

#Figure out the zypper equivalent.

#Use this for apt
#sudo apt update
#echo "-------------------"
#sudo apt dist-upgrade

#pacman
# MOUNT THE EFI PARTITION! So the boot files write properly.
sudo mount /dev/sda1 /efi
sudo pacman -Syyu

#AUR-specific commands
#Replace the directory with the directory your AUR packages live in.
AURDIR=~/AUR
#cd into each directory, do a git pull, rebuild if necessary.
echo "--------------------"
echo "Updating AUR packages..."
cd $AURDIR
for D in `find . -maxdepth 1 -type d`
do
    if [ $D != '.' ] && [ $D != '..' ]
    then
        cd $D
        echo $D
        # Do a fetch.
        git fetch
        # Check if a merge/rebuild is needed by comparing heads
        HEADHASH=$(git rev-parse HEAD)
        UPSTREAMHASH=$(git rev-parse master@{upstream})
        if [ "$HEADHASH" != "$UPSTREAMHASH" ]
        then
            # Merge and rebuild
            git merge
            makepkg -si
            # Return to the main AUR directory
            cd ..
        else
            echo "Up to date"
            cd ..
        fi
    fi
done

# Unmount the EFI partition, we're done with it.
sudo umount /efi

#Snap refresh
#echo "-------------------"
#sudo snap refresh

#TeXLive updater. Start with updating the updater.
echo "-------------------"
sudo tlmgr update --self
#Then look for package updates.
echo "-------------------"
sudo tlmgr update -all

#Finish message
echo "Done. Reboot if necessary."
