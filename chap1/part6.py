def f(n):
    i = 0
    while i <= n - 1:
        print('je me répère {} fois. (i={})'.format(n, i))
        i += 1


f(5)

print()


def f(n):
    for i in range(n):
        print('je me répère {} fois. (i={})'.format(n, i))


f(5)


def range_(n=0, p=None, k=1):
    if p is None:
        n, p = 0, n

    i, list_ = n, []

    if k > 0:
        q = 1
    elif k < 0:
        q = -1
    else:
        raise ValueError()

    if n <= i <= p - q:
        if k <= 0:
            return list_
        c = True
    elif n >= i >= p - q:
        if k >= 0:
            return list_
        c = False
    else:
        return liste_

    while True:
        list_.append(i)
        i += k

        if c:
            cond = n <= i <= p - q
        else:
            cond = n >= i >= p - q

        if not cond:
            break

    return list_


def somme(liste):
    s = 0
    for val in liste:
        s += val
    return s


def maximum(liste):
    m = liste[-1]
    for val in liste:
        if val > m:
            m = val
    return m


for i in range(4, -4, -1):
    if i:
        liste_ = range_(i, 10 * (i + 1), i)
        liste__ = list(range(i, 10 * (i + 1), i))
        print(liste__ == liste_, end="  <==  range\n")
        if liste_:
            print(somme(liste_) == sum(liste_) and maximum(liste_) == max(liste_), end=" <===  max and sum\n")

from random import sample

liste = sample(range_(100), 10)
print(liste, somme(liste), sum(liste), maximum(liste), max(liste))


def remove(liste, value):
    for i in range(len(liste)):
        if liste[i] == value:
            del liste[i]
            break
    return liste


def pop(liste, index):
    m = liste[index]
    del liste[index]
    return m


def index(liste, value):
    for i in range(len(liste)):
        if liste[i] == value:
            return i


def count(liste, value):
    i = 0
    for val in liste:
        if val == value:
            i += 1
    return i


def reverse(liste):
    l = []
    for i in range(len(liste) - 1, -1, -1):
        l.append(liste[i])
    liste = l
    return liste


def reverse_(liste):
    l = liste[:]
    for i in range(len(liste)):
        liste[i] = l[len(liste) - 1 - i]
    return liste


liste = [1, 2, 3, 2, 4, 5, 3, 7, 8, 10, 11, 3]
index(liste, 3)  # rép.: 2
remove(liste, 3)
print(liste)  # rép.: [1, 2, 2, 4, 5, 3, 7, 8, 10, 11, 3]
pop(liste, 9), liste  # rép.: 11 [1, 2, 2, 4, 5, 3, 7, 8, 10, 3]
print(count(liste, 3))  # rép.: 2
reverse_(liste)
print(liste)

bissextile = [a for a in range(2000, 3001) if (a % 4 == 0) and (a % 100 != 0 or a % 400 == 0)]
print(bissextile)

xll = [[1, 2, 3], [4, 5], [6, 7, 8]]
print([x for xl in xll for x in xl])

print([d for d in range(1, 100 + 1) if 100 % d == 0])
