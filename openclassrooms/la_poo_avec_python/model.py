import json
import math
from collections import defaultdict  # for income graph

import matplotlib as mil

mil.use("TkAgg")
import matplotlib.pyplot as plt


class Agent:
    def __init__(self, position, **kwargs):
        self.position = position
        for attr_name, attr_value in kwargs.items():
            setattr(self, attr_name, attr_value)

    def sey_hello(self, name):
        return 'Bien le bonjour ' + name + ' !'


class Position:
    def __init__(self, latitude, longitude):
        self.latitude_degrees = latitude
        self.longitude_degrees = longitude

    @property
    def longitude(self):
        return self.longitude_degrees * math.pi / 180

    @property
    def latitude(self):
        return self.latitude_degrees * math.pi / 180


class Zone:
    ZONES = []
    MIN_LONGITUDE_DEGREES = -180
    MAX_LONGITUDE_DEGREES = 180
    MIN_LATITUDE_DEGREES = -90
    MAX_LATITUDE_DEGREES = 90
    WIDTH_DEGREES = 1
    HEIGHT_DEGREES = 1

    EARTH_RADIUS_KILOMETERS = 6371

    def __init__(self, corner1, corner2):
        self.corner1 = corner1
        self.corner2 = corner2
        self.inhabitants = []

    def add_inhabitants(self, agent):
        self.inhabitants.append(agent)

    @property
    def width(self):
        return abs(self.corner1.longitude - self.corner2.longitude) * self.EARTH_RADIUS_KILOMETERS

    @property
    def height(self):
        return abs(self.corner1.latitude - self.corner2.latitude) * self.EARTH_RADIUS_KILOMETERS

    @property
    def area(self):
        return self.width * self.height

    @property
    def population(self):
        return len(self.inhabitants)

    @property
    def average_agreableness(self):
        if not self.population:
            return 0
        return sum(inhabitant.agreeableness for inhabitant in self.inhabitants) / self.population

    @property
    def population_density(self):
        return self.population / self.area

    @classmethod
    def _initialize_zones(cls):
        for latitude in range(cls.MIN_LATITUDE_DEGREES, cls.MAX_LATITUDE_DEGREES, cls.HEIGHT_DEGREES):
            for longitude in range(cls.MIN_LONGITUDE_DEGREES, cls.MAX_LONGITUDE_DEGREES, cls.WIDTH_DEGREES):
                bottom_left_corner = Position(latitude, longitude)
                top_right_corner = Position(latitude + cls.HEIGHT_DEGREES, longitude + cls.WIDTH_DEGREES)
                cls.ZONES.append(Zone(bottom_left_corner, top_right_corner))

    @classmethod
    def find_zone_that_contains(cls, position):
        if not cls.ZONES:
            cls._initialize_zones()
        # Compute the index in the ZONES array that contains the given position
        longitude_index = int((position.longitude_degrees - cls.MIN_LONGITUDE_DEGREES) / cls.WIDTH_DEGREES)
        latitude_index = int((position.latitude_degrees - cls.MIN_LATITUDE_DEGREES) / cls.HEIGHT_DEGREES)
        longitude_bins = int((cls.MAX_LONGITUDE_DEGREES - cls.MIN_LONGITUDE_DEGREES) / cls.WIDTH_DEGREES)
        zone_index = latitude_index * longitude_bins + longitude_index

        # Just checking that the index is correct
        zone = cls.ZONES[zone_index]
        assert zone._contains(position)

        return zone

    def _contains(self, position):
        return position.longitude >= min(self.corner1.longitude, self.corner2.longitude) and \
               position.longitude < max(self.corner1.longitude, self.corner2.longitude) and \
               position.latitude >= min(self.corner1.latitude, self.corner2.latitude) and \
               position.latitude < max(self.corner1.latitude, self.corner2.latitude)


class BaseGraph:
    def __init__(self):
        self.title = "Your graph title"
        self.x_label = "X-axis label"
        self.y_label = "Y-axis label"
        self.show_grid = True

    def show(self, zones):
        # X_values
        # Y_values
        x_values, y_values = self.xy_values(zones)
        plt.plot(x_values, y_values, '.')
        plt.xlabel(self.x_label)
        plt.ylabel(self.y_label)
        plt.title(self.title)
        plt.grid(self.show_grid)
        plt.show()

    def xy_values(self, zones):
        raise NotImplementedError


class AgreeablenessGraph(BaseGraph):
    def __init__(self):
        super(AgreeablenessGraph, self).__init__()
        self.title = "nice people in the countryside"
        self.x_label = "population density"
        self.y_label = "agreeableness"

    def xy_values(self, zones):
        x_values = [zone.population_density for zone in zones]
        y_values = [zone.average_agreableness for zone in zones]
        return x_values, y_values


class IncomeGraph(BaseGraph):
    # Inheritance, yay!

    def __init__(self):
        # Call base constructor
        super(IncomeGraph, self).__init__()

        self.title = "Older people have more money"
        self.x_label = "age"
        self.y_label = "income"

    def xy_values(self, zones):
        income_by_age = defaultdict(float)
        population_by_age = defaultdict(int)
        for zone in zones:
            for inhabitant in zone.inhabitants:
                income_by_age[inhabitant.age] += inhabitant.income
                population_by_age[inhabitant.age] += 1

        x_values = range(0, 100)

        y_values = [income_by_age[age] / (population_by_age[age] or 1) for age in range(0, 100)]
        return x_values, y_values


def main():
    for agent in json.load(open('agents-100k.json')):
        latitude = agent.pop('latitude')
        longitude = agent.pop('longitude')
        position = Position(latitude, longitude)
        zone = Zone.find_zone_that_contains(position)
        zone.add_inhabitants(Agent(position, **agent))

    agreeableness_graph = AgreeablenessGraph()
    agreeableness_graph.show(Zone.ZONES)

    income_graph = IncomeGraph()
    income_graph.show(Zone.ZONES)


if __name__ == '__main__':
    main()
