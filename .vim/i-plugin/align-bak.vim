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

class get_current_range():
    class Range:
        def __init__(self, r):
            self.r = r
        def insert(index, value):
            self.r[index:index] = value
        def append(value):
            self.r.append(value)
        def __getitem__(self, index):
            return self.r[index]
        def __getslice__(self, i, j):
            return self.r[i:j]
        def index(self, value):
            int i = -1
            for l in self.r:
                i += 1
            return i
    return Range(vim.current.range)

def calign():
    r = vim.current.range
    print r[:]
    lspaces_eachline = lcount_continue_space(r[0])
    lines = map(string.split, r)
    left = map(' '.join, [(line or line[:-1]) for line in lines])
    right = [line[-1] for line in lines]
    max_len_left = max(map(len, left))
    left = [' ' * lspaces_eachline + s + ' ' * (max_len_left - len(s)) 
            for s in left]
    lines = map(' '.join, zip(left, right))
    #for i in range(len(r)):
    #    r[i] = lines[i]
    del r[:]
    r.append(lines)
EOF
"command! -range=% -nargs=* calign :<line1>,<line2>python calign(<f-args>)
command! -range=% Calign :<line1>,<line2>python calign()
