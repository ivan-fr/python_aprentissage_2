# introduction sur les attributions de nombres
a = 100
b = 17
c = a - b  # 83
a = 2
c = a + b  # 19
print(a, b, c)  # 2, 17, 19

a = 3
b = 4
c = a  # 3
b = c  # 3
print(a, b, c)  # 3, 3, 3

x = 19
x = x + 2
y = x * 2  # 21, 42
print(x, y)

x = 19
x, y = x + 2, x * 2
print(x, y)  # 21, 38

# échanges des valeurs
x, y = 10, 21
tmp = x
x = y
y = tmp
print(x, y)

x, y = 10, 21
x = x + y
y = x - y
x = x - y
print(x, y)

x, y = 10, 21
x, y = y, x
print(x, y)

# introduction sur les fonctions
x = 2
print(x ** 7 - 6 * x ** 6 + 15 * x ** 4 + 23 * x ** 3 + x - 9)

x = 3
print(x ** 7 - 6 * x ** 6 + 15 * x ** 4 + 23 * x ** 3 + x - 9)

x = 4
print(x ** 7 - 6 * x ** 6 + 15 * x ** 4 + 23 * x ** 3 + x - 9)


def f(_a):
    return _a ** 7 - 6 * _a ** 6 + 15 * _a ** 4 + 23 * _a ** 3 + _a - 9


print(f(2), f(3), f(4))


def factoriel(n):
    if not n:
        return 1
    else:
        return n * factoriel(n - 1)


print(factoriel(10))


def vabs(_x):
    return _x if _x > 0 else -_x


i = -5
while i <= 5:
    print('abs({}) = {}'.format(i, vabs(i)))
    i += 1


def nbre_solutions(_a, _b, _c):
    delta = _b ^ 2 - 4 * _a * _c

    if delta == 0:
        print("l'équation est de premier degré.")
    elif delta > 0:
        print("l'équation posséde deux solutions réelles distinctes.")
    elif delta == 0:
        print("l'équation possède une solution double réelle.")
    else:
        print("l'équation de possède pas de solution réelles.")


def max2(_a, _b):
    if _a <= _b:
        return _b
    else:
        return _a


def max3(_a, _b, _c):
    return max2(max2(_a, _b), _c)


def _bissextiles(n):
    return (n % 4 == 0) and ((n % 100 != 0) or (n % 400 == 0))


def __bissextiles(n):
    if n % 4 == 0:
        if n % 100 != 0:
            return True
        elif n % 400 == 0:
            return True
    return False


print(_bissextiles(2000))
