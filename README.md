# CAC Support - Utilities and Documents to enable DoD CAC PIV Usage!

---


## Description

---

#### A collection of Linux shell scripts for integrating DoD CAC PIV Support:

* OpenSC PIV II Smartcard Support for Firefox and Chromium-based web browsers (linux-cacsupport-setup.sh)
* Enable the use of your PIV II Smartcard-based user certificates as SSH keys (linux-cacsupport-ssh.sh)

#### Instructions for expanding CAC usage in Windows:

* SSH with PuTTY

## Compatibility

---

Linux Shell Scripts are verified on: 

- Ubuntu Desktop 20.04 (Minimal Installation)
- Mint Linux Desktop 20.3
- Mint Linux Desktop 21.1

Windows Instructions were tested on Windows 10 Enterprise with DISA STIG 20210209.


## Script it! (Linux)

---


```
git clone https://github.com/drpresq/cacsupport.git
cd cacsupport
chmod +x ./linux-cacsupport-*
# Setup DoD CAC PIV Support
./linux-cacsupport-setup.sh
# Setup Using DoD CAC PIV for use with ssh
./Linux-cacsupport-ssh.sh

```

## Read it! (Windows)

---

Just open it! If you don't have a text program that can parse markdown, just open it in [github](https://github.com/drpresq/cacsupport/blob/main/windows-cacsupport-ssh.md)


## References

---

[OpenSC Compilation Instructions](https://github.com/OpenSC/OpenSC/wiki/Compiling-and-Installing-on-Unix-flavors)

[DoD ID Management PIV Engineering Guide - FireFox](https://piv.idmanagement.gov/engineering/firefox/)

[DoD ID Management PIV Engineering Guide - SSH](https://piv.idmanagement.gov/engineering/ssh/)

[DoD Cyber Exchange FireFox Certificate Management Instructions](https://public.cyber.mil/pki-pke/end-users/getting-started/linux-firefox/)

[MilitaryCAC.com Linux Information Page](https://militarycac.com/linux.htm)
