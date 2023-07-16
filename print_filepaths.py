#! /usr/bin/env python3

import argparse
import os
import logging
import sys

def yield_filepaths(topdir, real_paths=False):
    for dirpath, dirnames, filenames in os.walk(topdir, topdown=True):
        for filename in filenames:
            fullpath = os.path.join(dirpath, filename)
            if os.path.isfile(fullpath):
                if real_paths:
                    real_path = os.path.realpath(fullpath)
                    yield real_path
                else:
                    yield fullpath
            else:
                logging.debug("Skipping path '{}'".format(filepath))
                continue

def readable_directory(path):
    if not os.path.isdir(path):
        raise argparse.ArgumentTypeError(
            'not an existing directory: {}'.format(path))
    if not os.access(path, os.R_OK):
        raise argparse.ArgumentTypeError(
            'not a readable directory: {}'.format(path))
    return path


def main():
    parser = argparse.ArgumentParser(
        description='List files under a directory, recursively')
    parser.add_argument(
        'topdir', type=readable_directory, help='Top directory')
    # https://stackoverflow.com/questions/14097061/easier-way-to-enable-verbose-logging
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
    parser.add_argument(
        '--real-paths',
        help='Print real paths',
        action="store_true",
    )
    args = parser.parse_args()
    logging.basicConfig(level=args.loglevel)

    for path in yield_filepaths(args.topdir, real_paths=args.real_paths):
        sys.stdout.write(path + '\n')

if __name__ == '__main__':
    main()
