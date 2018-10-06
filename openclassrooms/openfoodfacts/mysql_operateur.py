import mysql.connector
import requests
from slugify import slugify
import re


def _find_words(string):
    if string:
        cursor, i, string = 0, 0, string + " "
        while i <= len(string) - 1:
            if string[i] in (' ', '\n', ',', '.', ')'):
                if i - 1 >= cursor:
                    yield string[cursor:i]
                delta = 1
                while i + delta <= len(string) - 1:
                    if string[i + delta] not in (' ', '\n', ',', '.', '?', '!', '[', ']', '(', ')'):
                        break
                    delta += 1
                i = cursor = i + delta
            i += 1


class Operateur(object):
    search_url = "https://fr.openfoodfacts.org/cgi/search.pl"
    product_url = "http://world.openfoodfacts.org/api/v0/product/{}.json"
    stats_notes_categorie = "https://fr.openfoodfacts.org/categorie/{}/notes-nutritionnelles.json"
    product_notes_url = "https://fr.openfoodfacts.org/categorie/{}/note-nutritionnelle/{}.json"

    def __init__(self):
        self.mydb = mysql.connector.connect(host="localhost",
                                            user="openfoodfacts",
                                            passwd="hWfY7Uv82k7L9f2Sr._.",
                                            database="openfoodfacts")

        self.cursor = self.mydb.cursor()

    def get_research_result(self, recherche):
        resultat = []
        words = " ".join(_find_words(recherche))
        result_args = self.cursor.callproc('verifier_si_produit_exist', (words, 0, 0, 0))

        if not all(result_args[1:]):
            if not self._prepare_data_research(words):
                return resultat
            result_args = self.cursor.callproc('verifier_si_produit_exist', (words, 0, 0, 0))
        else:
            if not result_args[2] and not result_args[3]:
                pass

        self.cursor.callproc('get_produit_detail', (result_args[1],))

        for result in self.cursor.stored_results():
            resultat.append(dict(zip(result.column_names, result.fetchone())))

        for substitute in resultat[0]['substitutes'].split(','):
            self.cursor.callproc('get_produit_detail', (int(substitute),))

            for result in self.cursor.stored_results():
                resultat.append(dict(zip(result.column_names, result.fetchone())))

        return resultat

    def _prepare_data_research(self, words):
        payload = {'search_terms': words, 'search_simple': 1, 'action': 'process', 'page_size': 2, 'json': 1}
        r = requests.get(self.search_url, params=payload, allow_redirects=False)

        if r.status_code == 301:
            numero_produit = re.search(r'^/produit/(\d+)/?[0-9a-zA-Z_\-]*/?$', r.next.path_url).group(1)
            r = requests.get(self.product_url.format(numero_produit))
            r = r.json()['product']
        else:
            r = r.json()

            if r['count'] > 0:
                r = r['products'][0]
            else:
                return False

        categories = r['categories'].split(',')

        subsitutions = self.get_result_of_substitute_research(categories, r['nutrition_grades'])

        self._execute_product_sql_database(r, subsitutions)
        self.mydb.commit()

        return True

    def _execute_product_sql_database(self, r, subsitutions):

        sql = "INSERT INTO produit (nom, nom_generic, nutrition_grade, code_bar, code_bar_unique) " \
              "VALUES (%s, %s, %s, %s, %s);"
        val = (r['product_name'], r['generic_name'], r['nutrition_grades'], r['code'], r['code'])

        self.cursor.execute(sql, val)

        r_id = self.cursor.lastrowid

        for categorie in r.get('categories', '').split(','):
            sql = "INSERT INTO categorie (nom) VALUES (%s) ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);"
            val = (categorie,)
            self.cursor.execute(sql, val)

            _categorie_id = self.cursor.lastrowid

            sql = "INSERT INTO produit_categorie (categorie_id, produit_id) VALUES (%s, %s) " \
                  "ON DUPLICATE KEY UPDATE categorie_id = categorie_id;"
            val = (_categorie_id, r_id)
            self.cursor.execute(sql, val)

        for dico in r.get('ingredients', ''):
            sql = "INSERT INTO ingredient (nom) VALUES (%s) ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);"
            val = (dico['text'],)
            self.cursor.execute(sql, val)

            _ingredient_id = self.cursor.lastrowid

            sql = "INSERT INTO produit_ingredient (ingredient_id, produit_id) VALUES (%s, %s) " \
                  "ON DUPLICATE KEY UPDATE ingredient_id = ingredient_id;"

            val = (_ingredient_id, r_id)
            self.cursor.execute(sql, val)

        for dico in r.get('brands_tags', ''):
            sql = "INSERT INTO marque (nom, texte) VALUES (%s, %s) ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);"
            val = (dico['text'], dico['text'])
            self.cursor.execute(sql, val)

            _marque_id = self.cursor.lastrowid

            sql = "INSERT INTO produit_marque (marque_id, produit_id) VALUES (%s, %s) " \
                  "ON DUPLICATE KEY UPDATE marque_id = marque_id;"
            val = (_marque_id, r_id)
            self.cursor.execute(sql, val)

        if subsitutions is not None:
            for subsitution in subsitutions:
                subsitution_id = self._execute_product_sql_database(subsitution, None)

                sql = "INSERT INTO produit_substitute_produit (produit_id_1, produit_id_2, best) VALUES (%s, %s, %s) " \
                      "ON DUPLICATE KEY UPDATE produit_id_2 = produit_id_2;"
                val = (r_id, subsitution_id, subsitution_id)

                self.cursor.execute(sql, val)

            sql = "UPDATE produit SET research_substitutes = %s WHERE id = %s"
            val = (1, r_id)
            self.cursor.execute(sql, val)
        else:
            return r_id

    def get_result_of_substitute_research(self, categories, nutrition_grades):
        substitutes = None
        r2 = requests.get(self.stats_notes_categorie.format(slugify(max(categories))))
        r2 = r2.json()

        if r2['tags'][0]['products'] > 0 and r2['tags'][0]['id'] < nutrition_grades:
            r3 = requests.get(self.product_notes_url.format(slugify(max(categories)), r2['tags'][0]['id']))
            r3 = r3.json()
            substitutes = r3['products'][:5]

        return substitutes


if __name__ == '__main__':
    operateur = Operateur()
    operateur.get_research_result('nutella')
