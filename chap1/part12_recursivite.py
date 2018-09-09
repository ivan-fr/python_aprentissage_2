########### RECURSIVITE ###########

# une fonction recursive contient un cas de base
# la logique interne de la foncion doit se ramener au cas de base
# la logique interne de la fonction doit contenir un appel vers lui même


def puissance_(x, n):
    if n < 0:
        raise ValueError
    elif n == 0:
        return 1
    else:
        return x * puissance(x, n - 1)


def puissance(x, n):
    if n == 0:
        return 1
    else:
        print('--' * n + '> appel de puissance({},{})'.format(x, n - 1))
        y = x * puissance(x, n - 1)
        print('--' * n + '> sortie de puissance({},{})'.format(x, n - 1))

        return y


print(puissance(2, 5))


def expo(a, n):
    if n == 0:
        return 1
    else:
        if n % 2 == 0:
            puissance = expo(a, n / 2) ** 2
        else:
            puissance = a * expo(a, (n - 1) / 2) ** 2

    return puissance


print(expo(2, 5))


def factCurv(n):
    if n == 0:
        return 1
    else:
        return n * factCurv(n - 1)


print(factCurv(10))


def factIter(n):
    f = 1
    for i in range(2, n + 1):
        f *= i
    return f


print(factIter(10))


# soit p un polynôme où p est une liste de ses coefficients
# p = [a0, ..., an]
def horner(p, x):
    if len(p) == 1:
        return p[0]
    else:
        p[-2] += p[-1] * x

        print('-' * len(p), '> .... entrant ....', len(p))
        r = horner(p[:-1], x)
        print('-' * len(p), '> .... sortant ....', len(p))
        return r


print(horner(list(range(4, 99, 2)), 6))


def horner_iter(p, x):
    somme = p[-1]
    for an_1 in reversed(p[:-1]):
        somme = an_1 + x * somme
    return somme


print(horner_iter(list(range(4, 99, 2)), 6))
