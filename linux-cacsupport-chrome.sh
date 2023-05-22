function default_certs {
	cd $HOME/Downloads
	wget https://militarycac.com/maccerts/AllCerts.zip
	mkdir dodCerts
	unzip AllCerts.zip -d ./dodCerts
	cd dodCerts
	for value in $HOME/Downloads/dodCerts/*; do s=${value##*/}; certutil -A -i "$value" -n "${s%.cer} - U.S. Government" -t"CT,C" -d sql:$HOME/.pki/nssdb ; done
}

echo -e "\n\nAdding the DoD Root Certificates to default PKI Database\n"
default_certs

echo -e "\n\nAdding the OpenSC Module to default PKI Database\n"
modutil -dbdir sql:$HOME/.pki/nssdb/ -add "token_name" -libfile /usr/lib/opensc-pkcs11.so

echo -e "\n\nDONE!!\n"
