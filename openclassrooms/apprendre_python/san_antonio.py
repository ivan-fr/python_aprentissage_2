from random import randint
import json


def read_values_from_json(file, key_name):
    values = []

    with open(file) as f:
        data = json.load(f)
        for entry in data:
            values.append(entry[key_name].strip())
        return values


def get_random_item(liste):
    rand_numb = randint(0, len(liste) - 1)
    quote = liste[rand_numb]
    return quote


def random_character():
    values = read_values_from_json('characters.json', 'character')
    return get_random_item(values)


def random_quote():
    values = read_values_from_json('quotes.json', 'quotes')
    return get_random_item(values)


def message(character, quote):
    return '{} a dit : {}'.format(character, quote)


while True:
    user_answer = input('Tapez entrée pour connaître une autre citation ou B pour quitter le programme : ').upper()
    if user_answer == "B":
        break
    print(message(random_character(), random_quote()))
