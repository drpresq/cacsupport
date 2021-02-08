#!/usr/bin/python3
"""
:certutil commands:
	certutil -A -i /path/to/cer -n 'DOD ID CA-39 - U.S. Government -t"CT,C" -d /path/to/mozilla/profile

:OpenSC Prereqs:
	sudo apt-get install pcscd libccid libpcsclite-dev libssl-dev libreadline-dev autoconf automake build-essential docbook-xsl xsltproc libtool pkg-config zlib1g-dev --assume-yes

:OpenSC Build/Install:
	wget https://github.com/OpenSC/OpenSC/releases/download/0.21.0/opensc-0.21.0.tar.gz
	tar xfvz opensc-*.tar.gz
	cd opensc-*
	./bootstrap
	./configure --prefix=/usr --sysconfdir=/etc/opensc
	make
	sudo make install
"""

from cacsupport.util import *
from enum import Enum
import os


class OsType(Enum):
    DEB = 1
    RPM = 2
    AUR = 3


class BrowserType(Enum):
    MOZILLA = 1
    CHROME = 2


class Section(Enum):
    PREREQ = 1
    BUILD = 2
    INSTALL = 3


class OsBase:
    os_type: int
    os_def: dict = {
        OsType.DEB: {
            Section.PREREQ: "sudo apt-get install pcscd libccid libpcsclite-dev libssl-dev libreadline-dev autoconf "
                          "automake build-essential docbook-xsl xsltproc libtool pkg-config zlib1g-dev"
        },
        OsType.RPM: {
            Section.PREREQ: "su -c 'yum install readline-devel openssl-devel libxslt docbook-style-xsl pcsc-lite-devel "
                          "automake autoconf libtool gcc zlib-devel'"
        }
    }

    opensc_def: dict = {
        Section.PREP: ["wget https://github.com/OpenSC/OpenSC/releases/download/0.21.0/opensc-0.21.0.tar.gz",
                            "tar xfvz opensc-*.tar.gz"],
        Section.BUILD: ["./bootstrap",
                             "./configure --prefix=/usr --sysconfdir=/etc/opensc",
                             "make"],
        Section.INSTALL: ["sudo make install"]
    }

    browser_def: dict = {
        BrowserType.MOZILLA: {
            Section.INSTALL: ["modutil -dbdir {profile} -add {mod_name} -libfile {mod_lib}"]
        },
        BrowserType.CHROME: {
            Section.INSTALL:
        }
    }


    def install_prereqs(self):
        for action in self.os_def[self.os_type][Section.PREREQ]:
            _ = run_cmd(action)

    def build_opensc(self):
        dl_dir = get_download()
        os.chdir(dl_dir)
        for action in self.os_def[self.os_type][Section.PREP]:
            _ = run_cmd(action)
        os.chdir(f'{dl_dir}/opensc-*')
        for action in self.os_def[self.os_type][Section.BUILD]:
            _ = run_cmd(action)
        for action in self.os_def[self.os_type][Section.INSTALL]:
            _ = run_cmd(action)

    def configure_firefox(self):
        profile_dir = get_profile()

