CREATE TEMPORARY TABLE TMP_Animal (
    id INT UNSIGNED PRIMARY KEY,
    nom VARCHAR(30),
    espece_id INT UNSIGNED,
    sexe CHAR(1)
);

DESCRIBE TMP_Animal;


ALTER TABLE TMP_Animal
ADD COLUMN date_naissance DATETIME;


DROP TEMPORARY TABLE TMP_Animal;


SELECT id, sexe, nom, commentaires, espece_id 
FROM Animal
WHERE espece_id = 4;


CREATE TEMPORARY TABLE Animal (
    id INT UNSIGNED PRIMARY KEY,
    nom VARCHAR(30),
    espece_id INT UNSIGNED,
    sexe CHAR(1)
);

INSERT INTO Animal
VALUES (1, 'Tempo', 4, 'M');

SELECT * 
FROM Animal
WHERE espece_id = 4;


DROP TEMPORARY TABLE Animal;


CREATE TEMPORARY TABLE TMP_Animal (
    id INT UNSIGNED PRIMARY KEY,
    nom VARCHAR(30),
    espece_id INT UNSIGNED,
    sexe CHAR(1),
    mere_id INT UNSIGNED,
    pere_id INT UNSIGNED
);

INSERT INTO TMP_Animal
SELECT id, nom, espece_id, sexe, mere_id, pere_id 
FROM Animal
WHERE espece_id = 2;


SELECT TMP_Animal.nom, TMP_Animal.sexe
FROM TMP_Animal
WHERE nom LIKE 'B%';


SELECT TMP_Animal.nom, TMP_Pere.nom AS pere 
FROM TMP_Animal
INNER JOIN TMP_Animal AS TMP_Pere 
    ON TMP_Animal.pere_id = TMP_Pere.id;
    
    
SELECT nom
FROM TMP_Animal
WHERE id IN (SELECT pere_id FROM TMP_Animal);


START TRANSACTION;

INSERT INTO Espece (nom_courant, nom_latin)
VALUES ('Gerbille de Mongolie', 'Meriones unguiculatus');

CREATE TEMPORARY TABLE TMP_Test (id INT);

ROLLBACK;

SELECT id, nom_courant, nom_latin, prix FROM Espece;

SELECT * FROM TMP_Test;


CREATE TABLE Espece_copy
LIKE Espece;

DESCRIBE Espece;

DESCRIBE Espece_copy;


INSERT INTO Espece_copy
SELECT * FROM Espece
WHERE prix < 100;

SELECT id, nom_courant, prix 
FROM Espece_copy;

CREATE TEMPORARY TABLE Animal_copy
LIKE Animal;

INSERT INTO Animal (nom, sexe, date_naissance, espece_id)
VALUES ('Mutant', 'M', NOW(), 12);

INSERT INTO Animal_copy (nom, sexe, date_naissance, espece_id)
VALUES ('Mutant', 'M', NOW(), 12);

describe animal_copy;

drop table animal_copy;

create temporary table animal_copy
select *
from animal
where animal.espece_id = 5;


DESCRIBE Animal;

DESCRIBE Animal_copy;


DROP TABLE Animal_copy;

CREATE TEMPORARY TABLE Animal_copy (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    sexe CHAR(1),
    date_naissance DATETIME,
    nom VARCHAR(100),
    commentaires TEXT,
    espece_id INT NOT NULL,
    race_id INT,
    mere_id INT,
    pere_id INT,
    disponible BOOLEAN DEFAULT TRUE,
    INDEX (nom(10))
) ENGINE=InnoDB
SELECT *
FROM Animal
WHERE espece_id = 5;

DESCRIBE Animal_copy;


DROP TABLE Animal_copy;

CREATE TEMPORARY TABLE Animal_copy (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100),       -- Ordre différent de la requête SELECT
    sexe CHAR(1),
    espece_id INT NOT NULL, -- Ordre différent de la requête SELECT
    date_naissance DATETIME,
    commentaires TEXT,
    race_id INT,
    maman_id INT,   -- Nom de colonne différent de la requête SELECT
    papa_id INT,    -- Nom de colonne différent de la requête SELECT
    disponible BOOLEAN DEFAULT TRUE,
    INDEX (nom(10))
) ENGINE=InnoDB
SELECT id, sexe, date_naissance, nom, commentaires, espece_id, race_id, mere_id, pere_id, disponible
FROM Animal
WHERE espece_id = 5;

DESCRIBE Animal_copy;

SELECT maman_id, papa_id, id, sexe, nom, espece_id, mere_id, pere_id 
FROM Animal_copy;


DROP TABLE Animal_copy;

CREATE TEMPORARY TABLE Animal_copy (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    INDEX (nom(10))
) ENGINE=InnoDB
SELECT *
FROM Animal
WHERE espece_id = 5;

DESCRIBE Animal_copy;


CREATE TABLE Client_mini
SELECT nom, prenom, date_naissance
FROM Client;


CREATE TABLE Race_espece
SELECT Race.id, Race.nom, Espece.nom_courant AS espece, Espece.id AS espece_id
FROM Race
INNER JOIN Espece ON Espece.id = Race.espece_id;


select *
from race_espece;


CREATE TEMPORARY TABLE TMP_Adoption_chien
SELECT Animal.id AS animal_id, Animal.nom AS animal_nom, Animal.date_naissance AS animal_naissance, Animal.sexe AS animal_sexe, Animal.commentaires AS animal_commentaires,
Race.id AS race_id, Race.nom AS race_nom, 
Client.id AS client_id, Client.nom AS client_nom, Client.prenom AS client_prenom, Client.adresse AS client_adresse, 
Client.code_postal AS client_code_postal, Client.ville AS client_ville, Client.pays AS client_pays, Client.date_naissance AS client_naissance,
Adoption.date_reservation AS adoption_reservation, Adoption.date_adoption AS adoption_adoption, Adoption.prix
FROM Animal
LEFT JOIN Race ON Animal.race_id = Race.id
INNER JOIN Adoption ON Animal.id = Adoption.animal_id
INNER JOIN Client ON Client.id = Adoption.client_id
WHERE Animal.espece_id = 1;


DELIMITER |
CREATE PROCEDURE table_adoption_non_payee()
BEGIN
    DROP TEMPORARY TABLE IF EXISTS Adoption_non_payee;

    CREATE TEMPORARY TABLE Adoption_non_payee
    SELECT Client.id AS client_id, Client.nom AS client_nom, Client.prenom AS client_prenom, Client.email AS client_email,
           Animal.nom AS animal_nom, Espece.nom_courant AS espece, Race.nom AS race, 
           Adoption.date_reservation, Adoption.date_adoption, Adoption.prix
    FROM Adoption
    INNER JOIN Client ON Client.id = Adoption.client_id
    INNER JOIN Animal ON Animal.id = Adoption.animal_id
    INNER JOIN Espece ON Espece.id = Animal.espece_id
    LEFT JOIN Race ON Race.id = Animal.race_id
    WHERE Adoption.paye = FALSE; 
END |
DELIMITER ;

CALL table_adoption_non_payee();

SELECT *
FROM Adoption_non_payee;