from PIL import Image, ImageTk


def chargez_image_from_PIL(filename, resize=None):
    image = Image.open(filename)
    if resize is not None:
        image = image.resize(resize)
    return ImageTk.PhotoImage(image)


class Cell(object):
    def __init__(self, x, y, reachable):
        """Initialize new cell.
        @param reachable is cell reachable? not a wall?
        @param x cell x coordinate
        @param y cell y coordinate
        @param g cost to move from the starting cell to this cell.
        @param h estimation of the cost to move from this cell
                 to the ending cell.
        @param f f = g + h
        """
        self.reachable = reachable
        self.x = x
        self.y = y
        self.parent = None
        self.g = 0
        self.h = 0
        self.f = 0

    def __lt__(self, other):
        return self.f < other.f

    def clear(self):
        self.g = 0
        self.h = 0
        self.f = 0
        self.parent = None

