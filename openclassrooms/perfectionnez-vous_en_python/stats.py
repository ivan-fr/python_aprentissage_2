import numpy as np
import pandas as pd

un_panda = [100, 5, 20, 80]
un_panda_numpy = np.array(un_panda)

k = 2
un_bebe_panda = [0, 0, 0, 0]

for index in range(4):
    un_bebe_panda[index] = un_panda[index] / k

print(un_bebe_panda)

un_bebe_panda_numpy = un_panda_numpy / k
print(un_bebe_panda_numpy)

famille_panda = [
    np.array([100, 5  , 20, 80]), # maman panda
    np.array([50 , 2.5, 10, 40]), # bébé panda
    np.array([110, 6  , 22, 80]), # papa panda
]

famille_panda_numpy = np.array(famille_panda)

print(famille_panda)
print(sum(famille_panda_numpy[:, 0]))

famille_panda_df = pd.DataFrame(famille_panda_numpy, index=('maman', 'bebe', 'papa'), columns=('pattes', 'poil', 'queue', 'ventre'))

print()
print(famille_panda_df)
print(famille_panda_df.ventre.values)
print()

for index, content in famille_panda_df.iterrows():
    print("Voici le panda %s : " % (index))
    print(content)
    print("----------------")
print()

print(famille_panda_df.iloc[2])
print(famille_panda_df.loc["papa"])
print()

print(famille_panda_df['ventre'] == 80)
print()

masque = famille_panda_df['ventre'] == 80
print(famille_panda_df[masque])
print(famille_panda_df[~masque])
print()

quelques_panda = pd.DataFrame([[105,4,19,80],[100,5,20,80]], columns=famille_panda_df.columns)
tous_les_pandas = famille_panda_df.append(quelques_panda)
print(tous_les_pandas)
print()

pandas_uniques = tous_les_pandas.drop_duplicates()
print(pandas_uniques)
print()

# accéder aux noms des colonnes
print(famille_panda_df.columns)

# créer une nouvelle colonne, composée de chaînes de caractères
famille_panda_df["sexe"] = ["f", "f", "m"]
# la maman et le bébé sont des femelles, le papa est un mâle
print(famille_panda_df)
# obtenir le nombre de lignes
print(len(famille_panda_df))
print()

print(famille_panda_df.ventre.unique)
