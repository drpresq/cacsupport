# Instructions to enable DoD CAC PIV usage within Firefox:

---



## Compatibility

---

These instructions were tested on Ubuntu Desktop 20.04 (Minimal Installation) 20210208.



## Instructions

---

1. Build OpenSC from [source.](https://github.com/OpenSC/OpenSC/wiki/Compiling-and-Installing-on-Unix-flavors)
2. Add the OpenSC module to FireFox.
3. Add Certificates to FireFox from [MilitaryCac.com.](https://militarycac.com/maccerts/AllCerts.zip)
4. Profit!



## Script it!

---

Paste this into terminal to automagically do it for you:


```

	echo "\n\n1. Building OpenSC from source\n"
	sudo apt-get install pcscd libccid libpcsclite-dev libssl-dev libreadline-dev autoconf automake build-essential docbook-xsl xsltproc libtool pkg-config zlib1g-dev libnss3-tools --assume-yes
	cd $HOME/Downloads
	wget https://github.com/OpenSC/OpenSC/releases/download/0.21.0/opensc-0.21.0.tar.gz
	tar xfvz opensc-*.tar.gz
	cd $(find $HOME/Downloads -type d -iname opensc*)
	./bootstrap
	./configure --prefix=/usr --sysconfdir=/etc/opensc
	make
	sudo make install

	echo -e "\n\n2. Adding the OpenSC module to FireFox\n"
	modutil -dbdir $(find $HOME/.mozilla/firefox/ -iname *.default-release) -add 'OpenSC' -libfile $(find /lib/pkcs11 -iname opensc-pkcs11.so)

	echo -e "\n\n3. Adding Certificates to FireFox\n"
	cd $HOME/Downloads
	wget https://militarycac.com/maccerts/AllCerts.zip
	mkdir dodCerts && unzip AllCerts.zip -d ./dodCerts 
	cd dodCerts
	for value in $HOME/Downloads/dodCerts/*; do s=${value##*/}; certutil -A -i "$value" -n "${s%.cer} - U.S. Government" -t"CT,C" -d $(find $HOME/.mozilla/firefox -iname *.default-release); done

	echo -e "\n\n4. PROFIT!!\n"

```



## References

---

[OpenSC Compilation Instructions](https://github.com/OpenSC/OpenSC/wiki/Compiling-and-Installing-on-Unix-flavors)

[DoD ID Management PIV Engineering Guide](https://piv.idmanagement.gov/engineering/firefox/)

[DoD Cyber Exchange FireFox Certificate Management Instructions](https://public.cyber.mil/pki-pke/end-users/getting-started/linux-firefox/)

[MilitaryCAC.com Linux Information Page](https://militarycac.com/linux.htm)
