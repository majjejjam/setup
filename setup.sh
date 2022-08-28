#!/bin/sh

# Install pacman packages
echo 'Installing paru and previous packages'
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git && cd paru
makepkg -si
cd ..
sudo paru -S --needed - < pkglist.txt

# Install flatpaks
echo 'Installing flatpaks'
flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
xargs flatpak install -y < flatpaks.txt

# Firefox Gnome Theme
echo 'Adding firefox gnome theme'
git clone https://github.com/rafaelmardojai/firefox-gnome-theme && cd firefox-gnome-theme
./scripts/auto-install.sh
cd ..

echo 'Add yourself ILoveCandy, uncomment Color and ParalellDownloads = 5 to /etc/pacman.conf'

# Change shell to zsh
echo 'Changing shell to zsh'
chsh -s /bin/zsh

# Load dconf settings
dconf load / < saved_settings.dconf

# configs
echo 'Adding configs'
echo 'dotfiles…'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare git@github.com:majjejjam/dotfiles.git $HOME/.dotfiles
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout

echo 'keyd…'
cp default.conf /etc/keyd/default.conf

echo 'dark=headers…'
git clone https://github.com/catvitalio/dark-headers && cd dark-headers
chmod +x install.sh
./install.sh
systemctl --user enable --now dark-headers.service
cd ..
