#!/usr/bin/env python

import string
import vim
def lcount_continue(s, ch):
    cnt = 0
    for c in s:
        if c != ch:
            break
        cnt += 1
    return cnt

def align():
    r = vim.current.range
    lspaces_eachline = map(lcount_continue_space, r)
    cols = map(string.split, r)
