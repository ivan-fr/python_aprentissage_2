def palindrome1(x):
    n, x = len(str(x)), str(x)

    if n % 2 == 0:
        return False
    t = int((n - 1) / 2)
    i, p = -1, ''
    while i >= -t:
        p += x[i]
        i -= 1
    if x[0:t] == p:
        return True
    return False


def palindrome2(x):
    x = str(x)
    return all(i == j for i, j in zip(x, reversed(x)))


def palindrome3(x):
    i, x = 0, str(x)
    l = len(str(x))
    while i <= (l - 1) / 2:
        if not x[i] == x[l - 1 - i]:
            return False
        i += 1
    return True


def palindrome4(x):
    x = str(x)
    if len(x) == 1:
        return True
    elif x[0] != x[-1]:
        return False
    else:
        return palindrome4(x[1:-1])


print(palindrome1(1234321))
print(palindrome2(1234321))
print(palindrome3(1234321))
print(palindrome4(12343219))


def champernowne(n):
    i, _i, c, sep, use_sep = 1, 1, '0.', 0, False
    while i <= n:
        sep = sep % 10
        if use_sep:
            use_sep = False
            if sep != 0:
                c += str(sep)
                i += 1
        else:
            use_sep = True
            c += str(_i)
            _i += 1
            if _i % 10 == 0:
                _i = 0
                sep += 1
            i += 1

    return c


print(champernowne(61))


def serie(n):
    return sum(len(str(k)) / (k * (k + 1)) for k in range(1, n + 1))


for i in range(1, 4):
    print(serie(10 ** i))


def serie1(n):
    return sum(1 / i ** 2 for i in range(1, n + 1) if not '9' in str(i))


for i in range(1, 2):
    print(serie1(10 ** i))


def triplets_pythagoriciens(n):
    tuplee = [(x, y, z) for x in range(1, n) for y in range(x, n) for z in range(y, n) if x ** 2 + y ** 2 == z ** 2]
    return tuplee, len(tuplee)


print(triplets_pythagoriciens(30))


def somme_2(n):
    return ' + '.join('{}^2'.format(i) for i in range(1, n + 1)) \
           + ' = {}'.format(sum(i ** 2 for i in range(1, n + 1)))


for i in range(1, 10):
    print(somme_2(i))


def parfait(n):
    diviseurs = [i for i in range(1, n) if n % i == 0]
    parfait = sum(diviseurs) == n
    return bool(parfait)


def listes_parfait(n):
    return [i for i in range(2, n + 1) if parfait(i)]


def somme(n):
    diviseurs = [i for i in range(1, n) if n % i == 0]
    if sum(diviseurs) == n:
        return '{} = {}'.format(n, ' + '.join(str(d) for d in diviseurs))


print(somme(28))

print(listes_parfait(100))


def crible(liste):
    if liste == []:
        return []
    return [liste[0]] + crible([i for i in liste[1:] if i % liste[0] != 0])

print(crible(range(2, 100)))