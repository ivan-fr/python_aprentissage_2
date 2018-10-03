SET autocommit=0;

use elevage;

INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
VALUES ('Baba', 5, '2012-02-13 15:45:00', 'F'); 
INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
VALUES ('Bibo', 5, '2012-02-13 15:48:00', 'M');
INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
VALUES ('Buba', 5, '2012-02-13 18:32:00', 'F'); 
    -- Insertion de 3 rats bruns

UPDATE Espece
SET prix = 20
WHERE id = 5;  
    -- Les rats bruns coûtent maintenant 20 euros au lieu de 10
    
SELECT * 
FROM Animal
WHERE espece_id = 5;

SELECT * 
FROM Espece 
WHERE id = 5;

ROLLBACK;

INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
VALUES ('Baba', 5, '2012-02-13 15:45:00', 'F'); 
INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
VALUES ('Bibo', 5, '2012-02-13 15:48:00', 'M');
INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
VALUES ('Buba', 5, '2012-02-13 18:32:00', 'F'); 
    -- Insertion de 3 rats bruns

COMMIT;

UPDATE Espece
SET prix = 20
WHERE id = 5;  
    -- Les rats valent 20 euros

ROLLBACK;

UPDATE Animal 
SET commentaires = 'Queue coupée'
WHERE nom = 'Bibo' AND espece_id = 5;

SET autocommit=1;

-- Insertion d'un nouveau rat brun, plus vieux
INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
VALUES ('Momy', 5, '2008-02-01 02:25:00', 'F');

-- Ouverture d'une transaction
START TRANSACTION;

-- La nouvelle rate est la mère de Buba et Baba
UPDATE Animal 
SET mere_id = LAST_INSERT_ID()
WHERE espece_id = 5
AND nom IN ('Baba', 'Buba');

-- On annule les requêtes de la transaction, ce qui termine celle-ci
ROLLBACK;

-- La nouvelle rate est la mère de Bibo
UPDATE Animal 
SET mere_id = LAST_INSERT_ID()
WHERE espece_id = 5
AND nom = 'Bibo';

-- Nouvelle transaction
START TRANSACTION;

-- Suppression de Buba
DELETE FROM Animal 
WHERE espece_id = 5
AND nom = 'Buba';

-- On valide les requêtes de la transaction, ce qui termine celle-ci
COMMIT;

START TRANSACTION;

INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
VALUES ('Popi', 5, '2007-03-11 12:45:00', 'M');

SAVEPOINT jalon1;

INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
VALUES ('Momo', 5, '2007-03-12 05:23:00', 'M');

ROLLBACK TO SAVEPOINT jalon1;

INSERT INTO Animal (nom, espece_id, date_naissance, sexe) 
VALUES ('Mimi', 5, '2007-03-12 22:03:00', 'F');

COMMIT;

START TRANSACTION; -- On ouvre une transaction

UPDATE Animal     -- On modifie Bibo
SET pere_id = 73
WHERE espece_id = 5 AND nom = 'Bibo';

SELECT id, nom, commentaires, pere_id, mere_id
FROM Animal
WHERE espece_id = 5;

commit;

