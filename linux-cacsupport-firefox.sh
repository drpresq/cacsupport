function firefox_certs {
	cd $HOME/Downloads
	wget https://militarycac.com/maccerts/AllCerts.zip
	mkdir dodCerts
	unzip AllCerts.zip -d ./dodCerts
	cd dodCerts
	for value in $HOME/Downloads/dodCerts/*; do s=${value##*/}; certutil -A -i "$value" -n "${s%.cer} - U.S. Government" -t"CT,C" -d $(find $HOME/.mozilla/firefox -iname *.default-release); done
}

echo -e "\n\nAdding the OpenSC module to FireFox\n"
modutil -dbdir $(find $HOME/.mozilla/firefox/ -iname *.default-release) -add 'OpenSC' -libfile $(find /lib/pkcs11 -iname opensc-pkcs11.so)

echo -e "\n\nAdding Certificates to FireFox\n"
firefox_certs

echo -e "\n\nDONE!!\n"
