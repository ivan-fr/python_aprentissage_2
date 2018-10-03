-- Combien de races avons-nous ? --
-- ---------------------------------
SELECT COUNT(*) AS nb_races
FROM Race;

SELECT COUNT(*) AS nb_chiens
FROM Animal 
INNER JOIN Espece ON Espece.id = Animal.espece_id
WHERE Espece.nom_courant = 'Chien';

SELECT COUNT(race_id), COUNT(*)
FROM Animal;

SELECT COUNT(DISTINCT race_id)
FROM Animal;

SELECT MIN(prix), MAX(prix)
FROM Race;

SELECT MIN(nom), MAX(nom), MIN(date_naissance), MAX(date_naissance)
FROM Animal;

SELECT SUM(prix)
FROM Espece;

SELECT AVG(prix)
FROM Espece;

SELECT SUM(prix), GROUP_CONCAT(nom_courant)
FROM Espece;

GROUP_CONCAT(
              [DISTINCT] col1 [, col2, ...]
              [ORDER BY col [ASC | DESC]]
              [SEPARATOR sep]
            )

-- --------------------------------------
-- CONCATENATION DE PLUSIEURS COLONNES --
-- --------------------------------------
SELECT SUM(Race.prix), GROUP_CONCAT(Race.nom, Espece.nom_courant)
FROM Race
INNER JOIN Espece ON Espece.id = Race.espece_id;

-- ---------------------------------------------------
-- CONCATENATION DE PLUSIEURS COLONNES EN PLUS JOLI --
-- ---------------------------------------------------
SELECT SUM(Race.prix), GROUP_CONCAT(Race.nom, ' (', Espece.nom_courant, ')')
FROM Race
INNER JOIN Espece ON Espece.id = Race.espece_id;

-- ---------------------------
-- ELIMINATION DES DOUBLONS --
-- ---------------------------
SELECT SUM(Espece.prix), GROUP_CONCAT(DISTINCT Espece.nom_courant) 
    -- Essayez sans le DISTINCT pour voir
FROM Espece
INNER JOIN Race ON Race.espece_id = Espece.id;

-- --------------------------
-- UTILISATION DE ORDER BY --
-- --------------------------
SELECT SUM(Race.prix), GROUP_CONCAT(Race.nom, ' (', Espece.nom_courant, ')' ORDER BY Race.nom DESC)
FROM Race
INNER JOIN Espece ON Espece.id = Race.espece_id;

-- ----------------------------
-- CHANGEMENT DE SEPARATEUR  --
-- ----------------------------
SELECT SUM(Race.prix), GROUP_CONCAT(Race.nom, ' (', Espece.nom_courant, ')' SEPARATOR ' - ')
FROM Race
INNER JOIN Espece ON Espece.id = Race.espece_id;
