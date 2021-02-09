#!/bin/bash

function pam_certs {
	cd $HOME/Downloads
	wget https://militarycac.com/maccerts/AllCerts.zip
	mkdir dodCerts
	sudo unzip AllCerts.zip -d /etc/pam_pkcs11/cacerts
	cd dodCerts
}

function pam_config {
	cd /etc/pam_pkcs11/
	sudo wget https://github.com/OpenSC/pam_pkcs11/blob/master/etc/pam_pkcs11.conf.example.in
	sudo mv pam_pkcs11.conf.example.in pam_pkcs11.conf
}


echo -e "\n\nAdding Certificates to PAM\n"
pam_certs
pam_config

echo -e "\n\nDONE!!\n"
