select 3, 'bonjour';
SELECT 3+5, 8/3, 10+2/2, (10+2)/2;
SELECT 1+1, 4-2, 3*6, 5/2, 5 DIV 2, 5 % 2, 5 MOD 2;

use elevage;

SELECT nom_courant, prix, 
       prix+100 AS addition, prix/2 AS division,
       prix-50.5 AS soustraction, prix%3 AS modulo
FROM Espece;

update Race
set prix = prix + 35;

SELECT MIN(tortues_perroquets.date_naissance)     -- On utilise ici une fonction !
FROM (
    SELECT Animal.id, Animal.sexe, Animal.date_naissance, Animal.nom, Animal.espece_id
    FROM Animal
    INNER JOIN Espece
        ON Espece.id = Animal.espece_id
    WHERE Espece.nom_courant IN ('Tortue d''Hermann', 'Perroquet amazone')
) AS tortues_perroquets;

-- Fonction sans paramètre
SELECT PI();    -- renvoie le nombre Pi, avec 5 décimales

-- Fonction avec un paramètre
SELECT MIN(prix) AS minimum  -- il est bien sûr possible d'utiliser les alias !
FROM Espece;

-- Fonction avec plusieurs paramètres
SELECT REPEAT('fort ! Trop ', 4);  -- répète une chaîne (ici : 'fort ! Trop ', répété 4 fois)

-- Même chose qu'au-dessus, mais avec les paramètres dans le mauvais ordre
SELECT REPEAT(4, 'fort ! Trop '); -- la chaîne de caractères 'fort ! Trop ' va être convertie en entier par MySQL, ce qui donne 0. "4" va donc être répété zéro fois...

SELECT nom, prix, ROUND(prix)
FROM Race;

SELECT MIN(prix)
FROM Race;

SELECT VERSION();

SELECT CURRENT_USER(), USER();

INSERT INTO Race (nom, espece_id, description, prix)
VALUES ('Rottweiller', 1, 'Chien d''apparence solide, bien musclé, à la robe noire avec des taches feu bien délimitées.', 600.00);

INSERT INTO Animal (sexe, date_naissance, nom, espece_id, race_id)
VALUES ('M', '2010-11-05', 'Pipo', 1, LAST_INSERT_ID());  -- LAST_INSERT_ID() renverra ici l'id de la race Rottweiller

SELECT id, nom, espece_id, prix 
FROM Race;

SELECT FOUND_ROWS();

SELECT id, nom, espece_id, prix                       -- Sans option
FROM Race 
LIMIT 3;              
         
SELECT FOUND_ROWS() AS sans_option;

SELECT SQL_CALC_FOUND_ROWS id, nom, espece_id, prix   -- Avec option
FROM Race 
LIMIT 3; 

SELECT FOUND_ROWS() AS avec_option;

SELECT *
FROM Espece
WHERE id = '3';

INSERT INTO Espece (nom_latin, nom_courant, description, prix)
VALUES ('Rattus norvegicus', 'Rat brun', 'Petite bestiole avec de longues moustaches et une longue queue sans poils', '10.00');

SELECT CAST('870303' AS DATE);

