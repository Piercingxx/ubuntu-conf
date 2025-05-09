#!/bin/bash

# Checks for active network connection
if [[ -n "$(command -v nmcli)" && "$(nmcli -t -f STATE g)" != connected ]]; then
  awk '{print}' <<<"Network connectivity is required to continue."
  exit
fi


username=$(id -u -n 1000)
builddir=$(pwd)

sudo apt update && upgrade -y
wait

mkdir -p /home/"$username"/Pictures/backgrounds
cp ~/dotconf/bg.jpg /home/"$username"/Pictures/backgrounds
chown -R "$username":"$username" /home/"$username"/Pictures/backgrounds
cp -R dotconf/kitty /home/"$username"/.config/
chown -R "$username":"$username" /home/"$username"/.config/kitty


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
flatpak install flathub net.waterfox.waterfox -y
flatpak install flathub md.obsidian.Obsidian -y
flatpak install https://flathub.org/beta-repo/appstream/org.gimp.GIMP.flatpakref -y
flatpak install flathub org.darktable.Darktable -y
flatpak install flathub com.mattjakeman.ExtensionManager -y
flatpak install flathub org.qbittorrent.qBittorrent -y
flatpak install flathub io.missioncenter.MissionCenter -y
flatpak install flathub org.gnome.SimpleScan -y
flatpak install flathub com.tomjwatson.Emote -y
flatpak install flathub org.kde.kdenlive -y
flatpak install flathub io.github.realmazharhussain.GdmSettings -y


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

# Synology Chat
wget "https://global.synologydownload.com/download/Utility/ChatClient/1.2.2-0222/Ubuntu/x86_64/Synology%20Chat%20Client-1.2.2-0222.deb"
wait
sudo dpkg --force-all -i Synology%20Chat%20Client-1.2.2-0222.deb
wait


echo "Installing Fonts"
sleep 2
# Installing fonts
cd "$builddir" || exit
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
chmod -R 777 FiraCode.zip
unzip FiraCode.zip -d /home/"$username"/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
chmod -R 777 Meslo.zip
unzip Meslo.zip -d /home/"$username"/.fonts
mv dotfonts/fontawesome/otfs/*.otf /home/"$username"/.fonts/
chown -R "$username":"$username" /home/"$username"/.fonts
apt install fonts-font-awesome fonts-noto-color-emoji -y
apt install ttf-mscorefonts-installer -y
apt install fonts-terminus -y
# Removing zip files and stuff
rm -rf FiraCode.zip
rm -rf Meslo.zip


# Reloading Font
fc-cache -vf
wait


# Extensions
echo "Gnome Extensions"
sleep 2
apt install gnome-shell-extension-appindicator -y
apt install gnome-shell-extension-gsconnect -y
apt install gnome-shell-extension-caffeine -y
# App Icons Taskbar
# Awesome Tiles
# Worthless Gaps
# Just Perfection
# Blur My Shell



#Nautilus Customization
apt install gnome-sushi -y
apt install imagemagick nautilus-image-converter -y
apt install nautilus-admin -y
apt install gir1.2-gtk-4.0 -y
git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git
cd nautilus-open-any-terminal || exit
make
sudo make install schema
glib-compile-schemas /usr/share/glib-2.0/schemas
cd "$builddir" || exit
rm -rf nautilus-open-any-terminal




sudo apt update && upgrade -y
wait
apt full-upgrade -y
wait
apt install -f
wait
dpkg --configure -a
apt install --fix-broken
wait
apt autoremove -y
sudo apt update && upgrade -y
wait
flatpak update -y



# # Synology Chat
# wget "https://global.synologydownload.com/download/Utility/ChatClient/1.2.2-0222/Ubuntu/x86_64/Synology%20Chat%20Client-1.2.2-0222.deb"
# wait
# sudo dpkg --force-all -i Synology\ Chat\ Client-1.2.2-0222.deb
# wait
# sudo mv /opt/Synology\ Chat /opt/SynologyChat
# sudo rm /etc/alternatives/synochat
# sudo ln -s /opt/SynologyChat/synochat /etc/alternatives/synochat
# sudo rm /usr/share/applications/synochat.desktop
# sudo touch /usr/share/applications/synochat.desktop
# sudo printf "[Desktop Entry]
# Name=Synology Chat
# Exec="/opt/SynologyChat/synochat" %%U
# Terminal=false
# Type=Application
# Icon=synochat
# StartupWMClass=SynologyChat
# Comment=Synology Chat Desktop Client
# Categories=Utility;" | sudo tee -a /usr/share/applications/synochat.desktop
# synochat


