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

import subprocess
import sys
import logging
import argparse
import os


def run_cmd(cmd: str):
    logging.log(logging.INFO, f'Running {cmd}')
    result = subprocess.run(cmd, shell=True, capture_output=True)
    if result.stderr and "permission denied" in result.stderr.decode():
        logging.log(logging.FATAL, f'Access Denied when running {cmd}. Are you root?\n')
        sys.exit(-1)
    elif result.stderr and "permission denied" not in result.stderr.decode() and (
            "error" in result.stderr.decode() or "fail" in result.stderr.decode()):
        logging.log(logging.FATAL, f'An unspecified error when running {cmd}:\n\t{result.stderr}')
        sys.exit(-1)
    return result


def find_profile():
    return \
        [path for path in run_cmd('find ~ -iname *.default-release').stdout.decode().split("\n") if
         '.cache' not in path][0]


def install_prereqs():
    _ = run_cmd("sudo apt-get install pcscd libccid libpcsclite-dev libssl-dev libreadline-dev autoconf automake "
                "build-essential docbook-xsl xsltproc libtool pkg-config zlib1g-dev --assume-yes")


def build_opensc():
    run_cmd('wget https://github.com/OpenSC/OpenSC/releases/download/0.21.0/opensc-0.21.0.tar.gz')
    run_cmd('tar xfvz opensc-*.tar.gz')
    os.chdir(f'{os.getcwd()}/opensc-0.21.0')
    run_cmd('./bootstrap')
    run_cmd("./configure --prefix=/usr --sysconfdir=/etc/opensc")
    run_cmd('make')
    run_cmd('make install')


def install_certs():
    os.chdir(f'/home/{os.getlogin()}/Downloads')
    run_cmd('wget https://militarycac.com/maccerts/AllCerts.zip')
    run_cmd('mkdir dodCerts && unzip AllCerts.zip -d ./dodCerts')

    run_cmd('certutil -A -i /path/to/cer -n 'DOD ID CA-39 - U.S. Government -t"CT,C" -d /path/to/mozilla/profile')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="DoD PIV Certificate Setup Tool",
                                     epilog="A Script By George\nhttps://www.github.com/drpresq/scripts\n")

    parser.add_argument('-v',
                        action='store_true',
                        help='Verbose Logging')

    args = parser.parse_args()

    log_level = logging.DEBUG if args.v else logging.INFO
    logging.basicConfig(level=log_level)

    logging.log(logging.WARN, f'**** DISABLING IPv6 For this System (TEMPORARY) ****\n')
    logging.log(logging.INFO, f'**** IPv6 is now ENABLED ****\n'
                              f'\t* A restart IS NOT required for this change to take effect\n'
                              f'\t* This WILL NOT persist through the next restart\n\n')
