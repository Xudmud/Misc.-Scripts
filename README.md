# Misc.-Scripts
## Random shell and Python scripts
These are random scripts I've written that don't belong to any particular project. They're mostly used for automation on my Linux machine, with a few being for utility or to address specific problems.

``updates.bash``  
Since I'm running Arch, I have a number of packages that came from the Arch User Repository as well as other locations (e.g. TeXlive, snap, etc.). This script lets me run all necessary updaters at once, instead of having to run each command separately. In addition, it automates mounting the EFI partition during the updates, in case a firmware or kernel update is needed, to ensure everything gets updated appropriately as needed.

Eventually I plan to add dotfiles to this as well, so if I need a reinstall I can easily redownload them.
