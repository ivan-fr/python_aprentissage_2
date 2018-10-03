use elevage;

DELIMITER |

CREATE PROCEDURE afficher_races_requete() 
    -- pas de paramètres dans les parenthèses
SELECT id, nom, espece_id, prix FROM Race|

SELECT 'test'|


CREATE PROCEDURE afficher_races()      
    -- toujours pas de paramètres, toujours des parenthèses
BEGIN
    SELECT id, nom, espece_id, prix
    FROM Race;  -- Cette fois, le ; ne nous embêtera pas
END|


CALL afficher_races()|   -- le délimiteur est toujours | !!!


DELIMITER |

CREATE PROCEDURE afficher_race_selon_espece(IN p_espece_id INT)  
    -- Définition du paramètre p_espece_id
BEGIN
    SELECT id, nom, espece_id, prix 
    FROM Race
    WHERE espece_id = p_espece_id;  -- Utilisation du paramètre
END|



CALL afficher_race_selon_espece(1);

SET @espece_id := 2;

CALL afficher_race_selon_espece(@espece_id);

DELIMITER |                                                      
CREATE PROCEDURE compter_races_selon_espece (p_espece_id INT, OUT p_nb_races INT)  
BEGIN
    SELECT COUNT(*) INTO p_nb_races 
    FROM Race
    WHERE espece_id = p_espece_id;                               
END |
DELIMITER ;

SELECT id, nom INTO @var1, @var2
FROM Animal 
WHERE id = 7;
SELECT @var1, @var2;

-- erreur
SELECT id, nom INTO @var1
FROM Animal 
WHERE id = 7;

SELECT id, nom INTO @var1, @var2
FROM Animal 
WHERE espece_id = 5;
-- fin erreur

CALL compter_races_selon_espece (2, @nb_races_chats);

SELECT @nb_races_chats;


DELIMITER |
create procedure calculer_prix(in p_animal_id int, inout p_prix decimal(7, 2))
begin
	SELECT COALESCE(Race.prix, Espece.prix) + p_prix into p_prix
	FROM Animal
	INNER JOIN Espece ON Animal.espece_id = Espece.id
	LEFT JOIN Race ON Animal.race_id = Race.id             
		-- Jointure externe, on ne veut pas que les chats de race
	WHERE Animal.id = p_animal_id;               
		-- Uniquement les chats..
end |

SET @prix = 0;                   -- On initialise @prix à 0

CALL calculer_prix (13, @prix);  -- Achat de Rouquine
SELECT @prix AS prix_intermediaire;

CALL calculer_prix (24, @prix);  -- Achat de Cartouche
SELECT @prix AS prix_intermediaire;

CALL calculer_prix (42, @prix);  -- Achat de Bilba
SELECT @prix AS prix_intermediaire;

CALL calculer_prix (75, @prix);  -- Achat de Mimi
SELECT @prix AS total;

DROP PROCEDURE calculer_prix;
