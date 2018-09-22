USE elevage;


CREATE TABLE ma_tablr (
    id INT KEY,
    espece VARCHAR(40) UNIQUE
)
ENGINE=INNODB;

CREATE TABLE Animal (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    espece VARCHAR(40) NOT NULL,
    sexe CHAR(1),
    date_naissance DATETIME NOT NULL,
    nom VARCHAR(30),
    commentaires TEXT,
    PRIMARY KEY (id),
    INDEX ind_date_naissance (date_naissance),  -- index sur la date de naissance
    INDEX ind_nom (nom(10)) , -- index sur le nom (le chiffre entre parenthèses étant le nombre de caractères pris en compte)
    UNIQUE INDEX ind_uni_nom_espece (nom, espece)  -- Index sur le nom et l'espece
)
ENGINE=INNODB;


DESCRIBE Animal;

ALTER TABLE Animal
ADD INDEX ind_nom (nom);

DESCRIBE Animal;

ALTER TABLE Test_tuto
ADD INDEX ind_nom (nom);

ALTER TABLE nom_table
ADD INDEX [nom_index] (colonne_index [, colonne2_index ...]); --Ajout d'un index simple

ALTER TABLE nom_table
ADD UNIQUE [nom_index] (colonne_index [, colonne2_index ...]); --Ajout d'un index UNIQUE

ALTER TABLE nom_table
ADD FULLTEXT [nom_index] (colonne_index [, colonne2_index ...]); --Ajout d'un index FULLTEXT

CREATE INDEX nom_index
ON nom_table (colonne_index [, colonne2_index ...]);  -- Crée un index simple

CREATE UNIQUE INDEX nom_index
ON nom_table (colonne_index [, colonne2_index ...]);  -- Crée un index UNIQUE

CREATE FULLTEXT INDEX nom_index
ON nom_table (colonne_index [, colonne2_index ...]);  -- Crée un index FULLTEXT

CREATE TABLE nom_table (
    colonne1 INT NOT NULL,
    colonne2 VARCHAR(40),
    colonne3 TEXT,
    CONSTRAINT [symbole_contrainte] UNIQUE [INDEX] ind_uni_col2 (colonne2)
);


ALTER TABLE animal
DROP INDEX ind_nom;

DESCRIBE animal;


SELECT *
FROM Livre
WHERE MATCH(titre)
AGAINST ('+petit* -prose' IN BOOLEAN MODE); -- mix d'un astérisque avec les + et -

SELECT *
FROM Livre
WHERE MATCH(titre, auteur)
AGAINST ('Daniel');

SELECT *
FROM Livre
WHERE MATCH(titre, auteur)
AGAINST ('Daniel' WITH QUERY EXPANSION);