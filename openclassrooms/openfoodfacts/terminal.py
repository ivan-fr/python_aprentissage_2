from mysql_operateur import Operateur

operateur = Operateur()

while True:
    recherche = input('Tapez votre recherche : ')
    if recherche == "quit":
        break

    resultat = operateur(recherche)

    if resultat:
        produit = resultat[0]
        print("==================")
        print("Résultat produit :", produit['produit_nom'], "code_bar :", produit['code_bar'])
        print("nom généric :", produit['produit_nom_generic'])
        print('nutrition grade :', produit['nutrition_grade'])
        print('categories :', produit['categories'])
        print('ingredients :', produit['ingredients'])

        for subs in resultat[1:]:
            print("========")
            print("substitut produit :", subs['produit_nom'], "code_bar :", subs['code_bar'])
            print("nom généric :", subs['produit_nom_generic'])
            print('nutrition grade :', subs['nutrition_grade'])
            print('categories :', subs['categories'])
            print('ingredients :', subs['ingredients'])


    else:
        print("Aucun résultat")
