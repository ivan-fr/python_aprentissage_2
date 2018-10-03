CREATE TABLE VM_Revenus_annee_espece
ENGINE = InnoDB
SELECT YEAR(date_reservation) AS annee, Espece.id AS espece_id, SUM(Adoption.prix) AS somme, COUNT(Adoption.animal_id) AS nb
FROM Adoption
INNER JOIN Animal ON Animal.id = Adoption.animal_id
INNER JOIN Espece ON Animal.espece_id = Espece.id
GROUP BY annee, Espece.id;


describe VM_Revenus_annee_espece;


DELIMITER |
CREATE PROCEDURE maj_vm_revenus()
BEGIN
    TRUNCATE VM_Revenus_annee_espece;

    INSERT INTO VM_Revenus_annee_espece
    SELECT YEAR(date_reservation) AS annee, Espece.id AS espece_id, SUM(Adoption.prix) AS somme, COUNT(Adoption.animal_id) AS nb
    FROM Adoption
    INNER JOIN Animal ON Animal.id = Adoption.animal_id
    INNER JOIN Espece ON Animal.espece_id = Espece.id
    GROUP BY annee, Espece.id;
END |
DELIMITER ;


ALTER TABLE VM_Revenus_annee_espece
    ADD CONSTRAINT fk_vm_revenu_espece_id FOREIGN KEY (espece_id) REFERENCES Espece (id) ON DELETE CASCADE,
    ADD PRIMARY KEY (annee, espece_id);
    

DELIMITER |

DROP TRIGGER after_insert_adoption |
CREATE TRIGGER after_insert_adoption AFTER INSERT
ON Adoption FOR EACH ROW
BEGIN
    UPDATE Animal
    SET disponible = FALSE
    WHERE id = NEW.animal_id;

    INSERT INTO VM_Revenus_annee_espece (espece_id, annee, somme, nb)
    SELECT espece_id, YEAR(NEW.date_reservation), NEW.prix, 1
    FROM Animal
    WHERE id = NEW.animal_id
    ON DUPLICATE KEY UPDATE somme = somme + NEW.prix, nb = nb + 1;
END |


DROP TRIGGER after_update_adoption |
CREATE TRIGGER after_update_adoption AFTER UPDATE
ON Adoption FOR EACH ROW
BEGIN
    IF OLD.animal_id <> NEW.animal_id THEN
        UPDATE Animal
        SET disponible = TRUE
        WHERE id = OLD.animal_id;

        UPDATE Animal
        SET disponible = FALSE
        WHERE id = NEW.animal_id;
    END IF;

    INSERT INTO VM_Revenus_annee_espece (espece_id, annee, somme, nb)
    SELECT espece_id, YEAR(NEW.date_reservation), NEW.prix, 1
    FROM Animal
    WHERE id = NEW.animal_id
    ON DUPLICATE KEY UPDATE somme = somme + NEW.prix, nb = nb + 1;

    UPDATE VM_Revenus_annee_espece
    SET somme = somme - OLD.prix, nb = nb - 1
    WHERE annee = YEAR(OLD.date_reservation)
    AND espece_id = (SELECT espece_id FROM Animal WHERE id = OLD.animal_id);
 
    DELETE FROM VM_Revenus_annee_espece
    WHERE nb = 0;
END |

DROP TRIGGER after_delete_adoption |
CREATE TRIGGER after_delete_adoption AFTER DELETE
ON Adoption FOR EACH ROW
BEGIN
    UPDATE Animal
    SET disponible = TRUE
    WHERE id = OLD.animal_id;

    UPDATE VM_Revenus_annee_espece
    SET somme = somme - OLD.prix, nb = nb - 1
    WHERE annee = YEAR(OLD.date_reservation)
    AND espece_id = (SELECT espece_id FROM Animal WHERE id = OLD.animal_id);
 
    DELETE FROM VM_Revenus_annee_espece
    WHERE nb = 0;
END |

DELIMITER ;


DELIMITER |
CREATE PROCEDURE test_perf_table()
BEGIN
    DECLARE v_max INT DEFAULT 1000;                     
    DECLARE v_i INT DEFAULT 0;
    DECLARE v_nb INT;
    DECLARE v_somme DECIMAL(15,2);
    DECLARE v_annee CHAR(4);
 
    boucle: LOOP
        IF v_i = v_max THEN LEAVE boucle; END IF;         
        -- Condition d'arrêt de la boucle

        SELECT SQL_NO_CACHE YEAR(date_reservation) AS annee, 
                            SUM(Adoption.prix) AS somme,
                            COUNT(Adoption.animal_id) AS nb
               INTO v_annee, v_somme, v_nb
        FROM Adoption
        INNER JOIN Animal ON Animal.id = Adoption.animal_id
        INNER JOIN Espece ON Animal.espece_id = Espece.id
        WHERE Espece.id = 2
        GROUP BY annee
        ORDER BY somme DESC
        LIMIT 1;
 
        SET v_i = v_i + 1;
    END LOOP;
    
END |
DELIMITER ;



DELIMITER |
CREATE PROCEDURE test_perf_vue()
BEGIN
    DECLARE v_max INT DEFAULT 1000;                   
    DECLARE v_i INT DEFAULT 0;
    DECLARE v_nb INT;
    DECLARE v_somme DECIMAL(15,2);
    DECLARE v_annee CHAR(4);

    boucle: LOOP
        IF v_i = v_max THEN LEAVE boucle; END IF;    

        SELECT SQL_NO_CACHE annee, somme, nb         
               INTO v_annee, v_somme, v_nb                                          
        FROM V_Revenus_annee_espece
        WHERE espece_id = 2
        ORDER BY somme DESC
        LIMIT 1;
 
        SET v_i = v_i + 1;
    END LOOP;
    
END |
DELIMITER ;



DELIMITER |
CREATE PROCEDURE test_perf_vm()
BEGIN
    DECLARE v_max INT DEFAULT 1000;                   
    DECLARE v_i INT DEFAULT 0;
    DECLARE v_nb INT;
    DECLARE v_somme DECIMAL(15,2);
    DECLARE v_annee CHAR(4);

    boucle: LOOP
        IF v_i = v_max THEN LEAVE boucle; END IF;    

        SELECT SQL_NO_CACHE annee, somme, nb         
               INTO v_annee, v_somme, v_nb                                          
        FROM VM_Revenus_annee_espece
        WHERE espece_id = 2
        ORDER BY somme DESC
        LIMIT 1;
 
        SET v_i = v_i + 1;
    END LOOP;
    
END |
DELIMITER ;


CALL test_perf_table();
CALL test_perf_vm;
