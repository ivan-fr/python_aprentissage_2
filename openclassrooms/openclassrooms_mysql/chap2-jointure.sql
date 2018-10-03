select espece_id from `Animal` where nom = 'cartouche';

select  description from `Espece` where id = 1;

select Espece.nom_latin from `Espece`
inner join `Animal`
on `Espece`.id = `Animal`.espece_id
where Animal.nom = 'caribou';

select 3+5 as chiots_cartouche;

SELECT *                                   -- comme d'habitude, vous sélectionnez les colonnes que vous voulez
FROM nom_table1
[INNER] JOIN nom_table2                    -- INNER explicite le fait qu'il s'agit d'une jointure interne, mais c'est facultatif
    ON colonne_table1 = colonne_table2     -- sur quelles colonnes se fait la jointure
                                           -- vous pouvez mettre colonne_table2 = colonne_table1, l'ordre n'a pas d'importance

[WHERE ...]
[ORDER BY ...]                            -- les clauses habituelles sont bien sûr utilisables !
[LIMIT ...];

SELECT *
FROM table1
INNER JOIN table2
   ON table1.colonneA = table2.colonneJ
      AND table1.colonneT = table2.colonneX
      [AND ...];

select e.id, e.description, a.nom
from `Espece` as e
inner join `Animal` as a
on e.id = a.espece_id
where a.nom like 'ch%';

SELECT Espece.id AS id_espece,
       Espece.description AS description_espece,
       Animal.nom AS nom_bestiole
FROM Espece
INNER JOIN Animal
     ON Espece.id = Animal.espece_id
WHERE Animal.nom LIKE 'Ch%';

SELECT Animal.nom AS nom_animal, Race.nom AS race
FROM Animal
INNER JOIN Race
    ON Animal.race_id = Race.id
WHERE Animal.espece_id = 2             -- ceci correspond aux chats
ORDER BY Race.nom, Animal.nom;

SELECT Animal.nom AS nom_animal, Race.nom AS race
FROM Animal                         -- Table de gauche
LEFT JOIN Race                      -- Table de droite
    ON Animal.race_id = Race.id
WHERE Animal.espece_id = 2
    AND Animal.nom LIKE 'C%'
ORDER BY Race.nom, Animal.nom;

SELECT Animal.nom AS nom_animal, Race.nom AS race
FROM Animal                         -- Table de gauche
right JOIN Race                      -- Table de droite
    ON Animal.race_id = Race.id
WHERE Race.espece_id = 2
ORDER BY Race.nom, Animal.nom;

SELECT *
FROM table1
[INNER | LEFT | RIGHT] JOIN table2 USING (colonneJ);  -- colonneJ est présente dans les deux tables

-- équivalent à

SELECT *
FROM table1
[INNER | LEFT | RIGHT] JOIN table2 ON table1.colonneJ = table2.colonneJ;


-- table1 : colonnes A, B, C
-- table2 : colonnes B, E, F
-- table3 : colonnes A, C, E

SELECT *
FROM table1
NATURAL JOIN table2;

-- EST ÉQUIVALENT À

SELECT *
FROM table1
INNER JOIN table2
    ON table1.B = table2.B;

SELECT *
FROM table1
NATURAL JOIN table3;

-- EST ÉQUIVALENT À

SELECT *
FROM table1
INNER JOIN table3
    ON table1.A = table3.A AND table1.C = table3.C;

SELECT *
FROM table1, table2
WHERE table1.colonne1 = table2.colonne2;

-- équivalent à

SELECT *
FROM table1
[INNER] JOIN table2
    ON table1.colonne1 = table2.colonne2;

select Race.nom
from `Race`
inner join `Espece`
on `Race`.espece_id = `Espece`.id
where Espece.nom_courant = 'Chien' and Race.nom like 'berger%'

select Animal.nom, Animal.date_naissance, Race.nom as race_nom
from `Animal`
left join `Race`
on `Animal`.race_id = `Race`.id
where (Race.description not like '%pelage%'
      and Race.description not like '%poil%'
      and Race.description not like '%robe%')
      or Race.id is null;


select Animal.sexe, Espece.nom_latin, Race.nom
from `Animal`
inner join `Espece`
on `Animal`.espece_id = `Espece`.id
left join `Race`
on `Animal`.race_id = `Race`.id
where Espece.nom_courant = 'chat' or Espece.nom_courant = 'Perroquet amazone'
order by Espece.nom_latin, Race.nom;


select Animal.nom, Animal.date_naissance, Race.nom
from `Animal`
inner join `Race`
on `Animal`.race_id = `Race`.id
inner join `Espece`
on `Animal`.espece_id = `Espece`.id
where Animal.date_naissance < '2016-07-01'
      and Animal.sexe = 'F'
      and Espece.nom_courant = 'Chien';

select Pere.nom as papa, Mere.nom as maman, Animal.nom
from `Animal`
inner join `Animal` as Pere
on `Animal`.pere_id = Pere.id
inner join `Animal` as Mere
on `Animal`.mere_id = Mere.id
inner join `Espece`
on `Animal`.espece_id = `Espece`.id
where Espece.nom_courant = 'chat';


select Animal.nom, Animal.sexe, Animal.date_naissance
from `Animal`
inner join `Animal` as Pere
on `Animal`.pere_id = Pere.id
where Pere.nom = 'bouli';


select Enfant.nom, Enfant.sexe, Enfant.date_naissance
from Animal
inner join Animal as Enfant
on Enfant.pere_id = `Animal`.id
where Animal.nom = 'bouli'


select animale_spece.nom_courant AS espece, Animal.nom AS nom_animal, race_animal.nom AS race_animal,
    Pere.nom AS papa, Race_pere.nom AS race_papa,
    Mere.nom AS maman, Race_mere.nom AS race_maman
from `Animal`

inner join `Animal` as Pere
on `Animal`.pere_id = Pere.id

inner join Race as Race_pere
on Pere.race_id = Race_pere.id

inner join `Animal` as Mere
on `Animal`.mere_id = Mere.id

inner join `Race` as Race_mere
on Mere.race_id = Race_mere.id

inner join `Espece` as animale_spece
on `Animal`.espece_id = animale_spece.id

inner join `Race` as race_animal
on `Animal`.race_id = race_animal.id