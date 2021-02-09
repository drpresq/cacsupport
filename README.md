# Instructions to enable DoD CAC PIV usage within Firefox:

---


## Description

---

#### A collection of Linux shell scripts for integrating DoD CAC PIV Support into:

* OS (linux-cacsupport-base.sh) **Prerequisite for all scripts**
* FireFox (linux-cacsupport-firefox.sh)
* SSH

#### Instructions for expanding CAC usage in Windows:

* SSH with PuTTY

## Compatibility

---

Linux Shell Scripts were tested on Ubuntu Desktop 20.04 (Minimal Installation) 20210208.

Windows Instructions were tested on Windows 10 Enterprise with DISA STIG 20210209.


## Script it! (Linux)

---


```

git clone https://github.com/drpresq/cacsupport.git
cd cacsupport
chmod +x ./linux-*
./linux-*

```

## Read it! (Windows)

---

Just open it? If you don't have a text program that can parse markdown, just open it in [github](https://github.com/drpresq/cacsupport/blob/main/windows-cacsupport-ssh.md)


## References

---

[OpenSC Compilation Instructions](https://github.com/OpenSC/OpenSC/wiki/Compiling-and-Installing-on-Unix-flavors)

[DoD ID Management PIV Engineering Guide - FireFox](https://piv.idmanagement.gov/engineering/firefox/)

[DoD ID Management PIV Engineering Guide - SSH](https://piv.idmanagement.gov/engineering/ssh/)

[DoD Cyber Exchange FireFox Certificate Management Instructions](https://public.cyber.mil/pki-pke/end-users/getting-started/linux-firefox/)

[MilitaryCAC.com Linux Information Page](https://militarycac.com/linux.htm)
