from tkinter import *
from random import randint, choice
import itertools


class serpent(object):
    def __init__(self):
        self.interrupteur = 0

        self.canX = self.canY = 800
        self.ratio = 20
        self.cote = self.canX / self.ratio

        self.fen = Tk()
        self.canvas = Canvas(self.fen, bg='dark gray', height=self.canX, width=self.canY)
        self.canvas.pack(padx=10, pady=10)

        bou1 = Button(self.fen, text="Start", width=10, command=self.start_it)
        bou1.pack(side=LEFT)
        bou2 = Button(self.fen, text="Stop", width=10, command=self.stop_it)
        bou2.pack(side=LEFT)

        self.fen.bind("<Left>", self.change_direction)
        self.fen.bind("<Right>", self.change_direction)
        self.fen.bind("<Up>", self.change_direction)
        self.fen.bind("<Down>", self.change_direction)

        self.matrice_orientation = {'Left': [-1 * self.cote, 0],  # left
                                    'Right': [1 * self.cote, 0],  # right
                                    'Up': [0, -1 * self.cote],  # top
                                    'Down': [0, 1 * self.cote]}  # down
        self.incompatible_orientation = {'Left': 'Right', 'Right': 'Left', 'Up': 'Down', 'Down': 'Up'}
        self.orientation = (self.matrice_orientation['Up'], 'Up')

        self.serpents = []

        x = 0
        while x <= self.canX:
            y = 0
            while y <= self.canX:
                self.canvas.create_rectangle(x, y, x + self.cote, y + self.cote, fill="yellow")
                y += self.cote
            x += self.cote

        i = 0
        x, y = randint(0, self.ratio - 1) * self.cote, randint(0, self.ratio - 1) * self.cote
        while i <= 4:
            self.serpents.append(self.canvas.create_rectangle(*self.get_args_coords(x, y), fill="green"))
            x += self.orientation[0][0]
            y += self.orientation[0][1]
            i += 1

        self.coords_nourriture = ()
        self.nourriture = self.create_nourriture()

        self.fen.mainloop()

    def start_it(self):
        if self.interrupteur == 0:
            self.interrupteur = 1
            self.move()

    def stop_it(self):
        self.interrupteur = 0

    def change_direction(self, event):
        if self.incompatible_orientation[self.orientation[1]] != event.keysym:
            self.orientation = self.matrice_orientation[event.keysym], event.keysym

    def move(self):

        coords = self.canvas.coords(self.serpents[len(self.serpents) - 1])
        _x, _y = coords[0], coords[1]

        _x += self.orientation[0][0]
        _y += self.orientation[0][1]
        coords = self.get_args_coords(_x, _y)

        if self.coords_nourriture == (int(coords[0]), int(coords[1])):
            self.serpents.append(self.canvas.create_rectangle(*self.get_args_coords(_x, _y), fill="green"))
            self.canvas.delete(self.nourriture)
            self.nourriture = self.create_nourriture()
        else:
            _i = 0
            while _i <= len(self.serpents) - 1:

                if len(self.serpents) - 1 == _i:
                    liste = self.get_incompatible_coords()
                    self.canvas.coords(self.serpents[_i], *coords)
                    if (coords[0], coords[1]) in liste:
                        self.interrupteur = 0
                        self.canvas.create_text(self.canX / 2, 20, anchor=CENTER, text="Perdu !!!",
                                                fill="red", font="Arial 14 bold")
                else:
                    next_serpent_coords = self.canvas.coords(self.serpents[_i + 1])
                    self.canvas.coords(self.serpents[_i],
                                       *self.get_args_coords(next_serpent_coords[0], next_serpent_coords[1]))

                _i += 1

        if self.interrupteur > 0:
            self.fen.after(80, self.move)

    def get_incompatible_coords(self):
        _i, i_coords = 0, []
        while _i <= len(self.serpents) - 1:
            coords = self.canvas.coords(self.serpents[_i])
            i_coords.append((coords[0], coords[1]))
            _i += 1
        return i_coords

    def get_args_coords(self, x, y):
        return x % self.canX, y % self.canX, x % self.canX + self.cote, y % self.canX + self.cote

    def create_nourriture(self):
        liste = self.get_incompatible_coords()

        _liste = ((item[0] * self.cote, item[1] * self.cote) for item in itertools.product(range(self.ratio), repeat=2))

        __liste = [item for item in _liste if item not in liste]
        x, y = choice(__liste)
        self.coords_nourriture = int(x), int(y)
        return self.canvas.create_oval(*self.get_args_coords(x, y), fill="red")


if __name__ == '__main__':
    serpent()
