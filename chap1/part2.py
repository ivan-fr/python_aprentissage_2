def f():
    print("hello")


print('bonjour')

f()


def f():
    print('hello')
    print('bonjour')


f()

x, y = 3, 10000000
z = 3.1216

print(x, y, z, sep='')
print(x, y, z, sep='; ')
print(x, y, z, sep='\n')
print('x=', x, sep='', end='; ')
print('y=', y, sep='', end='; ')
print('z=', z, sep='')

print("""voici un saut...
de ligne""")
print("-> Ici on peut employer des 'apostrophes' !")
print("-> On peut aussi\n passer à la ligne ainsi.")
print('-> Comment couper une ligne '
      'trop lngue dans le fichier source ?')

x = eval(input('Entrez une valeur pour la variable x :'))
i = 1
while i <= 10:
    print('{}^{} = {}'.format(x, i, x ** i))
    i += 1
