DELIMITER |
CREATE PROCEDURE aujourdhui_demain ()
BEGIN
    DECLARE v_date DATE DEFAULT CURRENT_DATE();               
    -- On déclare une variable locale et on lui met une valeur par défaut

    SELECT DATE_FORMAT(v_date, '%W %e %M %Y') AS Aujourdhui;

    SET v_date = v_date + INTERVAL 1 DAY;                     
    -- On change la valeur de la variable locale
    SELECT DATE_FORMAT(v_date, '%W %e %M %Y') AS Demain;
END|
DELIMITER ;


SET lc_time_names = 'fr_FR';
CALL aujourdhui_demain();


DELIMITER |
CREATE PROCEDURE test_portee1()
BEGIN
    DECLARE v_test1 INT DEFAULT 1;

    BEGIN
        DECLARE v_test2 INT DEFAULT 2;

        SELECT 'Imbriqué' AS Bloc;
        SELECT v_test1, v_test2;
    END;
    SELECT 'Principal' AS Bloc;
    SELECT v_test1, v_test2;
    
END|
DELIMITER ;

CALL test_portee1();


DELIMITER |
CREATE PROCEDURE test_portee2()
BEGIN
    DECLARE v_test1 INT DEFAULT 1;

    BEGIN
        DECLARE v_test2 INT DEFAULT 2;

        SELECT 'Imbriqué 1' AS Bloc;
        SELECT v_test1, v_test2;
    END;
 
    BEGIN
        SELECT 'imbriqué 2' AS Bloc;
        SELECT v_test1, v_test2;    
    END;
    
    
END|
DELIMITER ;

CALL test_portee2();

DELIMITER |
CREATE PROCEDURE test_portee3()
BEGIN
    DECLARE v_test INT DEFAULT 1;

    SELECT v_test AS 'Bloc principal';

    BEGIN
        DECLARE v_test INT DEFAULT 0;

        SELECT v_test AS 'Bloc imbriqué';
        SET v_test = 2;
        SELECT v_test AS 'Bloc imbriqué après modification';
    END;

    SELECT v_test AS 'Bloc principal apres bloc imbriqué';
END |
DELIMITER ;

CALL test_portee3();

IF condition THEN instructions
[ELSEIF autre_condition THEN instructions
[ELSEIF ...]]
[ELSE instructions]
END IF;


DELIMITER |
CREATE PROCEDURE est_adopte(IN p_animal_id INT)
BEGIN
    DECLARE v_nb INT DEFAULT 0;           
    -- On crée une variable locale

    SELECT COUNT(*) INTO v_nb             
    FROM Adoption                         
    WHERE animal_id = p_animal_id;
    -- On met le nombre de lignes correspondant à l'animal dans Adoption dans notre variable locale

    IF v_nb > 0 THEN 
    -- On teste si v_nb est supérieur à 0 (donc si l'animal a été adopté)
        SELECT 'J''ai déjà été adopté !';
    END IF;                               
    -- Et on n'oublie surtout pas le END IF et le ; final
END |
DELIMITER ;

CALL est_adopte(3);
CALL est_adopte(57);


DELIMITER |
CREATE PROCEDURE avant_apres_2010(IN p_animal_id INT)
BEGIN
    DECLARE v_annee INT;

    SELECT YEAR(date_naissance) INTO v_annee
    FROM Animal
    WHERE id = p_animal_id;

    IF v_annee < 2010 THEN
        SELECT 'Je suis né avant 2010' AS naissance;
    ELSE    -- Pas de THEN
        SELECT 'Je suis né après 2010' AS naissance;
    END IF; -- Toujours obligatoire

END |
DELIMITER ;

CALL avant_apres_2010(34);   -- Né le 20/04/2008
CALL avant_apres_2010(69);


DELIMITER |
CREATE PROCEDURE message_sexe(IN p_animal_id INT)
BEGIN
    DECLARE v_sexe VARCHAR(10);

    SELECT sexe INTO v_sexe
    FROM Animal
    WHERE id = p_animal_id;

    IF (v_sexe = 'F') THEN      -- Première possibilité
        SELECT 'Je suis une femelle !' AS sexe;
    ELSEIF (v_sexe = 'M') THEN  -- Deuxième possibilité
        SELECT 'Je suis un mâle !' AS sexe;
    ELSE                        -- Défaut
        SELECT 'Je suis en plein questionnement existentiel...' AS sexe;
    END IF;
END|
DELIMITER ;


CALL message_sexe(8);   -- Mâle
CALL message_sexe(6);   -- Femelle
CALL message_sexe(9);


CASE valeur_a_comparer
    WHEN possibilite1 THEN instructions
    [WHEN possibilite2 THEN instructions] ...
    [ELSE instructions]
END CASE;


DELIMITER |
CREATE PROCEDURE message_sexe2(IN p_animal_id INT)
BEGIN
    DECLARE v_sexe VARCHAR(10);

    SELECT sexe INTO v_sexe
    FROM Animal
    WHERE id = p_animal_id;

    CASE v_sexe
        WHEN 'F' THEN   -- Première possibilité
            SELECT 'Je suis une femelle !' AS sexe;
        WHEN 'M' THEN   -- Deuxième possibilité
            SELECT 'Je suis un mâle !' AS sexe;
        ELSE            -- Défaut
            SELECT 'Je suis en plein questionnement existentiel...' AS sexe;
    END CASE;
END|
DELIMITER ;

CALL message_sexe2(8);   -- Mâle
CALL message_sexe2(6);   -- Femelle
CALL message_sexe2(9);   -- Ni l'un ni l'autre


DELIMITER |
CREATE PROCEDURE avant_apres_2010_case (IN p_animal_id INT, OUT p_message VARCHAR(100))
BEGIN
    DECLARE v_annee INT;

    SELECT YEAR(date_naissance) INTO v_annee
    FROM Animal
    WHERE id = p_animal_id;

    CASE
        WHEN v_annee < 2010 THEN
            SET p_message = 'Je suis né avant 2010.';
        WHEN v_annee = 2010 THEN
            SET p_message = 'Je suis né en 2010.';
        ELSE
            SET p_message = 'Je suis né après 2010.';   
    END CASE;
END |
DELIMITER ;

CALL avant_apres_2010_case(59, @message);   
SELECT @message;
CALL avant_apres_2010_case(62, @message);   
SELECT @message;
CALL avant_apres_2010_case(69, @message);
SELECT @message;


DELIMITER |
CREATE PROCEDURE salut_nom(IN p_animal_id INT)
BEGIN
    DECLARE v_terminaison CHAR(1);

    SELECT SUBSTRING(nom, -1, 1) INTO v_terminaison  
    -- Une position négative signifie qu'on recule au lieu d'avancer, -1 est donc la dernière lettre du nom.. 
    FROM Animal                                       
    WHERE id = p_animal_id;

    CASE v_terminaison
        WHEN 'a' THEN
            SELECT 'Bonjour !' AS Salutations;
        WHEN 'o' THEN
            SELECT 'Salut !' AS Salutations;
        WHEN 'i' THEN
            SELECT 'Coucou !' AS Salutations;
    END CASE;

END|
DELIMITER ;

CALL salut_nom(69);  -- Baba
CALL salut_nom(5);   -- Choupi
CALL salut_nom(29);  -- Fiero
CALL salut_nom(54);  -- Bubulle


DROP PROCEDURE salut_nom;
DELIMITER |
CREATE PROCEDURE salut_nom(IN p_animal_id INT)
BEGIN
    DECLARE v_terminaison CHAR(1);

    SELECT SUBSTRING(nom, -1, 1) INTO v_terminaison
    FROM Animal
    WHERE id = p_animal_id;

    CASE v_terminaison
        WHEN 'a' THEN
            SELECT 'Bonjour !' AS Salutations;
        WHEN 'o' THEN
            SELECT 'Salut !' AS Salutations;
        WHEN 'i' THEN
            SELECT 'Coucou !' AS Salutations;
        ELSE
            BEGIN   -- Bloc d'instructions vide
            END;
    END CASE;

END|
DELIMITER ;

CALL salut_nom(69);  -- Baba
CALL salut_nom(5);   -- Choupi
CALL salut_nom(29);  -- Fiero
CALL salut_nom(54);  -- Bubulle

SELECT id, nom, CASE
          WHEN sexe = 'M' THEN 'Je suis un mâle !'
          WHEN sexe = 'F' THEN 'Je suis une femelle !'
          ELSE 'Je suis en plein questionnement existentiel...'
       END AS message
FROM Animal
WHERE id IN (9, 8, 6);

SELECT nom, IF(sexe = 'M', 'Je suis un mâle', 'Je ne suis pas un mâle') AS sexe
FROM Animal
WHERE espece_id = 5;

DELIMITER |
CREATE PROCEDURE compter_jusque_while(IN p_nombre INT)
BEGIN
    DECLARE v_i INT DEFAULT 1;

    WHILE v_i <= p_nombre DO
        SELECT v_i AS nombre; 

        SET v_i = v_i + 1;    
        -- À ne surtout pas oublier, sinon la condition restera vraie
    END WHILE;
END |
DELIMITER ;

CALL compter_jusque_while(3);


DELIMITER |
create procedure compter_jusque_repeat(in p_nombre int)
begin
	declare v_i int default 1;
    repeat
		select v_i as nombre;
        set v_i = v_i + 1;
	until  v_i > p_nombre end repeat;
end|
DELIMITER ;

CALL comter_jusque_repeat(3);


-- Condition fausse dès le départ, on ne rentre pas dans la boucle
CALL compter_jusque_while(0);   

-- Condition fausse dès le départ, on rentre quand même une fois dans la boucle
CALL compter_jusque_repeat(0);

-- Boucle WHILE
-- ------------
super_while: WHILE condition DO    
    -- La boucle a pour label "super_while"
    instructions
END WHILE super_while;             
    -- On ferme en donnant le label de la boucle (facultatif)

-- Boucle REPEAT
-- -------------                  
repeat_genial: REPEAT  -- La boucle s'appelle "repeat_genial"
    instructions
UNTIL condition END REPEAT;
    -- Cette fois, on choisit de ne pas faire référence au label lors de la fermeture

-- Bloc d'instructions
-- -------------------
bloc_extra: BEGIN   -- Le bloc a pour label "bloc_extra"
    instructions
END bloc_extra;


DELIMITER |
CREATE PROCEDURE test_leave1(IN p_nombre INT)
BEGIN
    DECLARE v_i INT DEFAULT 4;
    
    SELECT 'Avant la boucle WHILE';
    
    while1: WHILE v_i > 0 DO

        SET p_nombre = p_nombre + 1; -- On incrémente le nombre de 1
        
        IF p_nombre % 10 = 0 THEN     -- Si p_nombre est divisible par 10,
            SELECT 'Stop !' AS 'Multiple de 10';
            LEAVE while1;   -- On quitte la boucle WHILE.
        END IF;
        
        SELECT p_nombre;    -- On affiche p_nombre
        SET v_i = v_i - 1;  -- Attention de ne pas l'oublier
    
    END WHILE while1;

    SELECT 'Après la boucle WHILE';
END|
DELIMITER ;

CALL test_leave1(9); -- La boucle s'exécutera 4 fois

DELIMITER |
CREATE PROCEDURE test_leave2(IN p_nombre INT)
corps_procedure: BEGIN                           
    -- On donne un label au bloc d'instructions principal
    DECLARE v_i INT DEFAULT 4;
    
    SELECT 'Avant la boucle WHILE';
    while1: WHILE v_i > 0 DO
        SET p_nombre = p_nombre + 1;    -- On incrémente le nombre de 1
        IF p_nombre%10 = 0 THEN     -- Si p_nombre est divisible par 10,
            SELECT 'Stop !' AS 'Multiple de 10';
            LEAVE corps_procedure;  -- je quitte la procédure.
        END IF;
        
        SELECT p_nombre;    -- On affiche p_nombre
        SET v_i = v_i - 1;  -- Attention de ne pas l'oublier
    END WHILE while1;

    SELECT 'Après la boucle WHILE';
END|
DELIMITER ;

CALL test_leave2(8);


DELIMITER |
CREATE PROCEDURE test_leave3()
BEGIN
    DECLARE v_i INT DEFAULT 4;
    
    WHILE v_i > 0 DO
        
        IF v_i%2 = 0 THEN
            if_pair: BEGIN
                IF v_i = 2 THEN     -- Si v_i vaut 2
                    LEAVE if_pair;  
                    -- On quitte le bloc "if_pair", ce qui revient à quitter la structure IF v_i%2 = 0
                END IF;
                SELECT CONCAT(v_i, ' est pair') AS message;
            END if_pair; 
        ELSE    
            if_impair: BEGIN
                SELECT CONCAT(v_i, ' est impair') AS message;
            END if_impair;   
        END IF;

        SET v_i = v_i - 1;
    END WHILE;
END|
DELIMITER ;

CALL test_leave3();


DELIMITER |
CREATE PROCEDURE test_iterate()
BEGIN
    DECLARE v_i INT DEFAULT 0;

    boucle_while: WHILE v_i <= 2 DO
        SET v_i = v_i + 1;
        SELECT v_i, 'Avant IF' AS message;
 
        IF v_i = 2 THEN
            ITERATE boucle_while;
        END IF;
       
        SELECT v_i, 'Après IF' AS message;  
        -- Ne sera pas exécuté pour v_i = 2
    END WHILE;
END |
DELIMITER ;

CALL test_iterate();


DELIMITER |
CREATE PROCEDURE compter_jusque_loop(IN p_nombre INT)
BEGIN
    DECLARE v_i INT DEFAULT 1;

    boucle_loop: LOOP
        SELECT v_i AS nombre; 

        SET v_i = v_i + 1;

        IF v_i > p_nombre THEN
            LEAVE boucle_loop;
        END IF;    
    END LOOP;
END |
DELIMITER ;

CALL compter_jusque_loop(3);
