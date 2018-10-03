DELIMITER |
CREATE PROCEDURE ajouter_adoption(IN p_client_id INT, IN p_animal_id INT, IN p_date DATE, IN p_paye TINYINT)
BEGIN
    DECLARE v_prix DECIMAL(7,2);
    
    SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix
    FROM Animal
    INNER JOIN Espece ON Espece.id = Animal.espece_id
    LEFT JOIN Race ON Race.id = Animal.race_id
    WHERE Animal.id = p_animal_id;
    
    INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
    VALUES (p_animal_id, p_client_id, CURRENT_DATE(), p_date, v_prix, p_paye);
    
  
    SELECT 'Adoption correctement ajoutée' AS message;
END|
DELIMITER ;


SET @date_adoption := CURRENT_DATE() + INTERVAL 7 DAY;

CALL ajouter_adoption(18, 6, @date_adoption, 1);
CALL ajouter_adoption(12, 21, @date_adoption, 1);
CALL ajouter_adoption(12, 102, @date_adoption, 1);


DECLARE { EXIT | CONTINUE } HANDLER FOR { numero_erreur | { SQLSTATE identifiant_erreur } | condition };
   -- instruction ou bloc d'instructions
    

DELIMITER |
CREATE PROCEDURE ajouter_adoption_exit(IN p_client_id INT, IN p_animal_id INT, IN p_date DATE, IN p_paye TINYINT)
BEGIN
    DECLARE v_prix DECIMAL(7,2);
    DECLARE EXIT HANDLER FOR SQLSTATE '23000' 
        BEGIN
            SELECT 'Une erreur est survenue...';
            SELECT 'Arrêt prématuré de la procédure';
        END;

    SELECT 'Début procédure';

    SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix
    FROM Animal
    INNER JOIN Espece ON Espece.id = Animal.espece_id
    LEFT JOIN Race ON Race.id = Animal.race_id
    WHERE Animal.id = p_animal_id;
    
    INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
    VALUES (p_animal_id, p_client_id, CURRENT_DATE(), p_date, v_prix, p_paye);

    SELECT 'Fin procédure' AS message;
END|

CREATE PROCEDURE ajouter_adoption_continue(IN p_client_id INT, IN p_animal_id INT, IN p_date DATE, IN p_paye TINYINT)
BEGIN
    DECLARE v_prix DECIMAL(7,2);
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SELECT 'Une erreur est survenue...';

    SELECT 'Début procédure';

    SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix
    FROM Animal
    INNER JOIN Espece ON Espece.id = Animal.espece_id
    LEFT JOIN Race ON Race.id = Animal.race_id
    WHERE Animal.id = p_animal_id;
    
    INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
    VALUES (p_animal_id, p_client_id, CURRENT_DATE(), p_date, v_prix, p_paye);
  
    SELECT 'Fin procédure';
END|
DELIMITER ;

SET @date_adoption = CURRENT_DATE() + INTERVAL 7 DAY;

CALL ajouter_adoption_exit(18, 6, @date_adoption, 1);
CALL ajouter_adoption_continue(18, 6, @date_adoption, 1);


DECLARE nom_erreur CONDITION FOR { SQLSTATE identifiant_SQL | numero_erreur_MySQL };


DROP PROCEDURE ajouter_adoption_exit;
DELIMITER |
CREATE PROCEDURE ajouter_adoption_exit(IN p_client_id INT, IN p_animal_id INT, IN p_date DATE, IN p_paye TINYINT)
BEGIN
    DECLARE v_prix DECIMAL(7,2);

    DECLARE violation_contrainte 
        CONDITION FOR SQLSTATE '23000';   
        -- On nomme l'erreur dont l'identifiant est 23000 "violation_contrainte"

    DECLARE EXIT HANDLER FOR violation_contrainte                  
    -- Le gestionnaire sert donc à intercepter les erreurs de type "violation_contrainte"
        BEGIN                               
            SELECT 'Une erreur est survenue...';
            SELECT 'Arrêt prématuré de la procédure';
        END;

    SELECT 'Début procédure';

    SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix
    FROM Animal
    INNER JOIN Espece ON Espece.id = Animal.espece_id
    LEFT JOIN Race ON Race.id = Animal.race_id
    WHERE Animal.id = p_animal_id;
    
    INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
    VALUES (p_animal_id, p_client_id, CURRENT_DATE(), p_date, v_prix, p_paye);

    SELECT 'Fin procédure';
END|
DELIMITER ;


DROP PROCEDURE ajouter_adoption_exit;
DELIMITER |
CREATE PROCEDURE ajouter_adoption_exit(IN p_client_id INT, IN p_animal_id INT, IN p_date DATE, IN p_paye TINYINT)
BEGIN
    DECLARE v_prix DECIMAL(7,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION              
        BEGIN
            SELECT 'Une erreur est survenue...';
            SELECT 'Arrêt prématuré de la procédure';
        END;

    SELECT 'Début procédure';

    SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix
    FROM Animal
    INNER JOIN Espece ON Espece.id = Animal.espece_id
    LEFT JOIN Race ON Race.id = Animal.race_id
    WHERE Animal.id = p_animal_id;
    
    INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
    VALUES (p_animal_id, p_client_id, CURRENT_DATE(), p_date, v_prix, p_paye);

    SELECT 'Fin procédure';
END|
DELIMITER ;


DROP PROCEDURE ajouter_adoption_exit;
DELIMITER |
CREATE PROCEDURE ajouter_adoption_exit(IN p_client_id INT, IN p_animal_id INT, IN p_date DATE, IN p_paye TINYINT)
BEGIN
    DECLARE v_prix DECIMAL(7,2);

    -- Déclaration des CONDITIONS
    DECLARE violation_cle_etrangere CONDITION FOR 1452;            
    DECLARE violation_unicite CONDITION FOR 1062;
    -- SQLWARNING, NOT FOUND, SQLEXCEPTION 
    
    -- Déclaration du gestionnaire pour les erreurs de clés étrangères
    DECLARE EXIT HANDLER FOR violation_cle_etrangere                  
        BEGIN                                               
            SELECT 'Erreur : violation de clé étrangère.';
        END;
    -- Déclaration du gestionnaire pour les erreurs d'index unique
    DECLARE EXIT HANDLER FOR violation_unicite  
        BEGIN                                                    
            SELECT 'Erreur : violation de contrainte d''unicité.';
        END;
    -- Déclaration du gestionnaire pour toutes les autres erreurs ou avertissements
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING              
        BEGIN                               
            SELECT 'Une erreur est survenue...';
        END;

    SELECT 'Début procédure';

    SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix
    FROM Animal
    INNER JOIN Espece ON Espece.id = Animal.espece_id
    LEFT JOIN Race ON Race.id = Animal.race_id
    WHERE Animal.id = p_animal_id;
    
    INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
    VALUES (p_animal_id, p_client_id, CURRENT_DATE(), p_date, v_prix, p_paye);

    SELECT 'Fin procédure';
END|
DELIMITER ;

SET @date_adoption = CURRENT_DATE() + INTERVAL 7 DAY;

CALL ajouter_adoption_exit(12, 3, @date_adoption, 1);        
-- Violation unicité (animal 3 est déjà adopté)
CALL ajouter_adoption_exit(133, 6, @date_adoption, 1);       
-- Violation clé étrangère (client 133 n'existe pas)
CALL ajouter_adoption_exit(NULL, 6, @date_adoption, 1);      
-- Violation de contrainte NOT NULL


-- DECLARE nom_curseur CURSOR FOR requete_select;

-- DECLARE curseur_client CURSOR 
--    FOR SELECT * 
--    FROM Client;


DELIMITER |
CREATE PROCEDURE parcours_deux_clients()
BEGIN
    DECLARE v_nom, v_prenom VARCHAR(100);

    DECLARE curs_clients CURSOR
        FOR SELECT nom, prenom  -- Le SELECT récupère deux colonnes
        FROM Client
        ORDER BY nom, prenom;   
        -- On trie les clients par ordre alphabétique

    OPEN curs_clients;  -- Ouverture du curseur

    FETCH curs_clients INTO v_nom, v_prenom;    
    -- On récupère la première ligne et on assigne les valeurs récupérées à nos variables locales
    SELECT CONCAT(v_prenom, ' ', v_nom) AS 'Premier client';

    FETCH curs_clients INTO v_nom, v_prenom;
    -- On récupère la seconde ligne et on assigne les valeurs récupérées à nos variables locales
    SELECT CONCAT(v_prenom, ' ', v_nom) AS 'Second client';

    CLOSE curs_clients;     -- Fermeture du curseur
END|
DELIMITER ;

CALL parcours_deux_clients();


DELIMITER |
CREATE PROCEDURE test_condition(IN p_ville VARCHAR(100))
BEGIN
    DECLARE v_nom, v_prenom VARCHAR(100);

    DECLARE curs_clients CURSOR
        FOR SELECT nom, prenom
        FROM Client
        WHERE ville = p_ville;

    OPEN curs_clients;                                    

    LOOP                                                  
        FETCH curs_clients INTO v_nom, v_prenom;                   
        SELECT CONCAT(v_prenom, ' ', v_nom) AS 'Client';
    END LOOP;

    CLOSE curs_clients; 
END|
DELIMITER ;

CALL test_condition('Houtsiplou');
CALL test_condition('Bruxelles');

drop procedure test_condition2
DELIMITER |
CREATE PROCEDURE test_condition2(IN p_ville VARCHAR(100))
BEGIN
    DECLARE v_nom, v_prenom VARCHAR(100);
    
    declare fin boolean default false;                      
    -- Variable locale utilisée pour stopper la boucle

    DECLARE curs_clients CURSOR
        FOR SELECT nom, prenom
        FROM Client
        WHERE ville = p_ville;

    -- Gestionnaire d'erreur pour la condition NOT FOUND
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = true; 

    OPEN curs_clients;                                    

    loop_curseur: while fin = false do                                              
        FETCH curs_clients INTO v_nom, v_prenom;
        SELECT CONCAT(v_prenom, ' ', v_nom) AS 'Client';
    END while;

    CLOSE curs_clients; 
END|
DELIMITER ;

CALL test_condition2('Houtsiplou');
CALL test_condition2('Bruxelles');


SELECT 1 = 1, 1 = 2;    


DELIMITER |
CREATE PROCEDURE test_vu()
BEGIN
    SET @var = 15;
END|
DELIMITER ;

SELECT @var;    -- @var n'existe pas encore, on ne l'a pas définie
CALL test_vu(); -- On exécute la procédure
SELECT @var;    
    -- @var vaut maintenant 15, même en dehors de la procédure, puisqu'elle est définie partout dans la session
    

SET @var = 'Bonjour';
CALL test_vu();
SELECT @var;    -- Donne 15 !


DELIMITER |
CREATE PROCEDURE carre(INOUT p_nb FLOAT) SET p_nb = p_nb * p_nb|

CREATE PROCEDURE surface_cercle(IN p_rayon FLOAT, OUT p_surface FLOAT)
BEGIN
    CALL carre(p_rayon);

    SET p_surface = p_rayon * PI();
END|
DELIMITER ;

CALL surface_cercle(1, @surface);   -- Donne environ pi (3,14...)
SELECT @surface;
CALL surface_cercle(2, @surface);   -- Donne environ 12,57...
SELECT @surface;


DELIMITER |
CREATE PROCEDURE adoption_deux_ou_rien(p_client_id INT, p_animal_id_1 INT, p_animal_id_2 INT)
BEGIN
    DECLARE v_prix DECIMAL(7,2);

    -- Gestionnaire qui annule la transaction et termine la procédure
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;  

    START TRANSACTION;

    SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix
    FROM Animal
    INNER JOIN Espece ON Espece.id = Animal.espece_id
    LEFT JOIN Race ON Race.id = Animal.race_id
    WHERE Animal.id = p_animal_id_1;
    
    INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
    VALUES (p_animal_id_1, p_client_id, CURRENT_DATE(), CURRENT_DATE(), v_prix, TRUE);

    SELECT 'Adoption animal 1 réussie' AS message;

    SELECT COALESCE(Race.prix, Espece.prix) INTO v_prix
    FROM Animal
    INNER JOIN Espece ON Espece.id = Animal.espece_id
    LEFT JOIN Race ON Race.id = Animal.race_id
    WHERE Animal.id = p_animal_id_2;
    
    INSERT INTO Adoption (animal_id, client_id, date_reservation, date_adoption, prix, paye)
    VALUES (p_animal_id_2, p_client_id, CURRENT_DATE(), CURRENT_DATE(), v_prix, TRUE);
    
    SELECT 'Adoption animal 2 réussie' AS message;
    
    COMMIT;
END|
DELIMITER ;

CALL adoption_deux_ou_rien(2, 43, 55);  -- L'animal 55 a déjà été adopté


DELIMITER |
CREATE PROCEDURE select_race_dynamique(p_clause VARCHAR(255))
BEGIN
    SET @sql = CONCAT('SELECT nom, description FROM Race ', p_clause);
    
    PREPARE requete FROM @sql;
    EXECUTE requete;
END|
DELIMITER ;


-- Affichera les races de chats
CALL select_race_dynamique('WHERE espece_id = 2');
 -- Affichera les deux premières races par ordre alphabétique de leur nom
CALL select_race_dynamique('ORDER BY nom LIMIT 2');