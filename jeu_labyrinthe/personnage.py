from jeu_labyrinthe.constants import *
from jeu_labyrinthe.utils import chargez_image_from_PIL
from jeu_labyrinthe.utils import Cell

import heapq


class Personnage(object):
    def __init__(self, canvas, cells, coords_object):
        self.canvas = canvas
        self.cells = cells

        self.cote_rectangle_x = int(COTE_FENETRE / canvas.grid_width)
        self.cote_rectangle_y = int(COTE_FENETRE / canvas.grid_height)

        self.orientation_dict = {'Left': lambda x, y: (x - 1, y),
                                 'Right': lambda x, y: (x + 1, y),
                                 'Up': lambda x, y: (x, y - 1),
                                 'Down': lambda x, y: (x, y + 1),
                                 None: lambda x, y: (x, y)}

        self.orientation = None
        self.selected_orientation = None
        self.boucle_after = None

        for direction in ('RIGHT', 'UP', 'LEFT', 'DOWN'):
            setattr(self, 'photo_' + self.__class__.__name__.lower() + '_' + direction.lower(),
                    chargez_image_from_PIL(globals()['IMAGE_' + self.__class__.__name__.upper() + '_' + direction],
                                           resize=(self.cote_rectangle_x, self.cote_rectangle_y)))

            setattr(canvas.master, 'photo_' + self.__class__.__name__.lower() + '_' + direction.lower(),
                    getattr(self, 'photo_' + self.__class__.__name__.lower() + '_' + direction.lower()))

        name_image = 'photo_' + self.__class__.__name__.lower() + '_right'
        self.image_object = self.canvas.create_image(*self.get_args_coords(*coords_object),
                                                     image=getattr(self, name_image))

        self._x, self._y = coords_object[0], coords_object[1]

    def get_cell(self, x, y):
        try:
            return self.cells[(x, y)]
        except KeyError:
            return Cell(0, 0, False)

    def stop(self):
        if self.boucle_after is not None:
            self.canvas.master.after_cancel(self.boucle_after)

    def change_direction(self, event):
        raise NotImplementedError()

    def get_args_coords(self, x, y):
        return (x * self.canvas.cote_rectangle_x + self.canvas.cote_rectangle_x / 2,
                y * self.canvas.cote_rectangle_y + self.canvas.cote_rectangle_y / 2)

    def clear_cells(self):
        for i, cell in self.cells.items():
            cell.clear()


class Astar(Personnage):
    def change_direction(self, event):
        pass

    def __init__(self, canvas, cells, coords_object):
        super(Astar, self).__init__(canvas, cells, coords_object)

        # open list
        self.opened = []
        heapq.heapify(self.opened)
        # visited cells list
        self.closed = set()
        self.start = self.get_cell(0, 0)
        self.end = self.get_cell(0, 0)

    def init_path(self, start, end):
        """Prepare path.
        @param start grid starting point x,y tuple.
        @param end grid ending point x,y tuple.
        """
        self.start = self.get_cell(*start)
        self.end = self.get_cell(*end)

    def get_heuristic(self, cell):
        """Compute the heuristic value H for a cell.
        Distance between this cell and the ending cell multiply by 10.
        @returns heuristic value H
        """
        return 10 * (abs(cell.x - self.end.x) + abs(cell.y - self.end.y))

    def get_adjacent_cells(self, cell):
        """Returns adjacent cells to a cell.
        Clockwise starting from the one on the right.
        @param cell get adjacent cells for this cell
        @returns adjacent cells list.
        """
        adjacent_cells = []

        if cell.x <= self.canvas.grid_width - 2:
            adjacent_cells.append(self.get_cell(*self.orientation_dict['Right'](cell.x, cell.y)))
        if cell.y - 1 >= 0:
            adjacent_cells.append(self.get_cell(*self.orientation_dict['Up'](cell.x, cell.y)))
        if cell.x - 1 >= 0:
            adjacent_cells.append(self.get_cell(*self.orientation_dict['Left'](cell.x, cell.y)))
        if cell.y <= self.canvas.grid_height - 2:
            adjacent_cells.append(self.get_cell(*self.orientation_dict['Down'](cell.x, cell.y)))

        return adjacent_cells

    def get_path(self):
        cell = self.end
        path = [(cell.x, cell.y)]
        while cell.parent is not self.start:
            cell = cell.parent
            path.append((cell.x, cell.y))

        # path.append((self.start.x, self.start.y))
        path.reverse()
        return path

    def update_cell(self, adj, cell):
        """Update adjacent cell.
        @param adj adjacent cell to current cell
        @param cell current cell being processed
        """
        adj.g = cell.g + 10
        adj.h = self.get_heuristic(adj)
        adj.parent = cell
        adj.f = adj.h + adj.g

    def solve(self):
        """Solve maze, find path to ending cell.
        @returns path or None if not found.
        """
        # add starting cell to open heap queue
        heapq.heappush(self.opened, (self.start.f, self.start))
        while len(self.opened):
            # pop cell from heap queue
            f, cell = heapq.heappop(self.opened)
            # add cell to closed list so we don't process it twice
            self.closed.add(cell)
            # if ending cell, return found path
            if cell is self.end:
                return self.get_path()
            # get adjacent cells for cell
            adj_cells = self.get_adjacent_cells(cell)
            for adj_cell in adj_cells:
                if adj_cell.reachable and adj_cell not in self.closed:
                    if (adj_cell.f, adj_cell) in self.opened:
                        # if adj cell in open list, check if current path is
                        # better than the one previously found
                        # for this adj cell.
                        if adj_cell.g > cell.g + 10:
                            self.update_cell(adj_cell, cell)
                    else:
                        self.update_cell(adj_cell, cell)
                        # add adj cell to open list
                        heapq.heappush(self.opened, (adj_cell.f, adj_cell))


class Joueur(Personnage):
    def __init__(self, canvas, cells, coords_joueur, sortie):
        super(Joueur, self).__init__(canvas, cells, coords_joueur)

        for direction in ('right', 'up', 'left', 'down'):
            canvas.master.bind('<' + direction.capitalize() + '>', self.change_direction)

        self.sortie = sortie
        self.joueur_move()

    def joueur_move(self):
        orientation_x, orientation_y = self.orientation_dict[self.orientation](self._x, self._y)

        if self.selected_orientation:
            selected_orientation_x, selected_orientation_y = self.orientation_dict[self.selected_orientation](self._x,
                                                                                                              self._y)

            if self.get_cell(selected_orientation_x, selected_orientation_y).reachable:
                orientation_x = selected_orientation_x
                orientation_y = selected_orientation_y

                self.orientation = self.selected_orientation
                self.selected_orientation = None

        if self.get_cell(orientation_x, orientation_y).reachable and self.orientation:
            self.canvas.coords(self.image_object, *self.get_args_coords(orientation_x, orientation_y))
            self._x, self._y = orientation_x, orientation_y
            self.canvas.master.event_generate('<<joueur_moved>>')

        if (orientation_x, orientation_y) == self.sortie:
            self.canvas.master.event_generate('<<reset>>')

        self.boucle_after = self.canvas.master.after(150, self.joueur_move)

    def change_direction(self, event):
        self.selected_orientation = event.keysym
        nom_image = 'photo_' + self.__class__.__name__.lower() + '_' + event.keysym.lower()
        self.canvas.itemconfigure(self.image_object, image=getattr(self, nom_image))


class Gardien(Astar):
    def __init__(self, canvas, cells, coords_gardien, cible):
        super(Gardien, self).__init__(canvas, cells, coords_gardien)

        self.cible = cible
        self.coord_gardien = coords_gardien

        self.path = []
        self.index_path = 0
        self.gardien_move()

    def update_cible(self):
        if self.coord_gardien != (self.cible._x, self.cible._y):
            # open list
            self.opened = []
            heapq.heapify(self.opened)
            # visited cells list
            self.closed = set()
            self.clear_cells()

            self.init_path(self.coord_gardien, (self.cible._x, self.cible._y))
            self.path = self.solve()

            self.index_path = 0

    def gardien_move(self):
        if self.coord_gardien == (self.cible._x, self.cible._y):
            self.canvas.master.event_generate('<<perdu>>')

        if self.path and self.index_path <= len(self.path) - 1:
            self.canvas.coords(self.image_object, *self.get_args_coords(*self.path[self.index_path]))
            self.coord_gardien = self.path[self.index_path]
            self.index_path += 1

        if self.coord_gardien == (self.cible._x, self.cible._y):
            self.canvas.master.event_generate('<<perdu>>')

        self.boucle_after = self.canvas.master.after(150, self.gardien_move)
