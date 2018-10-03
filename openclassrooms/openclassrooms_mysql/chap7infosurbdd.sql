use elevage;

SHOW objets;

SHOW TABLES;

SHOW CHARACTER SET;

SHOW [FULL] COLUMNS FROM nom_table [FROM nom_bdd];

SHOW DATABASES;

SHOW GRANTS [FOR utilisateur];

SHOW INDEX FROM nom_table [FROM nom_bdd];

SHOW PRIVILEGES;

SHOW PROCEDURE STATUS;

SHOW [FULL] TABLES [FROM nom_bdd];

SHOW TRIGGERS [FROM nom_bdd];

SHOW [GLOBAL | SESSION] VARIABLES;

SHOW WARNINGS;

SHOW COLUMNS 
FROM Adoption
LIKE 'date%';


SHOW CHARACTER SET
WHERE Description LIKE '%arab%';


SHOW COLUMNS FROM nom_table;


SHOW CREATE type_objet nom_objet;


SHOW CREATE TABLE Espece;


SHOW CREATE TRIGGER before_insert_adoption;


SHOW TABLES FROM information_schema;


SHOW COLUMNS FROM VIEWS FROM information_schema;


USE information_schema; -- On sélectionne la base de données


SELECT TABLE_SCHEMA, TABLE_NAME, VIEW_DEFINITION, IS_UPDATABLE, DEFINER, SECURITY_TYPE
FROM VIEWS
WHERE TABLE_NAME = 'V_Animal_details';


SELECT CONSTRAINT_SCHEMA, CONSTRAINT_NAME, TABLE_NAME, CONSTRAINT_TYPE
FROM TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'elevage' AND TABLE_NAME = 'Animal';


SELECT ROUTINE_NAME, ROUTINE_SCHEMA, ROUTINE_TYPE, ROUTINE_DEFINITION, DEFINER, SECURITY_TYPE 
FROM ROUTINES 
WHERE ROUTINE_NAME = 'maj_vm_revenus';

use elevage;


EXPLAIN SELECT Animal.nom, Espece.nom_courant AS espece, Race.nom AS race
FROM Animal
INNER JOIN Espece ON Animal.espece_id = Espece.id
LEFT JOIN Race ON Animal.race_id = Race.id
WHERE Animal.id = 37;


EXPLAIN SELECT Animal.nom, Adoption.prix, Adoption.date_reservation
FROM Animal 
INNER JOIN Adoption ON Adoption.animal_id = Animal.id
WHERE date_reservation >= '2012-05-01';


ALTER TABLE Adoption ADD INDEX ind_date_reservation (date_reservation);


EXPLAIN SELECT * 
FROM VM_Revenus_annee_espece
WHERE somme/2 > 1000;

EXPLAIN SELECT * 
FROM VM_Revenus_annee_espece
WHERE somme > 1000*2;

