CREATE TRIGGER nom_trigger moment_trigger evenement_trigger
ON nom_table FOR EACH ROW
corps_trigger;


INSERT INTO Adoption (client_id, animal_id, date_reservation, prix, paye) 
VALUES (12, 15, NOW(), 200.00, FALSE);


UPDATE Adoption 
SET paye = TRUE
WHERE client_id = 12 AND animal_id = 15;


-- Trigger déclenché par l'insertion
DELIMITER |
CREATE TRIGGER before_insert_animal BEFORE INSERT
ON Animal FOR EACH ROW
BEGIN
END |

DELIMITER |
-- Trigger déclenché par la modification
CREATE TRIGGER before_update_animal BEFORE UPDATE
ON Animal FOR EACH ROW
BEGIN
	if new.sexe is not null and new.sexe != 'M' and new.sexe != 'F'
    then
		set new.sexe = null;
	end if;
END |
DELIMITER ;


UPDATE Animal
SET sexe = 'A'
WHERE id = 20;  -- l'animal 20 est Balou, un mâle

SELECT id, sexe, date_naissance, nom 
FROM Animal 
WHERE id = 20;


CREATE TABLE Erreur (
    id TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    erreur VARCHAR(255) UNIQUE);

-- Insertion de l'erreur qui nous intéresse
INSERT INTO Erreur (erreur) VALUES ('Erreur : sexe doit valoir "M", "F" ou NULL.');


-- Création du trigger
DELIMITER |
CREATE TRIGGER before_insert_animal BEFORE INSERT
ON Animal FOR EACH ROW
BEGIN
    IF NEW.sexe IS NOT NULL   -- le sexe n'est ni NULL
    AND NEW.sexe != 'M'       -- ni "M"
    AND NEW.sexe != 'F'       -- ni "F"
      THEN
        INSERT INTO Erreur (erreur) VALUES ('Erreur : sexe doit valoir "M", "F" ou NULL.');
    END IF;
END |
DELIMITER ;


INSERT INTO Animal (nom, sexe, date_naissance, espece_id)
VALUES ('Babar', 'A', '2011-08-04 12:34', 3);


INSERT INTO Erreur (erreur) VALUES ('Erreur : paye doit valoir TRUE (1) ou FALSE (0).');


DELIMITER |
CREATE TRIGGER before_insert_adoption BEFORE INSERT
ON Adoption FOR EACH ROW
BEGIN
    IF NEW.paye != 0 AND NEW.paye != 1     
	THEN
		INSERT INTO Erreur (erreur) VALUES ('Erreur : paye doit valoir TRUE (1) ou FALSE (0).');
	ELSEIF NEW.date_adoption < NEW.date_reservation
    THEN
		INSERT INTO Erreur (erreur) VALUES ('Erreur : date_adoption doit être >= à date_reservation.');
    END IF;
END |
DELIMITER ;


DELIMITER |
CREATE TRIGGER before_update_adoption BEFORE UPDATE
ON Adoption FOR EACH ROW
BEGIN
    IF NEW.paye != 0 AND NEW.paye != 1     
	THEN
		INSERT INTO Erreur (erreur) VALUES ('Erreur : paye doit valoir TRUE (1) ou FALSE (0).');
	ELSEIF NEW.date_adoption < NEW.date_reservation
    THEN
		INSERT INTO Erreur (erreur) VALUES ('Erreur : date_adoption doit être >= à date_reservation.');
    END IF;
END |
DELIMITER ;


UPDATE Adoption 
SET paye = 3
WHERE client_id = 9;


INSERT INTO Erreur (erreur) VALUES ('Erreur : date_adoption doit être >= à date_reservation.');

drop trigger before_update_adoption;
drop trigger before_insert_adoption;


INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
VALUES (45, 14, NOW(), NOW() - INTERVAL 2 DAY, 200.00, 0);

INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
VALUES (10, 10, NOW(), NOW(), 200.00, 4);


SELECT id, nom, sexe, date_naissance, commentaires
FROM Animal
WHERE NOT EXISTS (
    SELECT * 
    FROM Adoption 
    WHERE Animal.id = Adoption.animal_id
);


ALTER TABLE Animal ADD COLUMN disponible BOOLEAN DEFAULT TRUE;  


SET SQL_SAFE_UPDATES = 0;

update Animal
set disponible = False
where not exists (select *
							from Adoption
                            where Animal.id = Adoption.animal_id);
                            
                           
delimiter |
create trigger after_insert_adotpion after insert
on Adoption for each row
begin
	update animal
    set disponible = false
    where animal.id = NEW.animal_id;
end|


create trigger after_delete_adotpion after delete
on Adoption for each row
begin
	update animal
    set disponible = true
    where animal.id = OLD.animal_id;
end|


create trigger after_update_adotpion after update
on Adoption for each row
begin
	if old.animal_id != NEW.animal_id
    then
		update animal
		set disponible = false
		where animal.id = new.animal_id;
        
		update animal
		set disponible = true
		where animal.id = old.animal_id;
    end if;
end|
delimiter ;

SELECT animal_id, nom, sexe, disponible, client_id
FROM Animal
INNER JOIN Adoption ON Adoption.animal_id = Animal.id
WHERE client_id = 9;


DELETE FROM Adoption    -- 54 doit redevenir disponible
WHERE animal_id = 54;

UPDATE Adoption
SET animal_id = 38, prix = 985.00   -- 38 doit devenir indisponible
WHERE animal_id = 33;               -- et 33 redevenir disponible

INSERT INTO Adoption (client_id, animal_id, date_reservation, prix, paye)
VALUES (9, 59, NOW(), 700.00, FALSE);   -- 59 doit devenir indisponible

SELECT Animal.id AS animal_id, nom, sexe, disponible, client_id
FROM Animal
LEFT JOIN Adoption ON Animal.id = Adoption.animal_id
WHERE Animal.id IN (33, 54, 55, 38, 59);


SELECT *
FROM Animal
WHERE disponible = TRUE;

-- Ou même

SELECT *
FROM Animal
WHERE disponible;


-- On modifie la table Race
ALTER TABLE Race 
    ADD COLUMN date_insertion DATETIME, -- date d'insertion
    ADD COLUMN utilisateur_insertion VARCHAR(20), -- utilisateur ayant inséré la ligne
    ADD COLUMN date_modification DATETIME, -- date de dernière modification
    ADD COLUMN utilisateur_modification VARCHAR(20); -- utilisateur ayant fait la dernière modification

-- On remplit les colonnes
UPDATE Race 
SET date_insertion = NOW() - INTERVAL 1 DAY, 
    utilisateur_insertion = 'Test', 
    date_modification = NOW() - INTERVAL 1 DAY, 
    utilisateur_modification = 'Test';
    

DELIMITER |
CREATE TRIGGER before_insert_race BEFORE INSERT
ON Race FOR EACH ROW
BEGIN
    SET NEW.date_insertion = NOW();
    SET NEW.utilisateur_insertion = CURRENT_USER();
    SET NEW.date_modification = NOW();
    SET NEW.utilisateur_modification = CURRENT_USER();
END |

CREATE TRIGGER before_update_race BEFORE UPDATE
ON Race FOR EACH ROW
BEGIN
    SET NEW.date_modification = NOW();
    SET NEW.utilisateur_modification = CURRENT_USER();
END |
DELIMITER ;


INSERT INTO Race (nom, description, espece_id, prix)
VALUES ('Yorkshire terrier', 'Chien de petite taille au pelage long et soyeux de couleur bleu et feu.', 1, 700.00);

UPDATE Race 
SET prix = 630.00 
WHERE nom = 'Rottweiller' AND espece_id = 1;

SELECT nom, DATE(date_insertion) AS date_ins, utilisateur_insertion AS utilisateur_ins, DATE(date_modification) AS date_mod, utilisateur_modification AS utilisateur_mod 
FROM Race 
WHERE espece_id = 1;


CREATE TABLE Animal_histo (
  id SMALLINT(6) UNSIGNED NOT NULL,     -- Colonnes historisées
  sexe CHAR(1),
  date_naissance DATETIME NOT NULL,
  nom VARCHAR(30),
  commentaires TEXT,
  espece_id SMALLINT(6) UNSIGNED NOT NULL,
  race_id SMALLINT(6) UNSIGNED DEFAULT NULL,
  mere_id SMALLINT(6) UNSIGNED DEFAULT NULL,
  pere_id SMALLINT(6) UNSIGNED DEFAULT NULL,
  disponible BOOLEAN DEFAULT TRUE,

  date_histo DATETIME NOT NULL,         -- Colonnes techniques
  utilisateur_histo VARCHAR(20) NOT NULL,
  evenement_histo CHAR(6) NOT NULL,
  PRIMARY KEY (id, date_histo)
) ENGINE=InnoDB;


DELIMITER |
CREATE TRIGGER after_update_animal AFTER UPDATE
ON Animal FOR EACH ROW
BEGIN
    INSERT INTO Animal_histo (
        id, 
        sexe, 
        date_naissance, 
        nom, 
        commentaires, 
        espece_id, 
        race_id, 
        mere_id, 
        pere_id, 
        disponible,

        date_histo, 
        utilisateur_histo, 
        evenement_histo)
    VALUES (
        OLD.id,
        OLD.sexe,
        OLD.date_naissance,
        OLD.nom,
        OLD.commentaires,
        OLD.espece_id,
        OLD.race_id,
        OLD.mere_id,
        OLD.pere_id,
        OLD.disponible,

        NOW(),
        CURRENT_USER(),
        'UPDATE');
END |

CREATE TRIGGER after_delete_animal AFTER DELETE
ON Animal FOR EACH ROW
BEGIN
    INSERT INTO Animal_histo (
        id, 
        sexe, 
        date_naissance, 
        nom, 
        commentaires, 
        espece_id, 
        race_id, 
        mere_id, 
        pere_id, 
        disponible,

        date_histo, 
        utilisateur_histo, 
        evenement_histo)
    VALUES (
        OLD.id,
        OLD.sexe,
        OLD.date_naissance,
        OLD.nom,
        OLD.commentaires,
        OLD.espece_id,
        OLD.race_id,
        OLD.mere_id,
        OLD.pere_id,
        OLD.disponible,

        NOW(),
        CURRENT_USER(),
        'DELETE');
END |
DELIMITER ;


UPDATE Animal
SET commentaires = 'Petit pour son âge'
WHERE id = 10;

DELETE FROM Animal
WHERE id = 47;

SELECT id, sexe, date_naissance, nom, commentaires, espece_id
FROM Animal 
WHERE id IN (10, 47);

SELECT *
FROM Animal_histo;


-- On supprime les clés
ALTER TABLE Race DROP FOREIGN KEY fk_race_espece_id;
ALTER TABLE Animal DROP FOREIGN KEY fk_race_id,
                   DROP FOREIGN KEY fk_mere_id,
                   DROP FOREIGN KEY fk_pere_id;

-- On les recrée sans option
ALTER TABLE Race 
    ADD CONSTRAINT fk_race_espece_id FOREIGN KEY (espece_id) REFERENCES Espece (id);
ALTER TABLE Animal 
    ADD CONSTRAINT fk_race_id FOREIGN KEY (race_id) REFERENCES Race (id),
    ADD CONSTRAINT fk_mere_id FOREIGN KEY (mere_id) REFERENCES Animal (id),
    ADD CONSTRAINT fk_pere_id FOREIGN KEY (pere_id) REFERENCES Animal (id);

-- Trigger sur Race
DELIMITER |
CREATE TRIGGER before_delete_race BEFORE DELETE
ON Race FOR EACH ROW
BEGIN
    UPDATE Animal 
    SET race_id = NULL
    WHERE race_id = OLD.id;
END|

-- Trigger sur Espece
CREATE TRIGGER before_delete_espece BEFORE DELETE
ON Espece FOR EACH ROW
BEGIN
    DELETE FROM Race
    WHERE espece_id = OLD.id;
END |
DELIMITER ;