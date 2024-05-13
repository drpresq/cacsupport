#!/bin/bash

VERSION="0.23.0"
MIDDLEWARE="OpenSC"

QUIET="/dev/null"
YELLOW_FORE="\033[33m"
YELLOW_BACK="\033[43m"


###
#	Work Functions
###

function install_prereq {
	sudo apt-get install pcscd libccid libpcsclite-dev libssl-dev libreadline-dev autoconf automake build-essential docbook-xsl xsltproc libtool pkg-config zlib1g-dev libnss3-tools libpam-pkcs11 --assume-yes > $QUIET 2>&1
}

function build_opensc {
	cd "$HOME"/Downloads || exit
	wget https://github.com/OpenSC/OpenSC/releases/download/$VERSION/opensc-$VERSION.tar.gz > $QUIET 2>&1
	tar xfvz opensc-$VERSION.tar.gz > $QUIET 2>&1
	rm opensc-$VERSION.tar.gz
	cd "$HOME"/Downloads/opensc-$VERSION || exit
	./bootstrap > $QUIET 2>&1
	./configure --prefix=/usr --sysconfdir=/etc/opensc > $QUIET 2>&1
	make > $QUIET 2>&1
	sudo make install > $QUIET 2>&1
}

function clean_opensc {
	rm -rf "$HOME"/Downloads/opensc-*
}

function print_message {
	ENDCOLOR="\033[0m"
	YELLOW_BACK="\033[1;43m"/home/user
	YELLOW_FORE="\033[1;33m"
	SMARTCARD_MSG="\n\n${YELLOW_BACK} Smartcard Middleware ($MIDDLEWARE $VERSION)${ENDCOLOR} - \t ${YELLOW_FORE}$1${ENDCOLOR}\n"
	echo -e "$SMARTCARD_MSG"
}

###
#	Main
###

print_message "Installing Prerequisites"
install_prereq

print_message "Building and installing from source"
build_opensc

print_message "Cleaning up installation files"
clean_opensc

print_message "Adding device to Firefox security database"
modutil -dbdir "$(find "$HOME"/.mozilla/firefox/ -iname '*.default-release')" -add "\"$MIDDLEWARE $VERSION\"" -libfile "$(find /lib/ -type f -name opensc-pkcs11.so)"

print_message "Adding device to default PKI security database"
modutil -dbdir sql:"$HOME"/.pki/nssdb/ -add "\"$MIDDLEWARE $VERSION\"" -libfile "$(find /lib/ -type f -name opensc-pkcs11.so)"

print_message "Installation Complete! - You are now ready to use a PIV II Smartcard"

