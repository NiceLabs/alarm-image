#!/usr/bin/env python3
import sys
from datetime import datetime

import requests


def get_delta(url: str):
    response = requests.head(url)
    remote_time = datetime.strptime(response.headers['date'], '%a, %d %b %Y %H:%M:%S GMT')
    return datetime.now() - remote_time


def main(url: str):
    delta = get_delta(url)
    if delta.days < 30:
        return 0
    print(f'Not updated in more than {int(delta.days)} days', file=sys.stderr)
    return 1


if __name__ == '__main__':
    sys.exit(main(sys.argv[1]))
