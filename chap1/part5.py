import copy

x = ['a', 'b', 'c', [1, 2, 3, 4, 5]]
y = x
z = x[:]
w = copy.deepcopy(x)

x[-1][0] = 'a'
w[-1][-1] = 'p'

print(x, y, z, w, sep='\n')

liste = ['x', 'y', 'z', 'w']
for e in liste:
    print('id({}) = {}'.format(e, id(eval(e))))
    for ee in eval(e):
        print('     id({}) = {}'.format(str(ee), id(ee)))

# saucissonage
liste = [12, 11, 18, 7, 15, 3]
print(liste[-5: -1], liste[1: 4])

liste = [12]
print(liste, id(liste))
liste = liste + [5]
print(liste, id(liste))

liste = [12]
print(liste, id(liste))
liste += [5]
print(liste, id(liste))

liste = ['a', 'b', 'c', 'd', 'e', 'f', 'g']


def existe(liste, value):
    for e in liste:
        if e == value:
            return True
    return False


print(existe(liste, 'b'))
