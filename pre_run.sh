#!/bin/sh

if [[ $EUID > 0 ]]; then
  printf "\e[1;31mPlease run as root/sudo\e[0m\n"
  exit 1
fi

pip_debs (){
pip3.6 install datetime
pip3.6 install asyncio
pip3.6 install requests
pip3.6 install discord.py
pip3.6 install aiohttp
}

debian () {
apt update
apt-get install tar -y
apt-get install openssl -y || apt-get install openssl-dev -y
apt-get install libssl -y || apt-get install libssl-dev -y
apt-get install zlib1g || apt-get install zlib1g-dev
apt-get install wget -y
apt-get install curl -y
apt-get install zip -y
apt-get install unicode -y
apt-get install ttf-ancient -y; apt-get install ttf-ancient-fonts; apt-get install fonts-noto
apt-get install make -y
apt-get install gcc -y
curl -# -o Python-3.6.7.tgz  https://www.python.org/ftp/python/3.6.7/Python-3.6.7.tgz
tar xf Python-3.6.7.tgz
cd Python-3.6.7/
./configure
make -j 4
make altinstall
pip_debs
}

archlinux () {
pacman -Syy
pacman -S tar --noconfirm
pacman -S zlib --noconfirm
pacman -S openssl --noconfirm
pacman -S make --noconfirm
pacman -S gcc --noconfirm
pacman -S wget --noconfirm
pacman -S curl --noconfirm
pacman -S zip --noconfirm
pacman -S noto-fonts noto-fonts-extra font-bh-ttf gnu-free-fonts ttf-carlito ttf-junicode  --noconfirm
pacman -S noto-fonts-emoji ttf-joypixels unicode-emoji --noconfirm
curl -# -o Python-3.6.7.tgz  https://www.python.org/ftp/python/3.6.7/Python-3.6.7.tgz
tar xf Python-3.6.7.tgz
cd Python-3.6.7/
./configure
make -j 4
make altinstall
pip_debs
}

centos () {
yum update
yum install tar -y
yum install zlib || yum install zlib-devel
yum install openssl -y || yum install openssl-devel -y
yum install make gcc wget curl zip -y
curl -# -o Python-3.6.7.tgz  https://www.python.org/ftp/python/3.6.7/Python-3.6.7.tgz
tar xf Python-3.6.7.tgz
cd Python-3.6.7/
./configure
make -j 4
make altinstall
pip_debs
}

printf "\e[1;32mplease select a option\e[0m
\e[1;33mdebian | deb\e[0m
\e[1;34marchlinux | arch\e[0m
\e[1;35mcentos| fedora | rhel\e[0m\n"

read unixVersion
case $unixVersion in
debian | deb)
debian;;
arch | archlinux)
archlinux;;
centos | Centos | fedora | rhel)
centos;;
*)
printf "\e[1;31mUnknown\e[0m\n" ;;
esac
