SELECT Animal.* FROM Animal 
INNER JOIN Espece ON Animal.espece_id = Espece.id 
WHERE Espece.nom_courant = 'Chat'
UNION
SELECT Animal.* FROM Animal 
INNER JOIN Espece ON Animal.espece_id = Espece.id 
WHERE Espece.nom_courant = 'Tortue d''Hermann';

-- Pas le même nombre de colonnes --
------------------------------------

SELECT Animal.id, Animal.nom, Espece.nom_courant                    
    -- 3 colonnes sélectionnées
FROM Animal
INNER JOIN Espece ON Animal.espece_id = Espece.id
WHERE Espece.nom_courant = 'Chat'
UNION
SELECT Animal.id, Animal.nom, Espece.nom_courant, Animal.espece_id 
    -- 4 colonnes sélectionnées
FROM Animal
INNER JOIN Espece ON Animal.espece_id = Espece.id
WHERE Espece.nom_courant = 'Tortue d''Hermann';


SELECT * FROM Espece
UNION all
SELECT * FROM Espece;


SELECT * FROM Espece
UNION
SELECT * FROM Espece;

SELECT id, nom, 'Race' AS table_origine FROM Race
UNION
(SELECT id, nom_latin, 'Espèce' AS table_origine FROM Espece LIMIT 2);


SELECT id, nom, 'Race' AS table_origine FROM Race
UNION
SELECT id, nom_latin, 'Espèce' AS table_origine FROM Espece
ORDER BY nom DESC;


(SELECT id, nom, 'Race' AS table_origine FROM Race LIMIT 6)
UNION
(SELECT id, nom_latin, 'Espèce' AS table_origine FROM Espece LIMIT 3)
ORDER BY nom LIMIT 5;


(SELECT id, nom, 'Race' AS table_origine FROM Race ORDER BY nom DESC LIMIT 6)
UNION
(SELECT id, nom_latin, 'Espèce' AS table_origine FROM Espece LIMIT 3);


