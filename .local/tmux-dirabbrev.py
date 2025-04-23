#!/usr/bin/env python3

import os
import sys
import logging
import pathlib
import argparse

def main(args):

    path: pathlib.Path = args.path.absolute()

    homedir = pathlib.Path.home()

    abbrev = []
    parts = list(path.parts)

    idx = 1
    if (home := path.is_relative_to(homedir)):
        abbrev.append('~')
        idx = len(homedir.parts)

    while idx < len(parts) - 1:
        parent = pathlib.Path(os.path.join(*parts[:idx]))
        curdir = parent / parts[idx]

        matches = [p for p in parent.glob(f'{curdir.stem[0]}*') if p.is_dir()]
        if len(matches) > 1:
            abbrev.append(curdir.stem)
        else:
            abbrev.append(curdir.stem[0])

        idx += 1

    abbrev.append(parts[-1])

    abbrev = os.path.sep.join(abbrev)
    if not home:
        abbrev = os.path.sep + abbrev
    print(abbrev)

    return 0

if __name__ == '__main__':
    parser = argparse.ArgumentParser(prog=sys.argv[0])

    parser.add_argument('-v', '--verbose', help='Verbose output', action='store_true')
    parser.add_argument('path', help='Path to abbreviate', type=pathlib.Path)

    args = parser.parse_args()
    if args.verbose == 1:
        logging.getLogger().setLevel(logging.INFO)
    elif args.verbose == 2:
        logging.getLogger().setLevel(logging.DEBUG)

    try:
        sys.exit(main(args))
    except Exception as exc:
        logging.error('Error in main: %s', exc, exc_info=args.verbose)
        sys.exit(-1)
