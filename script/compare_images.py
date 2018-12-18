# -*- encoding: utf-8 -*-
from wand.image import Image
from wand.display import display
import glob
import os
import argparse
from tabulate import tabulate
from colorama import Fore
from jinja2 import Environment
from jinja2.loaders import FileSystemLoader

__version__ = '0.1.0'


def arg_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-v', '--verbose')
    parser.add_argument('--version', action='version', version=__version__)
    parser.add_argument('-a', '--answer', required=True, dest='answers', help='Answer Directory')
    parser.add_argument('-i', '--input', required=True, dest='inputs', help='Input Directory')
    parser.add_argument('-o', '--output', dest='output_dir', help='Output Directory')
    parser.add_argument('--display_errors', action="store_true")
    return parser


def main(argv=None):
    parser = arg_parser()
    args = parser.parse_args(argv)

    answer_dir = args.answers
    input_dir = args.inputs
    errors = {}
    total = 0
    error_count = 0
    for filename in glob.glob(answer_dir + '*/*.png'):
        basename = os.path.basename(filename)
        dst_filename = os.path.join(input_dir, basename)
        total += 1
        with Image(filename=filename) as answer_img:
            with Image(filename=dst_filename) as dst_img:
                (diff_img, diff_value) = answer_img.compare(dst_img, metric='root_mean_square')
                if diff_value == 0:
                    print '✅ |', Fore.LIGHTWHITE_EX + basename + Fore.RESET
                else:
                    print '❌ |', Fore.LIGHTRED_EX + str(
                        diff_value) + Fore.RESET, '|', Fore.LIGHTWHITE_EX + basename + Fore.RESET
                    device = basename[0:basename.find('-')]
                    error_count += 1
                    if device in errors:
                        errors[device].append((diff_value, diff_img, basename))
                    else:
                        errors[device] = [(diff_value, diff_img, basename)]
                    if args.display_errors:
                        display(diff_img)

    print tabulate([[total, error_count]], headers=['Total', 'Error'])

    env = Environment(loader=FileSystemLoader(os.path.join(os.path.dirname(__file__), 'templates')))

    tmpl = env.get_template('report-template.html')

    output_dir = args.output_dir if args.output_dir else "report"

    img_dir = os.path.join(output_dir, 'images')
    if not os.path.exists(img_dir):
        os.makedirs(img_dir)

    datas = {}
    for device, screenshots in errors.items():
        urls = []
        for (_, img, name) in screenshots:
            filename = os.path.join(img_dir, name)
            img.save(filename=filename)
            urls.append(os.path.join('images', name))
        datas[device] = urls

    content = tmpl.render(language="zh-Hans", datas=datas)
    with open(os.path.join(output_dir, 'report.html'), 'w') as file:
        file.write(content)

    if len(errors) > 0:
        exit(1)


if __name__ == '__main__':
    main()
