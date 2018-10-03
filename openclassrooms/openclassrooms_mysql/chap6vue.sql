use elevage;

CREATE or replace VIEW V_Animal_details
AS SELECT Animal.id, Animal.sexe, Animal.date_naissance, Animal.nom, Animal.commentaires, 
       Animal.espece_id, Animal.race_id, Animal.mere_id, Animal.pere_id, Animal.disponible,
       Espece.nom_courant AS espece_nom, Race.nom AS race_nom
FROM Animal
INNER JOIN Espece ON Animal.espece_id = Espece.id
LEFT JOIN Race ON Animal.race_id = Race.id;

SHOW TABLES;


DESCRIBE V_Animal_details;


CREATE VIEW V_Chien
AS SELECT id, sexe, date_naissance, nom, commentaires, espece_id, race_id, mere_id, pere_id, disponible
FROM Animal
WHERE espece_id = 1;


CREATE OR REPLACE VIEW V_Nombre_espece
AS SELECT Espece.id, COUNT(Animal.id) AS nb
FROM Espece
LEFT JOIN Animal ON Animal.espece_id = Espece.id
GROUP BY Espece.id;


CREATE OR REPLACE VIEW V_Chien_race
AS SELECT id, sexe, date_naissance, nom, commentaires, espece_id, race_id, mere_id, pere_id, disponible
FROM V_Chien
WHERE race_id IS NOT NULL;


CREATE VIEW V_Espece_dollars
AS SELECT id, nom_courant, nom_latin, description, ROUND(prix*1.31564, 2) AS prix_dollars
FROM Espece;


CREATE VIEW V_Client
AS SELECT * 
FROM Client;


ALTER TABLE Client ADD COLUMN date_naissance DATE;

DESCRIBE V_Client;


CREATE OR REPLACE VIEW V_Race
AS SELECT Race.id, nom, Espece.nom_courant AS espece
FROM Race
INNER JOIN Espece ON Espece.id = Race.espece_id
ORDER BY nom;

SELECT * 
FROM V_Race;     
-- Sélection sans ORDER BY, on prend l'ORDER BY de la définition

SELECT * 
FROM V_Race
ORDER BY espece; 
-- Sélection avec ORDER BY, c'est celui-là qui sera pris en compte


SELECT id, nom, espece_nom, date_naissance, commentaires, disponible 
FROM V_Animal_details
WHERE espece_nom = 'Rat brun';


SELECT V_Nombre_espece.id, Espece.nom_courant, V_Nombre_espece.nb
FROM V_Nombre_espece
INNER JOIN Espece ON Espece.id = V_Nombre_espece.id;


select race.nom, count(V_Chien_race.id)
from race
inner join V_Chien_race on V_Chien_race.race_id = race.id
group by race.nom;


CREATE OR REPLACE VIEW V_Espece_dollars
AS SELECT id, nom_courant, nom_latin, description, ROUND(prix*1.30813, 2) AS prix_dollars
FROM Espece;


ALTER VIEW V_Espece_dollars
AS SELECT id, nom_courant, nom_latin, description, ROUND(prix*1.30813, 2) AS prix_dollars
FROM Espece;


DROP VIEW V_Race;


create or replace view v_revenus_annee_espece
as select year(date_reservation) as annee, Espece.id as espece_id, sum(adoption.prix) as somme, 
			   count(Adoption.animal_id) as nb
from adoption
inner join animal on adoption.animal_id = Animal.id
inner join espece on animal.espece_id = Espece.id
group by annee, Espece.id;


select *
from v_revenus_annee_espece;


SELECT annee, SUM(somme) AS total
FROM V_Revenus_annee_espece
GROUP BY annee
order by annee;


SELECT Espece.nom_courant AS espece, SUM(somme) AS total
FROM V_Revenus_annee_espece
INNER JOIN Espece ON V_Revenus_annee_espece.espece_id = Espece.id
GROUP BY espece;


SELECT Espece.nom_courant AS espece, SUM(somme)/SUM(nb) AS moyenne
FROM V_Revenus_annee_espece
INNER JOIN Espece ON V_Revenus_annee_espece.espece_id = Espece.id
GROUP BY espece;


SELECT * 
FROM V_Animal_details
WHERE MONTH(date_naissance) = 6;


-- Modifie Animal
UPDATE V_Animal_details
SET commentaires = 'Rhume chronique'
WHERE id = 21;

-- Modifie Race
UPDATE V_Animal_details 
SET race_nom = 'Maine Coon'
WHERE race_nom = 'Maine coon';

-- Erreur
UPDATE V_Animal_details 
SET commentaires = 'Vilain oiseau', espece_nom = 'Perroquet pas beau' 
-- commentaires vient de Animal, et espece_nom vient de Espece
WHERE espece_id = 4;


UPDATE V_Nombre_espece
SET nb = 6
WHERE id = 4;


CREATE VIEW V_Animal_mini
AS SELECT id, nom, sexe, espece_id
FROM Animal;


INSERT INTO V_Animal_mini(nom, sexe, espece_id)
VALUES ('Toxi', 'F', 1);


INSERT INTO V_Animal_details (espece_nom, espece_nom_latin)
VALUES ('Perruche terrestre', 'Pezoporus wallicus');


CREATE OR REPLACE VIEW V_Animal_espece
AS SELECT Animal.id, Animal.sexe, Animal.date_naissance, Animal.nom, Animal.commentaires, 
       Animal.espece_id, Animal.race_id, Animal.mere_id, Animal.pere_id, Animal.disponible,
       Espece.nom_courant AS espece_nom, Espece.nom_latin AS espece_nom_latin
FROM Animal
INNER JOIN Espece ON Espece.id = Animal.espece_id;

INSERT INTO V_Animal_espece (espece_nom, espece_nom_latin)
VALUES ('Perruche terrestre', 'Pezoporus wallicus');


CREATE VIEW V_Espece_2noms -- on référence nom_courant deux fois
AS SELECT id, nom_courant, nom_latin, description, prix, nom_courant AS nom2 
FROM Espece;

-- Modification, pas de problème
UPDATE V_Espece_2noms
SET description= 'Joli oiseau aux plumes majoritairement vert brillant', prix = 20.00
WHERE nom_courant = 'Perruche terrestre';


-- Insertion, impossible
INSERT INTO V_Espece_2noms (nom_courant, nom_latin, prix)
VALUES ('Perruche turquoisine', 'Neophema pulchella', 40);


CREATE OR REPLACE VIEW V_Chien_race
AS SELECT id, sexe, date_naissance, nom, commentaires, espece_id, race_id, mere_id, pere_id, disponible 
FROM V_Chien
WHERE race_id IS NOT NULL
WITH LOCAL CHECK OPTION;

-- Modification --
-- ------------ --
UPDATE V_Chien_race 
SET race_id = NULL  -- Ne respecte pas la condition de V_Chien_race 
WHERE nom = 'Zambo';-- => Impossible

UPDATE V_Chien_race
SET espece_id = 2, race_id = 4 -- Ne respecte pas la condition de V_Chien 
WHERE nom = 'Java';           -- => possible puisque LOCAL CHECK OPTION

-- Insertion --
-- --------- --
INSERT INTO V_Chien_race (sexe, date_naissance, nom, commentaires, espece_id, race_id)   
VALUES ('M', '2012-02-28 03:05:00', 'Pumba', 'Prématuré, à surveiller', 1, 9);           
-- Respecte toutes les conditions => Pas de problème

INSERT INTO V_Chien_race (sexe, date_naissance, nom, commentaires, espece_id, race_id)   
VALUES ('M', '2011-05-24 23:51:00', 'Lion', NULL, 2, 5);                                 
-- La race n'est pas NULL, mais c'est un chat => pas de problème puisque LOCAL

INSERT INTO V_Chien_race (sexe, date_naissance, nom, commentaires, espece_id, race_id)   
VALUES ('F', '2010-04-28 13:01:00', 'Mouchou', NULL, 1, NULL);   
-- La colonne race_id est NULL => impossible