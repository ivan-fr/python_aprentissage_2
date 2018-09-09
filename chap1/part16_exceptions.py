def dotprod(u, v):
    if len(u) != len(v):
        raise IndexError("Les vecteurs n'ont pas la même dimension !")
    return sum([t[0] * t[1] for t in zip(u, v)])


print(dotprod([3, 9], [5, -1]))
# print(dotprod([3, 9, 0], [5, -1]))

a = 0

try:
    x = a + 1 / a
except ZeroDivisionError:
    print("Division par zero ...")
except NameError:
    print("La variable 'a' n'est pas définie !")
else:
    print(x)
finally:
    print("Je t'aime comme un fou comme un soldat qui tombe à genoux.")
