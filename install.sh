#!/usr/bin/env bash

set -e

archpkgs='arm-none-eabi-toolchain'
pkgs='git base-devel'
pacman -Syu $pkgs $(echo "$archpkgs" | sed 's/[^ ]*/mingw-w64-x86_64-&/g') --noconfirm

git config --global url."https://".insteadOf git://

for i in g0 f0; do
	git clone https://aur.archlinux.org/stm32$i-headers-git.git
	cd stm32$i-headers-git
	makepkg -sri --noconfirm
	cd ..
done

cd openocd
export MINGW_ARCH=mingw64
makepkg-mingw -sri --noconfirm
