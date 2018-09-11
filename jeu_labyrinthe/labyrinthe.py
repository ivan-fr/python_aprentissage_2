from tkinter import *
from functools import partial

from jeu_labyrinthe.constants import *
from jeu_labyrinthe.utils import chargez_image_from_PIL
from jeu_labyrinthe.personnage import Joueur, Gardien
from jeu_labyrinthe.utils import Cell


class Main(Tk):
    def __init__(self):
        super(Main, self).__init__()
        self.title = titre_fenetre

        self.score = IntVar(0)
        self.score_label = Label(self, text="score " + str(self.score.get()))
        self.score_label.grid(row=0, column=0)

        self.menu = Menu(self)
        self.menu.grid(row=1, column=1)

        self.labyrinthe = Labyrinthe(self)
        self.labyrinthe.remplir_structures(self.menu.get_choices())
        self.labyrinthe.grid(row=1, column=0)

        self.bind('<<update_labyrinthe>>', self.update_labyrinthe)
        self.bind('<<reset>>', self.reset)

        self.mainloop()

    def update_labyrinthe(self, event):
        self.labyrinthe.dessiner(self.menu.get_niveau())

    def reset(self, event):
        self.score.set(self.score.get() + 50)
        self.score_label.config(text="score " + str(self.score.get()))
        self.menu.niveau_suivant()


class Menu(Frame):
    def __init__(self, master):
        super(Menu, self).__init__(master=master)

        self.choices = 'niveau1', 'niveau2'
        self.variable_niveau = StringVar(master)
        self.master = master

        Label(self, text="Menu").grid(row=0, column=0)
        self.label_principal = Label(self, text="Choisi ton niveau de jeu : " + self.variable_niveau.get())
        self.label_principal.grid(row=1, column=0)

        for i, choice in enumerate(self.choices, 2):
            label = Label(self, text=choice)
            radiobutton = Radiobutton(self, variable=self.variable_niveau, value=choice,
                                      command=partial(self.update_variables))
            label.grid(row=i, column=0)
            radiobutton.grid(row=i, column=1)

    def update_variables(self):
        self.label_principal.config(text="Choisi ton niveau de jeu : " + self.get_niveau())
        self.master.event_generate('<<update_labyrinthe>>')

    def get_niveau(self):
        return self.variable_niveau.get()

    def get_choices(self):
        return self.choices

    def niveau_suivant(self):
        index = self.choices.index(self.get_niveau())
        self.variable_niveau.set(self.choices[(index + 1) % len(self.choices)])
        self.label_principal.config(text="Choisi ton niveau de jeu : " + self.variable_niveau.get())
        self.master.event_generate('<<update_labyrinthe>>')


class Labyrinthe(Canvas):
    def __init__(self, master):
        super(Labyrinthe, self).__init__(master=master)

        self.configure(width=0, height=0)
        self.structures = {}

        self.grid_width = 0
        self.grid_height = 0
        self.cote_rectangle_x = 0
        self.cote_rectangle_y = 0

        self.joueur = None
        self.gardiens = []

        self.master.bind('<<joueur_moved>>', self.dispatch_gardiens)
        self.master.bind('<<perdu>>', self.perdu)

    def remplir_structures(self, niveaux):
        with open(fichier_de_niveaux, "r") as fichier:

            active_colonne_boucle, niveau_dans_la_boucle = True, None

            for ligne in fichier:
                for niveau in niveaux:
                    if niveau in ligne:
                        active_colonne_boucle = False
                        self.structures[niveau] = []
                        niveau_dans_la_boucle = niveau
                        break

                if not active_colonne_boucle:
                    active_colonne_boucle = True
                    continue

                structure_ligne, ratio_y = [], 0
                for colonne in ligne:
                    if colonne != "\n":
                        structure_ligne.append(colonne)

                self.structures[niveau_dans_la_boucle].append(structure_ligne)

    def dessiner(self, niveau):
        self.delete("all")
        if self.joueur or self.gardiens:
            self.stop()
        cells = {}
        self.joueur = None
        self.gardiens = []

        structure = self.structures[niveau]

        self.grid_width = len(structure[0])  # colonne
        self.grid_height = len(structure)  # ligne
        self.cote_rectangle_x = int(cote_fenetre / self.grid_width)
        self.cote_rectangle_y = int(cote_fenetre / self.grid_height)

        self.configure(width=cote_fenetre, height=cote_fenetre)

        for name in ('mur', 'nourriture', 'depart'):
            setattr(self, 'photo_' + name,
                    chargez_image_from_PIL(globals()['image_' + name],
                                           resize=(self.cote_rectangle_x, self.cote_rectangle_y)))

            setattr(self.master, 'photo_' + name, getattr(self, 'photo_' + name))

        coords_joueur, coords_gardiens, coords_sortie = (), [], ()

        i = 0
        while i <= self.grid_height - 1:  # ligne
            x = i * self.cote_rectangle_x + self.cote_rectangle_x / 2
            j = 0
            while j <= self.grid_width - 1:  # colonne
                y = j * self.cote_rectangle_y + self.cote_rectangle_y / 2

                if structure[i][j] == 'm':
                    reachable = False
                    self.create_image(x, y, image=self.master.photo_mur)
                else:
                    reachable = True
                if structure[i][j] == 'j':
                    coords_joueur = (i, j)
                elif structure[i][j] == 'g':
                    coords_gardiens.append((i, j))
                elif structure[i][j] == 'a':
                    coords_sortie = (i, j)
                    self.create_image(x, y, image=self.master.photo_nourriture)
                cells[(i, j)] = Cell(i, j, reachable)

                j += 1
            i += 1

        self.joueur = Joueur(self, cells, coords_joueur, coords_sortie)
        for coords_gardien in coords_gardiens:
            self.gardiens.append(Gardien(self, cells, coords_gardien, self.joueur))

    def dispatch_gardiens(self, event):
        for gardien in self.gardiens:
            gardien.update_cible()

    def perdu(self, event):
        text = self.create_text(cote_fenetre / 2, 20, anchor=CENTER, text="Perdu !!!", fill="black",
                                font="Arial 25 bold")
        rectangle = self.create_rectangle(self.bbox(text), fill="white")
        self.tag_lower(rectangle, text)
        self.stop()

    def stop(self):
        self.joueur.stop()
        for gardien in self.gardiens:
            gardien.stop()


if __name__ == '__main__':
    Main()
