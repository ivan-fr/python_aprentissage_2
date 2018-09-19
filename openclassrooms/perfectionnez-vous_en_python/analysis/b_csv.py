from os import path
import pandas as pd
import numpy
import matplotlib
import pprint

matplotlib.use('TkAgg')
import matplotlib.pyplot as plt


class SetOfParliamentMembers:
    def __init__(self, name):
        self.name = name
        self.dataframe = None

    def __len__(self):
        return len(self.dataframe)

    def __repr__(self):
        return self.__class__.__name__ + ' : {} menbers'.format(len(self.dataframe))

    def __str__(self):
        names = []  ## todo: remplacer a la fin par une comprehension
        for row_index, mp in self.dataframe.iterrows():  ##todo: ici il y a du packing/unpacking
            names += [mp.nom]
        return str(names)  # Python knows how to convert a list into a string

    def __contains__(self, mp_name):
        return mp_name in self.dataframe["nom"].values

    def __getitem__(self, index):
        try:
            result = dict(self.dataframe.iloc[index])
        except:
            if index < 0:
                raise Exception("Please select a positive index")
            elif index >= len(self.dataframe):
                raise Exception("There are only {} MPs!".format(len(self.dataframe)))
            else:
                raise Exception("Wrong index")
        return result

    def __add__(self, other):
        if not isinstance(other, SetOfParliamentMembers):
            raise Exception("Can not add a SetOfParliamentMember with an object of type {}".format(type(other)))

        df1, df2 = self.dataframe, other.dataframe  ##todo: ici il y a du packing/unpacking
        df = df1.append(df2)
        df = df.drop_duplicates()

        s = SetOfParliamentMembers("{} - {}".format(self.name, other.name))
        s.data_from_dataframe(df)
        return s

    def __iter__(self):
        self.iterator_state = 0

    def __next__(self):
        if self.iterator_state >= len(self):
            raise StopIteration()
        result = self[self.iterator_state]
        self.iterator_state += 1
        return result

    def __radd__(self, other):  ## todo: l'implementation de cette methode ne suit a mon avis pas les bonnes pratiques
        return self

    # The following 2 methods are a way to simulate a calculated attribute
    # (attribute 'number_of_mps' is calculated from attribute 'self.dataframe')
    # There is a much better way to do it, using decorator '@property'
    def __getattr__(self, attr):
        if attr == "number_of_mps":  ##todo: faire la version avec @property
            return len(self.dataframe)

    def __setattr__(self, attr, value):
        if attr == "number_of_mps":
            raise Exception("You can not set the number of MPs!")
        self.__dict__[attr] = value  ## todo: c'est l'occasion de parler de __dict__ dans le cours ;)

    def data_from_csv(self, csv_file):
        self.dataframe = pd.read_csv(csv_file, sep=";")

    def data_from_dataframe(self, dataframe):
        self.dataframe = dataframe

    def display_chart(self):
        data = self.dataframe
        female_mps = data[data.sexe == "F"]
        male_mps = data[data.sexe == "H"]

        counts = [len(female_mps), len(male_mps)]
        counts = numpy.array(counts)
        nb_mps = counts.sum()
        proportions = counts / nb_mps

        labels = ["Female ({})".format(counts[0]), "Male ({})".format(counts[1])]

        fig, ax = plt.subplots()
        ax.axis("equal")
        ax.pie(
            proportions,
            labels=labels,
            autopct="%1.1f%%"
        )
        plt.title("{} ({} mps)".format(self.name, nb_mps))
        plt.show()

    def split_by_political_party(self):
        result = {}

        data = self.dataframe
        parties = data.parti_ratt_financier.dropna().unique()

        for parti in parties:
            datasubset = data[data.parti_ratt_financier == parti]
            object = SetOfParliamentMembers('MPS from : {}'.format(parti))
            object.data_from_dataframe(datasubset)
            result[parti] = object

        return result


def launch_analysis(data_file, by_party=False, info=False, displaynames=False,
                    searchname=None, index=None, groupfirst=None):

    sopm = SetOfParliamentMembers("All MPs")
    directory = path.dirname(path.dirname(__file__))
    sopm.data_from_csv(path.join(directory, "data", data_file))
    sopm.display_chart()

    if by_party:
        for party, object_ in sopm.split_by_political_party().items():
            object_.display_chart()

    if info:
        print(sopm)

    if displaynames:
        print()
        print(sopm)

    if searchname is not None:
        is_present = searchname in sopm
        print()
        print("Testing if {} is present: {}".format(searchname, is_present))

    if index is not None:
        index = int(index)
        print()
        pprint.pprint(sopm[index])  # prints the dict a nice way

    if groupfirst is not None:
        groupfirst = int(groupfirst)
        parties = sopm.split_by_political_party()
        parties = parties.values()
        parties_by_size = sorted(parties, reverse=True)

        print()
        print("Info: the {} biggest groups are :".format(groupfirst))
        for p in parties_by_size[0:groupfirst]:
            print(p.name)

        s = sum(parties_by_size[0:groupfirst])

        s.display_chart()




if __name__ == '__main__':
    launch_analysis('current_mps.csv', True)