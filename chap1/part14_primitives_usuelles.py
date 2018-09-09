from math import log10


def nbre_chiffres(n):
    return int(log10(n)) + 1


def part_int_inf(d):
    if d >= 0:
        return int(d)
    else:
        return int(d) - 1


print(part_int_inf(-3.1))
