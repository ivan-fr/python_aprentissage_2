
use elevage;

select Animal.nom
from Animal
where month(Animal.date_naissance) = 6;


select Animal.nom
from Animal
where weekofyear(Animal.date_naissance) <= 8;


SELECT Animal.id, Animal.date_naissance, Animal.nom,  dayofmonth(Animal.date_naissance), monthname(Animal.date_naissance)
FROM Animal
inner join Espece on Animal.espece_id = Espece.id
WHERE (Espece.nom_courant like 'tortue%' or Espece.nom_courant = 'chat')
			   and year(Animal.date_naissance) < 2007;
               

SELECT Animal.id, Animal.date_naissance, Animal.nom,  DATE_FORMAT(date_naissance, '%e %M') as date_jour_moi
FROM Animal
inner join Espece on Animal.espece_id = Espece.id
WHERE (Espece.nom_courant like 'tortue%' or Espece.nom_courant = 'chat')
			   and year(Animal.date_naissance) < 2007;
               
               
select Animal.nom, date_format(Animal.date_naissance, '%e %M, à %lh%i%p, en l''an %Y après J.-C.')
from Animal
where month(Animal.date_naissance) = 4
		   and dayofmonth(date_naissance) <> 24
order by time(Animal.date_naissance) desc;


select Animal.nom, datediff(Animal.date_naissance, '2008-02-27')
from Animal
where Animal.nom = 'Moka';


select Animal.nom, Animal.date_naissance, date_add(Animal.date_naissance, interval 25 year)
from Animal
where Animal.espece_id = 4;


select Animal.nom
from Animal
where day(LAST_DAY(Animal.date_naissance)) = 29;


select Animal.nom, date(date_naissance), date(adddate(date_naissance, interval 12 week))
from Animal
where Animal.espece_id = 2;


select timestampdiff(minute, 
								(select date_naissance from Animal where nom = 'balou'),
                                (select date_naissance from Animal where nom = 'zira')
) as minutes;


select timestampdiff(minute,
								(select min(date_naissance) from Animal where id in (13, 18, 20, 22)),
                                (select max(date_naissance) from Animal where id in (13, 18, 20, 22))
) as minutes;


select count(*)
from Animal
where monthname(date_naissance) like '%bre';


SELECT DATE_FORMAT(Animal.date_naissance, '%d/%m/%Y'), COUNT(*) as nb_individus, Animal.espece_id
FROM Animal
WHERE Animal.espece_id IN (1, 2)
GROUP BY DATE(Animal.date_naissance)
having nb_individus > 1;

select avg(nummberr.nb) from (
select count(*) as nb
from Animal
where Animal.espece_id = 1 and (year(date_naissance) between 2006 and 2010)
group by year(date_naissance)
) as nummberr;


select date_format(date_add(date_naissance, interval 5 year), get_format(datetime, 'iso'))
from Animal
where Animal.mere_id is not null
		   or Animal.pere_id is not null;
