import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Paramètres de la fenêtre
COTE_FENETRE = 800

# niveaux du jeu
FICHIER_DE_NIVEAUX = os.path.join(BASE_DIR, "jeu_labyrinthe/niveaux.txt")

# Personnalisation de la fenêtre
TITRE_FENETRE = "MacGyver Labyrinthe"

# Images du jeu
IMAGE_ICONE = os.path.join(BASE_DIR, "jeu_labyrinthe/images/dk_droite.png")
IMAGE_MUR = os.path.join(BASE_DIR, "jeu_labyrinthe/images/mur.png")
IMAGE_DEPART = os.path.join(BASE_DIR, "jeu_labyrinthe/images/depart.png")
IMAGE_NOURRITURE = os.path.join(BASE_DIR, "jeu_labyrinthe/images/arrivee.png")

IMAGE_JOUEUR_DOWN = os.path.join(BASE_DIR, "jeu_labyrinthe/images/dk_bas.png")
IMAGE_JOUEUR_UP = os.path.join(BASE_DIR, "jeu_labyrinthe/images/dk_haut.png")
IMAGE_JOUEUR_LEFT = os.path.join(BASE_DIR, "jeu_labyrinthe/images/dk_gauche.png")
IMAGE_JOUEUR_RIGHT = os.path.join(BASE_DIR, "jeu_labyrinthe/images/dk_droite.png")

IMAGE_GARDIEN_DOWN = os.path.join(BASE_DIR, "jeu_labyrinthe/images/g_bas.png")
IMAGE_GARDIEN_UP = os.path.join(BASE_DIR, "jeu_labyrinthe/images/g_haut.png")
IMAGE_GARDIEN_LEFT = os.path.join(BASE_DIR, "jeu_labyrinthe/images/g_gauche.png")
IMAGE_GARDIEN_RIGHT = os.path.join(BASE_DIR, "jeu_labyrinthe/images/g_droite.png")
