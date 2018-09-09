print(list(range(2, 15, 3)))

L = [1, 5, 3, 'a'] + [3] * 4
for i in range(len(L)):
    print('L[{}]={}'.format(i, L[i]))

for i, x in enumerate(L):
    print('L[{}]={}'.format(i, x))


def occurences(x, listes):
    print('  ===> ', [i for i, y in enumerate(listes) if x == y])


occurences(3, L)


# p = [a0, a1, a2, ..., an], (...((an * x + an_1) * x) * x + an_2)...) * x + a0)
def horner_iter(p, x):
    somme = p[-1]

    for an_1 in reversed(p[1:-1]):
        somme = an_1 + x * somme
    somme += p[0]

    return somme


print(horner_iter(list(range(4, 99, 2)), 6))


u, v = (10, 20), (21, 40)
print([t[0] + t[1] for t in zip(u, v)]) # addition vectorielle
print([pos1 + pos2 for pos1, pos2 in zip(u, v)]) # addition vectorielle


matrice = [[1, 2, 3, 4], [9, 8, 7, 6]]
transpo = list(zip(*matrice))
print(transpo)

print(sum([t[0] * t[1] for t in zip(u, v)])) # produit vectorielle
