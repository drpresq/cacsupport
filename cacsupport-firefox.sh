#!/bin/bash


function install_prereq {
	sudo apt-get install pcscd libccid libpcsclite-dev libssl-dev libreadline-dev autoconf automake build-essential docbook-xsl xsltproc libtool pkg-config zlib1g-dev libnss3-tools --assume-yes
}

function build_opensc {
	cd $HOME/Downloads
	wget https://github.com/OpenSC/OpenSC/releases/download/0.21.0/opensc-0.21.0.tar.gz
	tar xfvz opensc-*.tar.gz
	cd $(find $HOME/Downloads -type d -iname opensc*)
	./bootstrap
	./configure --prefix=/usr --sysconfdir=/etc/opensc
	make
	sudo make install
}

function firefox_certs {
	cd $HOME/Downloads
	wget https://militarycac.com/maccerts/AllCerts.zip
	mkdir dodCerts
	unzip AllCerts.zip -d ./dodCerts
	cd dodCerts
	for value in $HOME/Downloads/dodCerts/*; do s=${value##*/}; certutil -A -i "$value" -n "${s%.cer} - U.S. Government" -t"CT,C" -d $(find $HOME/.mozilla/firefox -iname *.default-release); done
}

echo "\n\n1. Building OpenSC from source\n"
install_prereq
build_opensc

echo -e "\n\n2. Adding the OpenSC module to FireFox\n"
modutil -dbdir $(find $HOME/.mozilla/firefox/ -iname *.default-release) -add 'OpenSC' -libfile $(find /lib/pkcs11 -iname opensc-pkcs11.so)

echo -e "\n\n3. Adding Certificates to FireFox\n"
firefox_certs

echo -e "\n\n4. PROFIT!!\n"

