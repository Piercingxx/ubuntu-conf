#!/bin/bash

# https://github.com/Piercing666


sudo add-apt-repository universe 
sudo apt update 
sudo apt install hyprland -y
sudo apt install xdg-desktop-portal-wlr -y

sudo apt install -y meson wget build-essential ninja-build cmake-extras cmake gettext gettext-base fontconfig 
sudo apt install -y libfontconfig-dev libffi-dev libxml2-dev libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev 
sudo apt install -y libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools 
sudo apt install -y libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev 
sudo apt install -y libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev libxcb-xinput-dev libtomlplusplus3


# wayland
git clone https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.23.0/downloads/wayland-1.23.0.tar.xz
tar -xf wayland-1.23.0.tar.xz
cd wayland-1.23.0
mkdir build &&
cd    build &&

meson setup ..            \
      --prefix=/usr       \
      --buildtype=release \
      -D documentation=false &&
ninja
sudo ninja install


# wayland-protocols
git clone https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/1.38/downloads/wayland-protocols-1.38.tar.xz
tar -xf wayland-protocols-1.38.tar.xz
cd wayland-protocols-1.38
mkdir build &&
cd    build &&

meson setup --prefix=/usr --buildtype=release &&
ninja
sudo ninja install


# libdisplay-info
git clone https://gitlab.freedesktop.org/emersion/libdisplay-info.git
cd libdisplay-info
mkdir build &&
cd    build &&
meson setup build/
ninja -C build/



# Build xdg-desktop-portal-hyprland from source
git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland
cd xdg-desktop-portal-hyprland/
cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build
sudo cmake --install build



# Other needs apps
apt-get install hyprshot -y


yay -S rofi --noconfirm



yay -S wtype-git --noconfirm


# hyprpaper
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprpaper -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
cmake --install ./build

# hyprlock
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build


# wlogout
git clone https://github.com/ArtsyMacaw/wlogout.git
cd wlogout
meson build
ninja -C build
sudo ninja -C build install



# Waybar Dependencies
apt install clang-tidy -y
apt install gobject-introspection -y
apt install libdbusmenu-gtk3-dev -y
apt install libevdev-dev -y
apt install libfmt-dev -y
apt install libgirepository1.0-dev -y
apt install libgtk-3-dev -y
apt install libgtkmm-3.0-dev -y
apt install libinput-dev -y
apt install libjsoncpp-dev -y
apt install libmpdclient-dev -y
apt install libnl-3-dev -y
apt install libnl-genl-3-dev -y
apt install libpulse-dev -y
apt install libsigc++-2.0-dev -y
apt install libspdlog-dev -y
apt install libwayland-dev -y
apt install scdoc -y
apt install upower -y
apt install libxkbregistry-dev -y
# Waybar
git clone https://github.com/Alexays/Waybar
cd Waybar
meson setup build
ninja -C build
./build/waybar
ninja -C build install
waybar



# Grip up dots from my Arch Hyprland Git
git clone https://github.com/Piercingxx/Hyprland-Waybar
chmod -R u+x Hyprland-Waybar
mv Hyprland-Waybar/dots/* ~/.config/
rm -Rf Hyprland-Waybar


