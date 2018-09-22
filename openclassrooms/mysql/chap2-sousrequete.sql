USE elevage;

SELECT Animal.id, Animal.sexe, Animal.date_naissance, Animal.nom, Animal.espece_id
from Animal
inner join Espece
on Animal.espece_id = Espece.id
where (Espece.nom_courant = 'Perroquet amazone' or
      Espece.nom_courant = 'Tortue d''Hermann')
      and Animal.sexe = 'F';

select min(tortues_perroquets_f.date_naissance)
from (
    SELECT Animal.id, Animal.sexe, Animal.date_naissance, Animal.nom, Animal.espece_id
    from Animal
    inner join Espece
    on Animal.espece_id = Espece.id
    where (Espece.nom_courant = 'Perroquet amazone' or
          Espece.nom_courant = 'Tortue d''Hermann')
          and Animal.sexe = 'F'
) as tortues_perroquets_f;


SELECT Animal.id, Animal.sexe, Animal.nom, Animal.commentaires, Animal.espece_id, Animal.race_id
from `Animal`
inner join `Race`
on `Animal`.race_id = `Race`.id
where Race.nom = 'Berger allemand';


SELECT id, nom, espece_id
FROM Animal
WHERE espece_id not in (
    SELECT id
    FROM Espece
    WHERE nom_courant = 'Tortue d''Hermann' or  nom_courant = 'Perroquet amazone'
);


SELECT *
FROM Animal
WHERE espece_id < ANY (
    SELECT id
    FROM Espece
    WHERE nom_courant IN ('Tortue d''Hermann', 'Perroquet amazone')
);


SELECT *
FROM Animal
WHERE espece_id < ALL (
    SELECT id
    FROM Espece
    WHERE nom_courant IN ('Tortue d''Hermann', 'Perroquet amazone')
);


select id, nom, espece_id
from Race
where exists (select * from Animal where nom = 'balou');

select *
from Race
where not exists (select * from Animal where Race.id = Animal.race_id);
