USE elevage;

SELECT *
FROM Animal
WHERE commentaires LIKE '%\%%';

SELECT *
FROM Animal
WHERE nom LIKE '%lu%'; -- insensible à la case

SELECT *
FROM Animal
WHERE nom LIKE BINARY '%Lu%'; -- sensible à la casseêê

SELECT *
FROM Animal
WHERE id LIKE '1%';

SELECT *
FROM Animal
WHERE date_naissance BETWEEN '2008-01-05' AND '2009-03-15';

BETWEEN BINARY ... AND BINARY ... -- insensible à la case

SELECT *
FROM Animal
WHERE nom IN ('Moka', 'Bilba', 'Tortilla', 'Balou', 'Dana', 'Redbul', 'Gingko');
