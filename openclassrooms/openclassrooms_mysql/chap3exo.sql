use elevage;

select count(*) as nb_race
from Race;

select count(pere_id) as nb_chient
from Animal
inner join Espece
on Espece.id = Animal.espece_id
where Espece.nom_courant = 'chien';

select max(date_naissance)
from Animal
where sexe = 'F';

select coalesce(Espece.nom_courant, 'total'), avg(Race.prix) as prix_moyen
from Race
inner join Espece
on Race.espece_id = Espece.id
where Espece.nom_courant in ('Chien', 'Chat')
group by Espece.nom_courant with rollup;

select sexe, count(*), group_concat(Animal.nom, '(', Espece.nom_courant, ')')
from Animal
inner join Espece
on Espece.id = Animal.espece_id
where Espece.nom_courant like 'Perroquet%'
group by Animal.sexe;

select Race.nom, count(Animal.race_id) as nombre
from Race
left join Animal
on Animal.race_id = Race.id
group by Race.nom
having nombre = 0;

select Espece.nom_courant, Espece.nom_latin, count(Animal.espece_id) as nombre
from Espece
left join Animal
on Animal.espece_id = Espece.id
where Animal.sexe = 'M' or Animal.id is null
group by Espece.nom_latin
having nombre < 5;

SELECT Animal.sexe, Race.nom, Espece.nom_courant, COUNT(*) AS nombre
FROM Animal
INNER JOIN Espece ON Animal.espece_id = Espece.id
INNER JOIN Race ON Animal.race_id = Race.id
WHERE Animal.sexe IS NOT NULL
GROUP BY Espece.nom_courant, Race.nom, sexe WITH ROLLUP;

select Espece.nom_courant, sum(coalesce(Race.prix, Espece.prix))
from Animal
inner join Espece on Espece.id = Animal.espece_id
left join Race on Race.id = Animal.race_id
where Animal.nom IN ('Parlotte', 'Spoutnik', 'Caribou', 'Cartouche', 'Cali', 'Canaille', 'Yoda', 'Zambo', 'Lulla')
group by Espece.nom_courant with rollup;
