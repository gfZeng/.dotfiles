python << EOF
import string
import vim
import string

def lcount_continue(s, ch):
    cnt = 0
    for c in s:
        if c != ch:
            break
        cnt += 1
    return cnt

def lcount_continue_space(s):
    return lcount_continue(s, " ")

def align():
    r = vim.current.range
    lspaces_eachline = map(lcount_continue_space, r)
    lines = map(string.split, r)
    left = map(' '.join, [line[:-1] for line in lines])
    right = [line[-1] for line in lines]
    max_len_left = max(map(len, left))
    left = [s + ' ' * (max_len_left - len(s)) 
            for s in left]
    lines = map(' '.join, zip(left, right))
    for i in range(len(r)):
        r[i] = lines[i]


def _my_function(*some_arg):
    align()

EOF
command! -range=% -nargs=* MyCommand :<line1>,<line2>python _my_function(<f-args>)
