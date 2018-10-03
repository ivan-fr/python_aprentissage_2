-- fonction pour les nombres
SELECT CEIL(3.2), CEIL(3.7); -- entier superieur

SELECT FLOOR(3.2), FLOOR(3.7); -- entier inferieur

SELECT ROUND(3.22, 1), ROUND(3.55, 1), ROUND(3.77, 1); -- à l'entier le plus proche

SELECT ROUND(3.2), ROUND(3.5), ROUND(3.7);

SELECT TRUNCATE(3.2, 0), TRUNCATE(3.5, 0), TRUNCATE(3.7, 0); -- arrondit en enlevant purement et simplement les décimales en trop 

SELECT TRUNCATE(3.22, 1), TRUNCATE(3.55, 1), TRUNCATE(3.77, 1);

SELECT POW(2, 5), POWER(5, 2); -- a exposant b

SELECT sqrt(4);

SELECT POW(32, 1/5);

SELECT RAND();

SELECT * 
FROM Race 
ORDER BY RAND();

SELECT SIGN(-43), SIGN(0), SIGN(37);

SELECT ABS(-43), ABS(0), ABS(37);

SELECT MOD(56, 10);  -- modulo


-- fonction pour les chaine de caractere
SELECT BIT_LENGTH('élevage'), 
       CHAR_LENGTH('élevage'), 
       LENGTH('élevage'); -- Les caractères accentués sont codés sur 2 octets en UTF-8
            
SELECT STRCMP('texte', 'texte') AS 'texte=texte', 
       STRCMP('texte','texte2') AS 'texte<texte2', 
       STRCMP('chaine','texte') AS 'chaine<texte', 
       STRCMP('texte', 'chaine') AS 'texte>chaine',
       STRCMP('texte3','texte24') AS 'texte3>texte24'; -- 3 est après 24 dans l'ordre alphabétique
       
SELECT REPEAT('Ok ', 3);

SELECT LPAD('texte', 3, '@') AS '3_gauche_@', 
       LPAD('texte', 7, '$') AS '7_gauche_$', 
       RPAD('texte', 5, 'u') AS '5_droite_u', 
       RPAD('texte', 7, '*') AS '7_droite_*', 
       RPAD('texte', 3, '-') AS '3_droite_-';
       
SELECT TRIM('   Tralala  ') AS both_espace, 
       TRIM(LEADING FROM '   Tralala  ') AS lead_espace, 
       TRIM(TRAILING FROM '   Tralala  ') AS trail_espace,

       TRIM('e' FROM 'eeeBouHeee') AS both_e,
       TRIM(LEADING 'e' FROM 'eeeBouHeee') AS lead_e,
       TRIM(BOTH 'e' FROM 'eeeBouHeee') AS both_e,

       TRIM('123' FROM '1234ABCD4321') AS both_123;

SELECT SUBSTRING('texte', 2) AS from2,
        SUBSTRING('texte' FROM 3) AS from3,
        SUBSTRING('texte', 2, 3) AS from2long3, 
        SUBSTRING('texte' FROM 2 FOR 1) AS from3long1;
        
SELECT INSTR('tralala', 'la') AS fct_INSTR,
       POSITION('la' IN 'tralala') AS fct_POSITION,
       LOCATE('la', 'tralala') AS fct_LOCATE,
       LOCATE('la', 'tralala', 5) AS fct_LOCATE2;
       
SELECT LOWER('AhAh') AS minuscule, 
        LCASE('AhAh') AS minuscule2, 
        UPPER('AhAh') AS majuscule,
        UCASE('AhAh') AS majuscule2;

SELECT LEFT('123456789', 5), RIGHT('123456789', 5);

SELECT REVERSE('abcde');

SELECT INSERT('texte', 3, 2, 'blabla') AS fct_INSERT, 
        REPLACE('texte', 'e', 'a') AS fct_REPLACE, 
        REPLACE('texte', 'ex', 'ou') AS fct_REPLACE2;
        

SELECT CONCAT('My', 'SQL', '!'), CONCAT_WS('-', 'My', 'SQL', '!');

SELECT FIELD('Bonjour', 'Bonjour !', 'Au revoir', 'Bonjour', 'Au revoir !') AS field_bonjour;

SELECT nom_courant, nom_latin,
FIELD(nom_courant, 'Rat brun', 'Chat', 'Tortue d''Hermann', 'Chien', 'Perroquet amazone') AS resultat_field
FROM Espece
ORDER BY FIELD(nom_courant, 'Rat brun', 'Chat', 'Tortue d''Hermann', 'Chien', 'Perroquet amazone');

SELECT ASCII('T'), CHAR(84), CHAR('84', 84+32, 84.2);

-- exercices
select concat('un(e) ', nom_courant, ' coute ', prix, ' euros.') as phrase
from Espece;

select concat_ws(' ', 'un(e) ', nom_courant, ' coute ', prix, ' euros.') as phrase
from Espece;

select Animal.nom
from Animal
inner join Espece
on Animal.espece_id = Espece.id
where Espece.nom_courant = 'chat'
		   and SUBSTRING(Animal.nom FROM 2 FOR 1)  = 'a';

select replace(replace(Animal.nom, 'a', '@'), 'e', 3) as solution
from Animal
inner join Espece
on Animal.espece_id = Espece.id
where Espece.nom_courant like 'Perroquet%';

select Animal.nom
from Animal
inner join Espece
on Animal.espece_id = Espece.id
where Espece.nom_courant = 'chien'
		   and CHAR_LENGTH(Animal.nom) % 2 = 0;

-- OU

SELECT nom, nom_courant
FROM Animal
INNER JOIN Espece ON Animal.espece_id = Espece.id
WHERE nom_courant = 'Chien' 
AND CHAR_LENGTH(nom) MOD 2 = 0;

-- OU

SELECT nom, nom_courant
FROM Animal
INNER JOIN Espece ON Animal.espece_id = Espece.id
WHERE nom_courant = 'Chien' 
AND MOD(CHAR_LENGTH(nom),2) = 0;

