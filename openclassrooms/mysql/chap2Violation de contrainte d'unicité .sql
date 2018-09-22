INSERT INTO Espece (nom_courant, nom_latin, description)
VALUES ('Chien en peluche', 'Canis canis', 'Tout doux, propre et  silencieux');
-- ERROR 1062 (23000): Duplicate entry 'Canis canis' for key 'nom_latin'

INSERT ignore INTO Espece (nom_courant, nom_latin, description)
VALUES ('Chien en peluche', 'Canis canis', 'Tout doux, propre et  silencieux');

UPDATE ignore Espece SET nom_latin = 'Canis canis' WHERE nom_courant = 'Chat';

LOAD DATA [LOCAL] INFILE 'nom_fichier' IGNORE    
-- IGNORE se place juste avant INTO, comme dans INSERT
INTO TABLE nom_table
[FIELDS
    [TERMINATED BY '\t']
    [ENCLOSED BY '']
    [ESCAPED BY '\\' ]
]
[LINES 
    [STARTING BY '']    
    [TERMINATED BY '\n']
]
[IGNORE nombre LINES]
[(nom_colonne,...)];


SELECT id, sexe, date_naissance, nom, espece_id, mere_id, pere_id FROM Animal WHERE nom = 'Spoutnik';

INSERT INTO Animal (sexe, nom, date_naissance, espece_id)
VALUES ('F', 'Spoutnik', '2010-08-06 15:05:00', 3);

replace INTO Animal (sexe, nom, date_naissance, espece_id)
VALUES ('F', 'Spoutnik', '2010-08-06 15:05:00', 3);

REPLACE INTO Animal (id, sexe, nom, date_naissance, espece_id) 
    -- Je donne moi-même un id, qui existe déjà !
VALUES (32, 'M', 'Spoutnik', '2009-07-26 11:52:00', 3);        
    -- Et Spoutnik est mon souffre-douleur du jour.
    

LOAD DATA [LOCAL] INFILE 'nom_fichier' REPLACE   
    -- se place au même endroit que IGNORE
INTO TABLE nom_table
[FIELDS
    [TERMINATED BY '\t']
    [ENCLOSED BY '']
    [ESCAPED BY '\\' ]
]
[LINES 
    [STARTING BY '']    
    [TERMINATED BY '\n']
]
[IGNORE nombre LINES]
[(nom_colonne,...)];


INSERT INTO nom_table [(colonne1, colonne2, colonne3)]
VALUES (valeur1, valeur2, valeur3)
ON DUPLICATE KEY UPDATE colonne2 = valeur2 [, colonne3 = valeur3];

INSERT INTO Animal (sexe, date_naissance, espece_id, nom, mere_id)
VALUES ('M', '2010-05-27 11:38:00', 3, 'Spoutnik', 52) 
    -- date_naissance et mere_id sont différents du Spoutnik existant
ON DUPLICATE KEY UPDATE mere_id = 52;

