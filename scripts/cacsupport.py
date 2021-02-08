#!/usr/bin/python3

"""
CAC Support - Automated CAC Support Setup Utility

:Author:
                George (https://github.com/drpresq/cacsupport)

:Description:
                This utility installs support for Department of Defense (DoD) Common
                Access Card (CAC) support which includes support for Personal Identity
                Verification (PIV).
"""

from cacsupport import *
import logging
import argparse


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