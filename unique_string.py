#! /usr/bin/env python3

import argparse
import logging
import random
import string
import glob
import os

def unique_string():
    length = 30 # 26**30 ~= 1e42
    letters = string.ascii_lowercase
    unique = ''
    for _ in range(length):
        unique += random.choice(letters)
    logging.debug("unique = '{}'".format(unique))
    return unique

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Generate unique string.'
    )
    parser.add_argument(
        '-v',
        '--verbose',
        help='More verbose logging',
        dest="loglevel",
        default=logging.WARNING,
        action="store_const",
        const=logging.INFO,
    )
    parser.add_argument(
        '-d',
        '--debug',
        help='Enable debugging logs',
        action="store_const",
        dest="loglevel",
        const=logging.DEBUG,
    )
    args = parser.parse_args()
    logging.basicConfig(level=args.loglevel)

    print(unique_string())
