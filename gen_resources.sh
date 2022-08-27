# flatpak list
flatpak list --columns=application --app > flatpaks.txt

# pacman list
pacman -Qqet > pkglist.txt

# dconf
dconf dump / > saved_settings.dconf
