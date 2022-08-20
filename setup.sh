#!/bin/sh

# Install packages
echo "Installing paru and previous packages"
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
sudo pacman -S --needed - < pkglist.txt

# Keyd
echo "Adding configs"
cp default.conf /etc/keyd/default.conf

# Firefox Gnome Theme
echo "Adding firefox gnome theme"
git clone https://github.com/rafaelmardojai/firefox-gnome-theme && cd firefox-gnome-theme
git checkout beta
./scripts/auto-install.sh
cd ..

echo "Add ILoveCandy, uncomment Color and ParalellDownloads = 5 to /etc/pacman.conf"

# Change shell to zsh
echo "Changing shell to zsh"
chsh -s /bin/zsh
