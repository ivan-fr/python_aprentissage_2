ALTER TABLE nom_table
ADD [CONSTRAINT fk_col_ref]         -- On donne un nom à la clé (facultatif)
    FOREIGN KEY colonne             -- La colonne sur laquelle on ajoute la clé
    REFERENCES table_ref(col_ref);  -- La table et la colonne de référence
    

ALTER TABLE nom_table
ADD [CONSTRAINT fk_col_ref]         
    FOREIGN KEY (colonne)            
    REFERENCES table_ref(col_ref)
    ON DELETE {RESTRICT | NO ACTION | SET NULL | CASCADE};  
    -- Nouvelle option !
    
alter table Animal
drop foreign key fk_race_id;


alter table Animal
add constraint fk_race_id foreign key (race_id) references Race(id) on delete set null;

DELETE FROM Race WHERE nom = 'Boxer';

SELECT Animal.nom, Animal.race_id, Race.nom as race FROM Animal
LEFT JOIN Race ON Animal.race_id = Race.id
ORDER BY race;

UPDATE Race SET id = 3 WHERE nom = 'Singapura';

-- Suppression de la clé --
-- ------------------------
ALTER TABLE Animal DROP FOREIGN KEY fk_race_id;

-- Recréation de la clé avec les bonnes options --
-- -----------------------------------------------
ALTER TABLE Animal
ADD CONSTRAINT fk_race_id FOREIGN KEY (race_id) REFERENCES Race(id)
    ON DELETE SET NULL   
        -- N'oublions pas de remettre le ON DELETE !
    ON UPDATE CASCADE;   

-- Modification de l'id des Singapura --
-- -------------------------------------
UPDATE Race SET id = 3 WHERE nom = 'Singapura';


-- Animal.mere_id --
-- -----------------
ALTER TABLE Animal DROP FOREIGN KEY fk_mere_id;

ALTER TABLE Animal
ADD CONSTRAINT fk_mere_id FOREIGN KEY (mere_id) REFERENCES Animal(id) ON DELETE SET NULL;

-- Animal.pere_id --
-- -----------------
ALTER TABLE Animal DROP FOREIGN KEY fk_pere_id;

ALTER TABLE Animal
ADD CONSTRAINT fk_pere_id FOREIGN KEY (pere_id) REFERENCES Animal(id) ON DELETE SET NULL;

-- Race.espece_id --
-- -----------------
ALTER TABLE Race DROP FOREIGN KEY fk_race_espece_id;

ALTER TABLE Race
ADD CONSTRAINT fk_race_espece_id FOREIGN KEY (espece_id) REFERENCES Espece(id) ON DELETE CASCADE;

