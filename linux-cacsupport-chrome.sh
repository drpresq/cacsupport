echo -e "\n\nAdding the OpenSC Module to default PKI Database\n"
modutil -dbdir sql:.pki/nssdb/ -add "token_name" -libfile /usr/lib/opensc-pkcs11.so

echo -e "\n\nDONE!!\n"
