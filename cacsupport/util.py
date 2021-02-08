"""
Util - CAC Support Package Utilities

:Description:
                This module consists of common functions used throughout
                the CAC Support package.
"""

import logging
import subprocess
import sys
import os


def run_cmd(cmd: str) -> [str]:
    logging.log(logging.INFO, f'Running {cmd}')
    result = subprocess.run(cmd, shell=True, capture_output=True)
    if result.stderr and "permission denied" in result.stderr.decode():
        logging.log(logging.FATAL, f'Access Denied when running {cmd}. Are you root?\n')
        sys.exit(-1)
    elif result.stderr and "permission denied" not in result.stderr.decode() and (
            "error" in result.stderr.decode() or "fail" in result.stderr.decode()):
        logging.log(logging.FATAL, f'An unspecified error when running {cmd}:\n\t{result.stderr}')
        sys.exit(-1)
    return result.stdout.decode().split("\n")


def get_profile():
    return \
        [path for path in run_cmd('find ~ -iname *.default-release') if
         '.cache' not in path][0]


def get_download():
    return f'/home/{os.getlogin()}/Downloads'


def install_certs():
    dl_dir = get_download()
    os.chdir(dl_dir)
    run_cmd('wget https://militarycac.com/maccerts/AllCerts.zip')
    run_cmd('mkdir dodCerts && unzip AllCerts.zip -d ./dodCerts')
    os.chdir(f'{dl_dir}/dodCerts')
    run_cmd("""certutil -A -i /path/to/cer -n 'DOD ID CA-39 - U.S. Government -t"CT,C" -d /path/to/mozilla/profile""")
