#! /usr/bin/env python3

import logging
import subprocess
import argparse
import os.path
import sys

def search_strings(filepaths):
    for filepath in filepaths:
        with open(filepath) as fp:
            for line in fp.readlines():
                filename, unique_string = line.strip('\n').split('\t')
                output_b = subprocess.check_output(['recoll', '-t', unique_string])
                output_str = output_b.decode()
                print(filename)
                print(output_str)

def readable_file(path):
    if not os.path.isfile(path):
        raise argparse.ArgumentTypeError(
            'not an existing file: {}'.format(path))
    if not os.access(path, os.R_OK):
        raise argparse.ArgumentTypeError(
            'not a readable file: {}'.format(path))
    return path

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Search recoll for the unique strings in the given file(s).')
    parser.add_argument(
        'input', type=readable_file, nargs='+'
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
    logging.basicConfig(level = args.loglevel)
    search_strings(args.input)
