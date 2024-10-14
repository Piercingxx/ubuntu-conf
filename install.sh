#!/bin/bash

# Checks for active network connection
if [[ -n "$(command -v nmcli)" && "$(nmcli -t -f STATE g)" != connected ]]; then
  awk '{print}' <<<"Network connectivity is required to continue."
  exit
fi


apt install wget gpg flatpak gnome-software-plugin-flatpak -y
flatpak remote-add flathub https://dl.flathub.org/repo/flathub.flatpakrepo
apt update && upgrade -y
wait
apt full-upgrade -y
wait
sudo apt install -f
wait
flatpak update


apt install kitty -y
apt install dconf* -y
apt install pipx -y
apt install gnome-tweaks -y
apt install gnome-shell-extension-manager -y
apt install papirus-icon-theme -y

sleep 2

flatpak install flathub md.obsidian.Obsidian -y
flatpak install flathub com.dropbox.Client -y
flatpak install https://flathub.org/beta-repo/appstream/org.gimp.GIMP.flatpakref -y

# Install Gnome-extensions-cli
pipx install gnome-extensions-cli --system-site-packages


# VSCode
wget "https://vscode.download.prss.microsoft.com/dbazure/download/stable/e170252f762678dec6ca2cc69aba1570769a5d39/code_1.88.1-1712771838_amd64.deb"
wait
dpkg -i code_1.88.1-1712771838_amd64.deb
wait
rm code_1.88.1-1712771838_amd64.deb

# Synology Drive
wget "https://global.download.synology.com/download/Utility/SynologyDriveClient/3.4.0-15724/Ubuntu/Installer/synology-drive-client-15724.x86_64.deb"
wait
sudo dpkg -i synology-drive-client-15724.x86_64.deb
wait

# Gimp dotfiles
rm -rf /home/"$username"/.var/app/org.gimp.GIMP/config/GIMP/*
######################finish later

# More Fonts
mkdir -p $HOME/.fonts
cd $HOME/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip
rm Firacode.zip
rm Meslo.zip


# Cursors
wget -cO- https://github.com/phisch/phinger-cursors/releases/latest/download/phinger-cursors-variants.tar.bz2 | tar xfj - -C ~/.icons
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors || exit
./install.sh
cd "$builddir" || exit
rm -rf Nordzy-cursors



# Extensions
echo "Gnome Extensions"
sleep 2
apt install gnome-shell-extension-appindicator -y
apt install gnome-shell-extension-gsconnect -y
apt install gnome-shell-extension-caffeine -y

####***************KNOWN ISSUE***************####
###These extensions are not installing with the script at the moment, install manually###
# App Icons Taskbar
sudo -u "$username" gext install aztaskbar@aztaskbar.gitlab.com
# Awesome Tiles
sudo -u "$username" gext install awesome-tiles@velitasali.com
# Blur My Shell
sudo -u "$username" gext install blur-my-shell@aunetx
# Just Perfection
sudo -u "$username" gext install just-perfection-desktop@just-perfection
# Open Bar
sudo -u "$username" gext install openbar@neuromorph



# Synology Chat
wget "https://global.synologydownload.com/download/Utility/ChatClient/1.2.2-0222/Ubuntu/x86_64/Synology%20Chat%20Client-1.2.2-0222.deb"
wait
sudo dpkg --force-all -i Synology\ Chat\ Client-1.2.2-0222.deb
wait
sudo mv /opt/Synology\ Chat /opt/SynologyChat
sudo rm /etc/alternatives/synochat
sudo ln -s /opt/SynologyChat/synochat /etc/alternatives/synochat
sudo rm /usr/share/applications/synochat.desktop
sudo touch /usr/share/applications/synochat.desktop
sudo printf "[Desktop Entry]
Name=Synology Chat
Exec="/opt/SynologyChat/synochat" %%U
Terminal=false
Type=Application
Icon=synochat
StartupWMClass=SynologyChat
Comment=Synology Chat Desktop Client
Categories=Utility;" | sudo tee -a /usr/share/applications/synochat.desktop
synochat


