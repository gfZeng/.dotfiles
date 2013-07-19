python << EOF
import string
import vim
import string
import re

def lcount_continue(s, ch):
    cnt = 0
    for c in s:
        if c != ch:
            break
        cnt += 1
    return cnt

def lcount_continue_space(s):
    return lcount_continue(s, " ")

def get_current_range():
    class Range:
        def __init__(self, r):
            self.r = r
        def __getitem__(self, index):
            return self.r[index]
        def __getslice__(self, i, j):
            return self.r[i:j]
        def __len__(self):
            return len(self.r)
        def index(self, value):
            i = -1
            for l in self.r:
                i += 1
                if l == value:
                    break
            return i
        def indexes(self, value):
            return [i for i in range(len(self)) if self[i] == value]
        def pop(self, index=-1):
            x = self[index]
            del self.r[index]
            return x
        def popall(self, *ies):
            ies = list(ies)
            ies.sort(reverse=True);
            return map(self.pop, ies)
        def insert(self, index, value):
            self.r[index:index] = [value]
        def insert_newline(self, index):
            self.insert(index, '')
        def append(self, value):
            self.r.append(value)
        def remove(self, value):
            del self.r[self.index(value)]
        def removeall(self, value):
            ies = self.indexes(value)
            ies.reverse()
            for i in ies:
                del self.r[i]
        def spacelines(self):
            return filter(lambda i: self[i] == '' or self[i].isspace(),
                          range(len(self)))
        def clear(self):
            del self.r[:]
        def __str__(self):
            return str(self.r[:])
    return Range(vim.current.range)

def calign():
    r = get_current_range()
    spacelines = r.spacelines()
    r.popall(*spacelines)
    start_continue_spaces = map(lcount_continue_space, r)
    def indexof(l, key):
        try:
            return l.index(key)
        except ValueError:
            return 0
    lines_cols = map(lambda l: l.split(), r)
    r.clear()
    left, right = zip(*map(lambda r, i: (' '.join(r[:i]), ' '.join(r[i:])), lines_cols,
        map(lambda l: indexof(l, '=') - 1, lines_cols)))
    max_left_len = max(map(len, left))
    result = map(lambda x, y: x + y,
                 [' ' * start_continue_spaces[i] + left[i] + ' ' * (max_left_len - len(left[i]) + 1)
                  for i in range(len(start_continue_spaces))],
                      right)
    r.append(result)
    map(r.insert_newline, spacelines)
EOF
"command! -range=% -nargs=* calign :<line1>,<line2>python calign(<f-args>)
command! -range=% Calign :<line1>,<line2>python calign()
