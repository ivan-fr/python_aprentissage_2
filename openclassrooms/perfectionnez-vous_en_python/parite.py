#! /usr/bin/env python3
# coding: utf-8
import argparse
import re
import analysis.b_csv as c_an
import analysis.xml as x_an

import logging as lg


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--datafile',
                        help="""CSV file containing pieces of information about the members of parliament""")
    parser.add_argument("-p", "--byparty", action='store_true', help="""displays
        a graph for each political party""")
    parser.add_argument("-i", "--info", action='store_true', help="""information about
        the file""")
    parser.add_argument("-n", "--displaynames", action='store_true', help="""displays
        the names of all the mps""")
    parser.add_argument("-s", "--searchname", help="""search for a mp name""")
    parser.add_argument("-I", "--index", help="""displays information about the Ith mp""")
    parser.add_argument("-g", "--groupfirst",
                        help="""displays a graph groupping all the 'g' biggest political parties""")
    return parser.parse_args()


def main():
    args = parse_arguments()
    try:
        if args.datafile == None:
            raise Warning("il faut indiquer un fichier.")
        else:
            try:
                extension = re.search(r'^.+\.(\D{3})$', args.datafile)
                extension = extension.group(1)
                datafile = args.datafile
                if extension == "csv":
                    c_an.launch_analysis(datafile, args.byparty, args.info)
                elif extension == 'xml':
                    x_an.launch_analysis(datafile)
            except FileNotFoundError as e:
                lg.error(e)
            finally:
                lg.info("analysis is over.")
    except Warning as e:
        lg.warning(e)


if __name__ == '__main__':
    main()
