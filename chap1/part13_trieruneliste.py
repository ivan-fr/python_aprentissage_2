def maxi(l, n):
    if len(l) < n:
        raise ValueError()

    # d = [max, index]
    i, d = 1, [l[0], 0]
    while i <= n - 1:
        if l[i] > d[0]:
            d[0] = l[i]
            d[1] = i
        i += 1
    return d


def tri_selec(l):
    n = len(l)
    for i in list(range(n, 0, -1)):
        d = maxi(l, i)
        l[i - 1], l[d[1]] = l[d[1]], l[i - 1]
        print(l, d, i)

    return l


print(tri_selec([100, 9, 32, 19, 21, 41, 129, 99, 39, 28]))

print(maxi([9, 32, 19, 21, 41, 99, 39, 28, 100, 129], 7))


def insertion(l, n):
    if len(l) <= n:
        raise AttributeError()

    for j in range(n):
        if l[j] > l[n]:
            l[j:j] = [l[n]]
            del l[n + 1]
            break


def insertion_(l, n):
    if len(l) <= n:
        raise AttributeError()

    while l[n - 1] > l[n]:
        l[n], l[n - 1] = l[n - 1], l[n]
        n -= 1

        if n == 1:
            break

    return l

print(insertion_([1, 4, 5, 6, 7, 8, 2], 6))


def tri_insertion(l):
    for i in range(1, len(l)):
        insertion_(l, i)

    return l


print(tri_insertion([100, 9, 32, 19, 21, 41, 129, 99, 39, 28]))


def tri_rapide(l):
    if not l:
        return l
    print('--' * len(l), 'entrant')
    liste = tri_rapide([item for item in l if l[0] > item]) + [l[0]] + tri_rapide([item for item in l if l[0] < item])
    print('--' * len(l), 'sortant')
    return liste


print(tri_rapide([100, 9, 32, 19, 21, 41, 129, 99, 39, 28]))
