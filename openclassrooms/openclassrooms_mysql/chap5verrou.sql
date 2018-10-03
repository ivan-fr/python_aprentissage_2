use elevage;

LOCK TABLES Espece READ,              
            -- On pose un verrou de lecture sur Espece
            Adoption AS adopt WRITE;  
            -- et un verrou d'écriture sur Adoption avec l'alias adopt
            
SELECT id, nom_courant FROM Espece;

SELECT id, nom_courant 
FROM Espece AS table_espece;

UPDATE Espece
SET description = 'Petit piaf bruyasnt' 
WHERE id = 4;

SELECT client_id, animal_id 
FROM Adoption;

SELECT client_id, animal_id 
FROM Adoption AS adopt
WHERE client_id = 4;

UPDATE Adoption
SET paye = 0 
WHERE client_id = 10 AND animal_id = 49;

UPDATE Adoption AS adopt
SET paye = 0
WHERE client_id = 10 AND animal_id = 49;

UNLOCK TABLES; -- On relâche d'abord les deux verrous précédents

LOCK TABLES Adoption READ;
LOCK TABLES Espece READ, Espece AS table_espece READ;

SELECT id, nom_courant FROM Espece;

SELECT id, nom_courant FROM Espece AS table_espece;

SELECT id, nom_courant FROM Espece AS table_esp;

SELECT * FROM Adoption;

LOCK TABLES Client READ,        
            -- Verrou de lecture sur Client 
            Adoption WRITE;     
            -- Verrou d'écriture sur Adoption
		
        
SET autocommit = 0;
LOCK TABLES Adoption WRITE; 
    -- La validation implicite ne commite rien puisque aucun changement n'a été fait

UPDATE Adoption SET date_adoption = NOW() WHERE client_id = 9 AND animal_id = 54;
SELECT client_id, animal_id, date_adoption FROM Adoption WHERE client_id = 9;

ROLLBACK;
UNLOCK TABLES; 
    -- On a annulé les changements juste avant donc la validation implicite n'a aucune conséquence
SELECT client_id, animal_id, date_adoption FROM Adoption WHERE client_id = 9;
SET autocommit = 1;


SELECT * FROM Animal WHERE espece_id = 5 LOCK IN SHARE MODE;

SELECT * FROM Animal WHERE espece_id = 5 FOR UPDATE;

START TRANSACTION;

UPDATE Client SET pays = 'Suisse'
WHERE id = 8;           
    -- un verrou exclusif sera posé sur la ligne avec id = 8

commit;

START TRANSACTION;

UPDATE Adoption SET paye = 0
WHERE client_id = 11;

START TRANSACTION;

INSERT INTO Adoption (client_id, animal_id, date_reservation, prix)
VALUES (12, 75, NOW(), 10.00);

commit;

START TRANSACTION;

SELECT * FROM Client
WHERE id < 5
LOCK IN SHARE MODE;

commit;

START TRANSACTION;

SELECT * FROM Client
WHERE id < 5
FOR UPDATE;

commit;
SET SQL_SAFE_UPDATES = 0;

START TRANSACTION;
UPDATE Animal 
SET commentaires = CONCAT_WS(' ', 'Animal fondateur.', commentaires) -- On ajoute une phrase de commentaire
WHERE date_naissance < '2007-01-01';                                 -- à tous les animaux nés avant 2007

rollback;

SHOW INDEX FROM Animal;

START TRANSACTION;
UPDATE Animal  -- Modification de tous les rats
SET commentaires = CONCAT_WS(' ', 'Très intelligent.', commentaires)
WHERE espece_id = 5;

rollback;

START TRANSACTION;

SELECT * FROM Adoption WHERE client_id > 13 FOR UPDATE; 
    -- ne pas oublier le FOR UPDATE pour poser le verrou
rollback;


START TRANSACTION;

SELECT Animal.id, Animal.nom, Animal.date_naissance, Race.nom as race, COALESCE(Race.prix, Espece.prix) as prix
FROM Animal
INNER JOIN Espece ON Animal.espece_id = Espece.id
LEFT JOIN Race ON Animal.race_id = Race.id             
    -- Jointure externe, on ne veut pas que les chats de race
WHERE Espece.nom_courant = 'Chat'                      
    -- Uniquement les chats...
AND Animal.id NOT IN (SELECT animal_id FROM Adoption)  
    -- ... qui n'ont pas encore été adoptés
LOCK IN SHARE MODE;

INSERT INTO Adoption (client_id, animal_id, date_reservation, prix, paye)
SELECT id, 8, NOW(), 735.00, 1
FROM Client
WHERE email = 'jean.dupont@email.com';

COMMIT;

START TRANSACTION;

UPDATE Race 
SET prix = 0 
WHERE id = 7;

rollback;

