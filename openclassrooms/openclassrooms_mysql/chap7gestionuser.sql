SHOW DATABASES;

-- Création
CREATE USER 'login'@'hote' [IDENTIFIED BY 'mot_de_passe'];

-- Suppression
DROP USER 'login'@'hote';

-- thibault peut se connecter à partir de n'importe quel hôte dont l'adresse IP commence par 194.28.12.
CREATE USER 'thibault'@'194.28.12.%' IDENTIFIED BY 'basketball8';

-- joelle peut se connecter à partir de n'importe quel hôte du domaine brab.net
CREATE USER 'joelle'@'%.brab.net' IDENTIFIED BY 'singingisfun';

-- hannah peut se connecter à partir de n'importe quel hôte
CREATE USER 'hannah'@'%' IDENTIFIED BY 'looking4sun';


RENAME USER 'max'@'localhost' TO 'maxime'@'localhost';


SET PASSWORD FOR 'thibault'@'194.28.12.%' = PASSWORD('basket8');


GRANT privilege [(liste_colonnes)] [, privilege [(liste_colonnes)], ...]
ON [type_objet] niveau_privilege
TO utilisateur [IDENTIFIED BY mot_de_passe];

REVOKE privilege [, privilege, ...]
ON niveau_privilege
FROM utilisateur;


CREATE USER 'john'@'localhost' IDENTIFIED BY 'Exemple_2012';
GRANT SELECT, 
      UPDATE (nom, sexe, commentaires), 
      DELETE, 
      INSERT
ON elevage.Animal
TO 'john'@'localhost';


GRANT SELECT
ON TABLE elevage.Espece -- On précise que c'est une table (facultatif)
TO 'john'@'localhost';


GRANT CREATE ROUTINE, EXECUTE
ON elevage.*
TO 'john'@'localhost';


REVOKE DELETE
ON elevage.Animal
FROM 'john'@'localhost';


create user 'joseph'@'localhost' IDENTIFIED BY 'Exemple_2012';
GRANT SELECT, UPDATE, INSERT, DELETE, GRANT OPTION
ON elevage.*
TO 'joseph'@'localhost';

-- OU

GRANT SELECT, UPDATE, INSERT, DELETE
ON elevage.*
TO 'joseph'@'localhost'
WITH GRANT OPTION;


DELIMITER |
CREATE PROCEDURE test_definer()
BEGIN
    SELECT * FROM Adoption;
END |
DELIMITER ;


SELECT * FROM Adoption;
CALL test_definer();


DELIMITER |
CREATE DEFINER = CURRENT_USER() PROCEDURE test_definer2()
BEGIN
    SELECT * FROM Race;
END |

CREATE DEFINER = 'john'@'localhost' PROCEDURE test_definer3()
BEGIN
    SELECT * FROM Race;
END |
DELIMITER ;


-- Vues
CREATE [OR REPLACE]
    [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = { utilisateur | CURRENT_USER }]
    [SQL SECURITY { DEFINER | INVOKER }]
    VIEW nom_vue [(liste_colonnes)]
    AS requete_select
    [WITH [CASCADED | LOCAL] CHECK OPTION]

-- Procédures
CREATE
    [DEFINER = { utilisateur | CURRENT_USER }]
    PROCEDURE nom_procedure ([parametres_procedure])
    SQL SECURITY { DEFINER | INVOKER }
    corps_procedure
    
    
CREATE DEFINER = CURRENT_USER
       SQL SECURITY DEFINER
       VIEW test_contexte1
AS SELECT * FROM Race;

CREATE DEFINER = CURRENT_USER
       SQL SECURITY INVOKER
       VIEW test_contexte2
AS SELECT * FROM Race;


GRANT SELECT ON elevage.test_contexte1 TO 'john'@'localhost';
GRANT SELECT ON elevage.test_contexte2 TO 'john'@'localhost';


CREATE USER 'aline'@'localhost' IDENTIFIED BY 'Exemple_2012';
GRANT ALL ON elevage.*
TO 'aline'@'localhost';

alter user  'aline'@'localhost'  WITH MAX_QUERIES_PER_HOUR 100;


-- MAX_QUERIES_PER_HOUR 20
--    ->          MAX_UPDATES_PER_HOUR 10
--    ->          MAX_CONNECTIONS_PER_HOUR 5
--    ->          MAX_USER_CONNECTIONS 2

