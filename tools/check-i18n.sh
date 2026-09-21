#!/usr/bin/env bash
# Checks the bilingual markup in index.html and story.html.
#
# Two failure modes are easy to introduce and invisible in the browser unless
# you happen to be looking at the other language:
#
#   1. an element marked lang="en" with no zh-Hant twin (or the reverse) —
#      that block silently disappears from one of the two views
#   2. a data-i18n key with no entry in that page's ZH dictionary — the string
#      stays English in the Chinese view
#
# Run it after adding or editing content. No dependencies beyond python3.
#
# Usage: ./tools/check-i18n.sh [file...]        (defaults to both pages)

set -euo pipefail
cd "$(dirname "$0")/.."

FILES=("$@")
if [ ${#FILES[@]} -eq 0 ]; then
  FILES=(index.html story.html)
fi

python3 - "${FILES[@]}" <<'PY'
import sys, re
from html.parser import HTMLParser

VOID = {'area','base','br','col','embed','hr','img','input','link',
        'meta','param','source','track','wbr'}

# Deliberately one-sided: a quotation stays in the speaker's own words in both
# views and the Chinese gloss underneath has no English twin by design.
UNPAIRED_OK = {'quote-gloss'}

OTHER = {'en': 'zh-Hant', 'zh-Hant': 'en'}


class Node:
    __slots__ = ('tag', 'attrs', 'line', 'children', 'parent')

    def __init__(self, tag, attrs, line, parent):
        self.tag, self.attrs, self.line = tag, attrs, line
        self.children, self.parent = [], parent


class Tree(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.root = Node('#root', {}, 0, None)
        self.cur = self.root

    def handle_starttag(self, tag, attrs):
        node = Node(tag, dict(attrs), self.getpos()[0], self.cur)
        self.cur.children.append(node)
        if tag not in VOID:
            self.cur = node

    def handle_startendtag(self, tag, attrs):
        self.cur.children.append(Node(tag, dict(attrs), self.getpos()[0], self.cur))

    def handle_endtag(self, tag):
        node = self.cur
        while node is not self.root and node.tag != tag:
            node = node.parent
        if node is not self.root:
            self.cur = node.parent


def walk(node):
    for child in node.children:
        yield child
        yield from walk(child)


def describe(node):
    cls = node.attrs.get('class', '')
    return '<%s%s>' % (node.tag, ' class="%s"' % cls if cls else '')


issues = []

for path in sys.argv[1:]:
    with open(path, encoding='utf-8') as fh:
        src = fh.read()

    tree = Tree()
    tree.feed(src)

    # --- 1. paired lang markup -------------------------------------------
    for node in walk(tree.root):
        lang = node.attrs.get('lang')
        # <html lang> is the switch itself, not a piece of paired content.
        if lang not in OTHER or node.tag == 'html':
            continue
        if UNPAIRED_OK & set(node.attrs.get('class', '').split()):
            continue
        want = OTHER[lang]
        # The twin has to be the element right next to it, not merely somewhere
        # under the same parent: in a list that alternates en/zh, an orphan
        # would otherwise pair with a neighbour's twin and go unreported.
        siblings = node.parent.children if node.parent else []
        i = siblings.index(node)
        neighbours = [siblings[j] for j in (i - 1, i + 1)
                      if 0 <= j < len(siblings) and j != i]
        if not any(s.tag == node.tag and s.attrs.get('lang') == want
                   for s in neighbours):
            issues.append('%s:%d  lang="%s" has no adjacent %s twin  %s'
                          % (path, node.line, lang, want, describe(node)))

    # --- 2. dictionary keys ----------------------------------------------
    dict_block = re.search(r'var ZH\s*=\s*\{(.*?)\n  \};', src, re.S)
    keys = set(re.findall(r"'([^']+)'\s*:", dict_block.group(1))) if dict_block else set()
    if not dict_block:
        issues.append('%s:0  no `var ZH = { ... }` dictionary found' % path)

    for node in walk(tree.root):
        for attr in ('data-i18n', 'data-i18n-label'):
            key = node.attrs.get(attr)
            if key and key not in keys:
                issues.append('%s:%d  %s="%s" is not in the dictionary  %s'
                              % (path, node.line, attr, key, describe(node)))

for line in issues:
    print(line)
print('%d issue%s' % (len(issues), '' if len(issues) == 1 else 's'))
sys.exit(1 if issues else 0)
PY
