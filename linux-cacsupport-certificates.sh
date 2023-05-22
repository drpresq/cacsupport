#!/bin/bash

function get_certs {
	cd $HOME/Downloads
	wget https://militarycac.com/maccerts/AllCerts.zip
	mkdir dodCerts
	unzip AllCerts.zip -d ./dodCerts
}


function install_certs_firefox {
	for value in $HOME/Downloads/dodCerts/*; do s=${value##*/}; certutil -A -i "$value" -n "${s%.cer} - U.S. Government" -t"CT,C" -d $(find $HOME/.mozilla/firefox -iname *.default-release); done
}

function install_certs_nssdb {
	for value in $HOME/Downloads/dodCerts/*; do s=${value##*/}; certutil -A -i "$value" -n "${s%.cer} - U.S. Government" -t"CT,C" -d sql:$HOME/.pki/nssdb/; done
}

echo -e "\n\nDownloading DoD Certificates\n"
get_certs

echo -e "\n\nInstalling Certificates to Firefox Database\n"
install_certs_firefox

echo -e "\n\nInstalling Certificates to NSS Database\n"
install_certs_nssdb

echo -e "\n\nDONE!!\n"
