#!/usr/bin/env python
import os
import collections
import os.path as path

messages = collections.defaultdict(list)

for fname in os.listdir('test-fixtures/crashers'):
    if 'output' not in fname:
        continue

    with open(path.join('test-fixtures', 'crashers', fname), 'r') as fh:
        content = fh.readlines()

    for line in content:
        if line.startswith('panic:'):
            tup = (
                fname,
                open(path.join('test-fixtures', 'crashers', fname.replace('output', 'quoted'))).read(),
            )

            if 'error parsing regexp: invalid UTF-8' in line:
                messages['error parsing regexp: invalid UTF-8\n'].append(tup)

            elif 'unquote' in line and 'err: invalid syntax' in line:
                messages['unquote {input} err: invalid syntax\n'].append(tup)

            else:
                messages[line].append(tup)

for message, valuetups in messages.items():
    print message,
    for fname, inp in valuetups:
        # print '\t' + inp.strip() + '\t' + fname
        print inp,

    print
