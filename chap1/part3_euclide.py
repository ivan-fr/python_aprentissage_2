def essai(N):
    n = 0
    while 2**n <= N:
        n += 1
    return n


def _essai2(N):
    n = 0
    while True:
        if 2**n > N:
            return n
        n += 1


def somme(n):
    i, s = 1, 0
    while i <= n:
        s += i**2
        i += 1
    return s


def depasse(M):
    i, s = 0, 0
    while s < M:
        i += 1
        s += i**2
    return i


def adds(a, b):
    if a < 0 or b <= 0:
        raise AttributeError()
    while a >= b:
        a -= b

    return a


def algo_euclide(a, b):
    if  not a >= b > 0:
        raise AttributeError()
    r = adds(a, b)
    while b:
        a, b = b, r
        r = adds(a, b)

    return r


def algo_euclide_(a, b):
    if not a >= b > 0:
        raise AttributeError()
    while b:
        a, b = b, adds(a, b)

    return b
