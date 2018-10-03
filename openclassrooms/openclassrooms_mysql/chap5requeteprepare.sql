SET @age = 24;                                  
    -- Ne pas oublier le @
SET @salut = 'Hello World !', @poids = 7.8;     
    -- On peut créer plusieurs variables en même temps

SELECT @age, @poids, @salut;

SELECT @age := 32, @poids := 48.15, @perroquet := 4;

SET @chat := 2;


SELECT id, sexe, nom, commentaires, espece_id 
FROM Animal 
WHERE espece_id = @perroquet; 
    -- On sélectionne les perroquets

SET @conversionDollar = 1.31564;       
    -- On crée une variable contenant le taux de conversion des euros en dollars
SELECT prix AS prix_en_euros,         
    -- On sélectionne le prix des races, en euros et en dollars.
        ROUND(prix * @conversionDollar, 2) AS prix_en_dollars,   
        -- En arrondissant à deux décimales
        nom FROM Race;
        
        
SET @table_clients = 'Client';

SELECT * FROM @table_clients;


SET @colonnes = 'id, nom, description';

SELECT @colonnes FROM Race WHERE espece_id = 1;


SET @essai = 3;


SELECT * FROM Client WHERE email = 'truc@email.com';
SELECT * FROM Client WHERE email = 'machin@email.com';
SELECT * FROM Client WHERE email = 'bazar@email.com';
SELECT * FROM Client WHERE email = 'brol@email.com';


-- Sans paramètre
PREPARE select_race
FROM 'SELECT * FROM Race';

-- Avec un paramètre
PREPARE select_client
FROM 'SELECT * FROM Client WHERE email = ?';

-- Avec deux paramètres
PREPARE select_adoption
FROM 'SELECT * FROM Adoption WHERE client_id = ? AND animal_id = ?';


SET @req = 'SELECT * FROM Race';
PREPARE select_race
FROM @req;

SET @colonne = 'nom';
SET @req_animal = CONCAT('SELECT ', @colonne, ' FROM Animal WHERE id = ?');
PREPARE select_col_animal
FROM @req_animal;


EXECUTE select_race;

SET @id = 3;
EXECUTE select_col_animal USING @id;

SET @client = 2;
EXECUTE select_adoption USING @client, @id;

SET @email = 'jean.dupont@email.com';
EXECUTE select_client USING @email;

SET @email = 'marie.boudur@email.com';
EXECUTE select_client USING @email;

SET @email = 'fleurtrachon@email.com';
EXECUTE select_client USING @email;

SET @email = 'jeanvp@email.com';
EXECUTE select_client USING @email;

SET @email = 'johanetpirlouit@email.com';
EXECUTE select_client USING @email;

DEALLOCATE PREPARE select_race;

EXECUTE select_race;


