USE elevage;

DELETE FROM Animal
WHERE nom = 'Zoulou';

DELETE FROM Animal;

SELECT * FROM Animal;

SOURCE sauvergarde.sql

UPDATE Animal
SET sexe='M', nom='Pataude'
WHERE id=8;

SELECT * FROM Animal;


