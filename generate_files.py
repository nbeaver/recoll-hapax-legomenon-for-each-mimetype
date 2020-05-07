#! /usr/bin/env python3

import argparse
import logging
import random
import string
import glob
import os

def readable_directory(path):
    if not os.path.isdir(path):
        raise argparse.ArgumentTypeError(
            'not an existing directory: {}'.format(path))
    if not os.access(path, os.R_OK):
        raise argparse.ArgumentTypeError(
            'not a readable directory: {}'.format(path))
    return path


def writable_directory(path):
    if not os.path.isdir(path):
        raise argparse.ArgumentTypeError(
            'not an existing directory: {}'.format(path))
    if not os.access(path, os.W_OK):
        raise argparse.ArgumentTypeError(
            'not a writable directory: {}'.format(path))
    return path

def unique_string():
    length = 30 # 26**30 ~= 1e42
    letters = string.ascii_lowercase
    unique = ''
    for _ in range(length):
        unique += random.choice(letters)
    logging.debug("unique = '{}'".format(unique))
    return unique

def write_files(template_dir, output_dir):
    hapax_list_path = os.path.join(output_dir, "hapax_list.txt")
    hapax_list_fp = open(hapax_list_path, 'w')
    for template_path in glob.glob(template_dir + '/*'):
        logging.info("attempting to read template file '{}'".format(template_path))
        with open(template_path) as template_fp:
            template_str = template_fp.read()
        template = string.Template(template_str)
        unique_str = unique_string()
        filename = os.path.basename(template_path)
        hapax_list_fp.write(filename + '\t' + unique_str + '\n')
        payload = template.substitute(unique_word=unique_str)
        if payload == template_str:
            raise ValueError("template file not changed: '{}'".format(template_path))
        out_path = os.path.join(output_dir, filename)
        with open(out_path, 'w') as out_fp:
            logging.info("writing to file '{}'".format(out_path))
            out_fp.write(payload)
    hapax_list_fp.close()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Generate example files templates.'
    )
    parser.add_argument(
        'templates',
        type=readable_directory,
        help='template directory'
    )
    parser.add_argument(
        'outdir',
        type=writable_directory,
        help='output directory for generated files'
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
    write_files(args.templates, args.outdir)
