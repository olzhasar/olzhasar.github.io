#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals
import os

BASE_DIR = os.path.dirname(os.path.realpath(__file__))

AUTHOR = 'Olzhas Arystanov'
SITENAME = 'Olzhas Arystanov'
SITEURL = ''

PATH = os.path.join(BASE_DIR, 'content')
PAGE_PATHS = ['pages', 'projects']
ARTICLE_PATHS = ['articles']

THEME = os.path.join(BASE_DIR, 'theme')

CATEGORY_URL = '{slug}'
CATEGORY_SAVE_AS = '{slug}.html'

USE_FOLDER_AS_CATEGORY = True
DEFAULT_CATEGORY = 'misc'

ARTICLE_URL = '{category}/{slug}'
ARTICLE_SAVE_AS = '{category}/{slug}.html'
TAG_URL = 'tag/{slug}'

PAGE_URL = '{slug}'
PAGE_SAVE_AS = '{slug}.html'

TIMEZONE = 'Asia/Almaty'
DEFAULT_DATE_FORMAT = "%b %d %Y"

DEFAULT_LANG = 'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

STATIC_PATHS = [
    'extra',
]

EXTRA_PATH_METADATA = {
    'extra/favicon.ico': {'path': 'favicon.ico'},
    'extra/apple-touch-icon.png': {'path': 'apple-touch-icon.ico'},
    'extra/android-chrome-192x192.png': {'path': 'android-chrome-192x192.png'},
    'extra/android-chrome-512x512.png': {'path': 'android-chrome-512x512.png'},
}

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True
