def zeta(p, n=100):
    return sum(1 / i ** p for i in range(1, n + 1))


print(zeta(2))  # p, N = 2, 100
print(zeta(2, 10 ** 5))  # p, N = 2, 100000
print(zeta(0, 100))  # p, N = 3, 100


def affiche(**arguments):
    for key, value in arguments.items():
        print("arguments[{}] = {}".format(key, value))
    print('\narguments = ', arguments)


affiche(a=9, b=8, c=11)


def produit(*facteurs):
    p = 1
    for i in facteurs:
        p *= i
    print('Le produit des facteurs {} est {}.'.format(facteurs, p))


produit(2, 3, 4, 5)


def composition(f, g):
    """Renvoie la composé de deux fonctions f et g.

    >>> from math import sin, cos
    >>> f = composition(cos, sin)
    >>> g = composition(sin, cos)
    >>> [f(x) - g(x) for x in range(0, 3)]
    [0.1585290151921035, 0.15197148686933137, 1.018539435968748]
    """

    return lambda _x: f(g(_x))


if __name__ == "__main__":
    import doctest

    doctest.testmod()

help(composition)
