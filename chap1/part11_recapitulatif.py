########### RECAPITULATIF SUR LES PRINCIPAUX TYPES #########


# variable type scalaire (non modifiable):
# int, float, complexe, booléen

# variable †ype séquentiels
### MODIFIABLE ###
# list, dict
### NON MODIFIABLE ###
# tuple, set, str


def trouve(lettre, mot):
    for i, l in enumerate(mot):
        if l == lettre:
            return i
    return -1


print(trouve('k', 'oiztjozerezk'))
