USE elevage;

insert into Animal (nom, sexe, date_naissance, race_id, espece_id)
SELECT 'Yoda', 'M', '2010-11-09', id AS race_id, espece_id
FROM Race 
WHERE nom = 'Maine coon';

SELECT Animal.id, Animal.sexe, Animal.nom, Race.nom AS race, Espece.nom_courant as espece
from Animal
inner join Race
on Race.id = Animal.race_id
inner join Espece
on Espece.id = Animal.espece_id
where Race.nom = 'Maine coon';

update Animal
set commentaires = 'coco veut un gateau'
where espece_id = (select id from Espece where nom_courant like 'Perroquet%');

insert into Race (nom, espece_id, description)
VALUES ('Nebelung', 2, 'Chat bleu russe, mais avec des poils longs...');

update Animal
set race_id = (select id from Race where nom = 'Nebelung' and espece_id = 2)
where Animal.nom = 'Callune';

SET SQL_SAFE_UPDATES = 0;

update Animal
inner join Espece
on Animal.espece_id = Espece.id
set Animal.commentaires = Espece.description
where Animal.commentaires is null
		   and Espece.nom_courant in ('Tortue d''Hermann',  'Perroquet amazone');
           
delete from Animal
where Animal.nom = 'Carabistouille' 
		   and Animal.espece_id = (select id from Espece where Espece.nom_courant = 'chat');
	
delete Animal from Animal
inner join Espece
on Animal.espece_id = Espece.id
where Espece.nom_courant = 'chat'
		   and Animal.nom = 'Carabistouille';
           



