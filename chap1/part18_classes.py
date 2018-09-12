class Polynom(object):
    def __init__(self, coefficients):
        self.coeffs = coefficients

    def __add__(self, other):
        if self.degre() < other.degre():
            self, other = other, self

        tmp = other.coeffs + [0] * (self.degre() - other.degre())
        return Polynom([a_self + a_other for a_self, a_other in zip(self.coeffs, tmp)])

    def __str__(self):
        chaine, tupl = '', ()
        for i, coeff in enumerate(self.coeffs):
            if coeff != 0:
                str_coeff = '{}'.format(coeff) if coeff > 0 else '({})'.format(coeff)
                str_exposant = '*X^{}'.format(i) if i > 0 else ''
                tupl = tupl + (str_coeff + str_exposant,)
        chaine = ' + '.join(tupl)
        return chaine if chaine != '' else '0'

    def __call__(self, x):
        an = self.coeffs[-1]
        for an_1 in reversed(self.coeffs[:-1]):
            an = an * x + an_1
        return an

    def __mul__(self, other):
        tmp = Polynom([0])
        for i_o, c_o in enumerate(other.coeffs):
            tmp += Polynom([0] * i_o + [c_o * c_s for c_s in self.coeffs])  # [0] * i_o pour respecter les familles X^i
        return tmp

    def degre(self):
        n = len(self.coeffs) - 1
        for i, coeff, in enumerate(reversed(self.coeffs)):
            if coeff != 0:
                return n - i  # i va de 0 à len(self.coeffs) - 1

        return -1

    def somme(self, other):
        n_a = self.degre()
        n_b = other.degre()
        s = (max(n_a, n_b) + 1) * [0]
        for i in range(n_a + 1):
            s[i] = self.coeffs[i]
        for i in range(n_b + 1):
            s[i] += other.coeffs[i]
        return Polynom(s)


p1 = Polynom(list(range(12, 18)))
p2 = Polynom(list(range(2, 4)))

print(p1)
print(p2)
print(p1 + p2)
print(p1.somme(p2))
print('=====')


class Rationnelle(object):
    def __init__(self, numerateur, denominateur):
        self.numer = numerateur
        self.denom = denominateur

    def __str__(self):
        return '{} / {}'.format(self.numer, self.denom)

    def __call__(self, x):
        return self.numer(x) / self.denom(x)

    def __add__(self, other):
        numerateur = self.numer * other.denom + other.numer * self.denom
        denominateur = self.denom * other.denom
        return Rationnelle(numerateur, denominateur)

    def __mul__(self, other):
        numerateur = self.numer * other.numer
        denominateur = self.denom * other.denom
        return Rationnelle(numerateur, denominateur)


class FractRationnelle(Rationnelle):

    def degre(self):
        return self.numer.degre() - self.denom.degre()


p1, p2, p3 = Polynom([1]), Polynom([-1, 1]), Polynom([1, 1])
r1, r2 = FractRationnelle(p1, p2), FractRationnelle(p1, p3)
print(r1, ' ; ', r2, ' ; ', p2 * p3)
print(r1 + r2, ';', r1 * r2)
print(r1(-1.3))
