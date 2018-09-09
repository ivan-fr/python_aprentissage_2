import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Paramètres de la fenêtre
cote_fenetre = 800

# niveaux du jeu
fichier_de_niveaux = os.path.join(BASE_DIR, "jeu_labyrinthe/niveaux.txt")

# Personnalisation de la fenêtre
titre_fenetre = "MacGyver Labyrinthe"

# Images du jeu
image_icone = os.path.join(BASE_DIR, "jeu_labyrinthe/images/dk_droite.png")
image_mur = os.path.join(BASE_DIR, "jeu_labyrinthe/images/mur.png")
image_depart = os.path.join(BASE_DIR, "jeu_labyrinthe/images/depart.png")
image_nourriture = os.path.join(BASE_DIR, "jeu_labyrinthe/images/arrivee.png")

image_joueur_down = os.path.join(BASE_DIR, "jeu_labyrinthe/images/dk_bas.png")
image_joueur_up = os.path.join(BASE_DIR, "jeu_labyrinthe/images/dk_haut.png")
image_joueur_left = os.path.join(BASE_DIR, "jeu_labyrinthe/images/dk_gauche.png")
image_joueur_right = os.path.join(BASE_DIR, "jeu_labyrinthe/images/dk_droite.png")

image_gardien_down = os.path.join(BASE_DIR, "jeu_labyrinthe/images/g_bas.png")
image_gardien_up = os.path.join(BASE_DIR, "jeu_labyrinthe/images/g_haut.png")
image_gardien_left = os.path.join(BASE_DIR, "jeu_labyrinthe/images/g_gauche.png")
image_gardien_right = os.path.join(BASE_DIR, "jeu_labyrinthe/images/g_droite.png")
