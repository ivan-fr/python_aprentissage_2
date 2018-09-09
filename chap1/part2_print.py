from math import *

o = eval(input('x=?'))
fonction = input('f=?')

code = ('def t(x, _fonction):'
        '   return "{}".format(eval(_fonction(x)))')
exec(code)

print('{:.6f}'.format(eval(t(x, fonction))))
