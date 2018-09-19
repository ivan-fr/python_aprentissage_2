-- SET NAMES 'utf8';

-- SELECT "Hello World !";
-- SELECT (5+3)*2;
-- SELECT (5+3)*2, 5+3*2;

-- CREATE USER 'lol'@'localhost' IDENTIFIED BY 'hWfY7Uv82k7L9f2SrU';
-- GRANT ALL PRIVILEGES ON elevage.* TO 'lol'@'localhost';

-- CREATE DATABASE elevage CHARACTER SET 'utf8';
-- DROP DATABASE elevage

-- DROP DATABASE IF EXISTS elevage;

-- SHOW WARNINGS;

-- USE elevage;

-- CREATE TABLE Animal (
--     id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
--     espece VARCHAR(40) NOT NULL,
--     sexe CHAR(1),
--     date_naissance DATETIME NOT NULL,
--     commentaires TEXT,
--     nom VARCHAR(30),
--     PRIMARY KEY (id)
-- )
-- ENGINE=INNODB;

-- SHOW TABLES;
-- DESCRIBE Animal;

-- DROP TABLE Test_tuto;

-- CREATE TABLE Test_tuto (
--	id INT NOT NULL,
--	nom VARCHAR(10) NOT NULL,
--        PRIMARY KEY(id)
-- )
-- ENGINE=INNODB;

-- ALTER TABLE Test_tuto
-- ADD COLUMN date_insertion DATE NOT NULL;

-- DESCRIBE Test_tuto;

-- ALTER TABLE Test_tuto
-- DROP COLUMN date_insertion;

-- DESCRIBE Test_tuto;

-- ALTER TABLE Test_tuto
-- CHANGE nom prenom VARCHAR(10) NOT NULL;

-- DESCRIBE Test_tuto;

-- ALTER TABLE Test_tuto
-- CHANGE nom prenom VARCHAR(30) NOT NULL;

-- DESCRIBE Test_tuto;

-- ALTER TABLE Test_tuto
-- CHANGE id id BIGINT NOT NULL;

-- DESCRIBE Test_tuto;

-- ALTER TABLE Test_tuto
-- MODIFY id BIGINT NOT NULL AUTO_INCREMENT;

-- DESCRIBE Test_tuto;

-- ALTER TABLE Test_tuto
-- MODIFY prenom VARCHAR(30) NOT NULL DEFAULT 'blabla';
-- ALTER TABLE Test_tuto
-- MODIFY prenom VARCHAR(30) NOT NULL DEFAULT 'blabla';

-- DESCRIBE Animal;

-- INSERT INTO Animal
-- VALUES (1, 'chien', 'M', '2010-04-05 13:43:00', 'Mordille beaucoup', 'Rox');

-- INSERT INTO Animal
-- VALUES (2, 'chat', NULL, '2010-04-05 02:43:00', 'Rox', NULL);

-- INSERT INTO Animal
-- VALUES (NULL , 'chat', 'F', '2010-09-13 15:02:00', 'Schtroumpfette', NULL);

-- SELECT * FROM Animal;

-- INSERT INTO Animal (espece, sexe, date_naissance)
--     VALUES ('tortue', 'F', '2009-08-03 05:12:00');
-- INSERT INTO Animal (nom, commentaire, date_naissance, espece)
--     VALUES ('Choupi', 'Né sans oreille gauche', '2010-10-03 16:44:00', 'chat');
-- INSERT INTO Animal (espece, date_naissance, commentaire, nom, sexe)
--    VALUES ('tortue', '2009-06-13 08:17:00', 'Carapace bizarre', 'Bobosse', 'F');

-- INSERT INTO Animal (espece, sexe, date_naissance, nom)
-- VALUES ('chien', 'F', '2008-12-06 05:18:00', 'Caroline'),
--        ('chat', 'M', '2008-09-11 15:38:00', 'Bagherra'),
--        ('tortue', NULL, '2010-08-23 05:18:00', NULL);

-- MYSQL ONLY :
-- INSERT INTO Animal
-- SET nom='Bobo', espece='chien', sexe='M', date_naissance='2010-07-21 15:41:00';
