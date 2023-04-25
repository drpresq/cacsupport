#!/bin/bash

function install_prereq {
	sudo apt-get install pcscd libccid libpcsclite-dev libssl-dev libreadline-dev autoconf automake build-essential docbook-xsl xsltproc libtool pkg-config zlib1g-dev libnss3-tools libpam-pkcs11 --assume-yes
}

function build_opensc {
	cd $HOME/Downloads
	wget https://github.com/OpenSC/OpenSC/releases/download/0.23.0/opensc-0.23.0.tar.gz
	tar xfvz opensc-*.tar.gz
	rm opensc-*.tar.gz
	cd $HOME/Downloads/opensc-*
	./bootstrap
	./configure --prefix=/usr --sysconfdir=/etc/opensc
	make
	sudo make install
}

function clean_opensc {
	cd $HOME
	rm -rf $HOME/Downloads/opensc-*
}

echo -e "\n\nInstalling Prerequisites\n"
install_prereq

echo -e "\n\nBuilding and Installing OpenSC\n"
build_opensc

echo -e "\n\nCleaning Up OpenSC installation Files\n"
clean_opensc



