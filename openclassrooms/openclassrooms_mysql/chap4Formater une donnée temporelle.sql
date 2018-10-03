use elevage;

SELECT nom, date_naissance, 
        DATE(date_naissance) AS uniquementDate
FROM Animal
WHERE espece_id = 4;


SELECT nom, DATE(date_naissance) AS date_naiss, 
        DAY(date_naissance) AS jour, 
        DAYOFMONTH(date_naissance) AS jour, 
        DAYOFWEEK(date_naissance) AS jour_sem,
        WEEKDAY(date_naissance) AS jour_sem2,
        DAYNAME(date_naissance) AS nom_jour, 
        DAYOFYEAR(date_naissance) AS jour_annee
FROM Animal
WHERE espece_id = 4;

SET lc_time_names = 'fr_FR';

SELECT nom, date_naissance, 
        DAYNAME(date_naissance) AS jour_semaine 
FROM Animal
WHERE espece_id = 4;

SELECT nom, date_naissance, WEEK(date_naissance) AS semaine, WEEKOFYEAR(date_naissance) AS semaine2, YEARWEEK(date_naissance) AS semaine_annee
FROM Animal
WHERE espece_id = 4;

SELECT nom, date_naissance, MONTH(date_naissance) AS numero_mois, MONTHNAME(date_naissance) AS nom_mois
FROM Animal
WHERE espece_id = 4;

SELECT nom, date_naissance, YEAR(date_naissance)
FROM Animal
WHERE espece_id = 4;

SELECT nom, date_naissance, 
       TIME(date_naissance) AS time_complet, 
       HOUR(date_naissance) AS heure, 
       MINUTE(date_naissance) AS minutes, 
       SECOND(date_naissance) AS secondes
FROM Animal
WHERE espece_id = 4;

SELECT nom, date_naissance, CONCAT_WS(' ', 'le', DAYNAME(date_naissance), DAY(date_naissance), MONTHNAME(date_naissance), YEAR(date_naissance)) AS jolie_date
FROM Animal
WHERE espece_id = 4;

SELECT nom, date_naissance, DATE_FORMAT(date_naissance, 'le %W %e %M %Y') AS jolie_date
FROM Animal
WHERE espece_id = 4;

SELECT DATE_FORMAT(NOW(), 'Nous sommes aujourd''hui le %d %M de l''année %Y. Il est actuellement %l heures et %i minutes.') AS Top_date_longue;

SELECT DATE_FORMAT(NOW(), '%d %b. %y - %r') AS Top_date_courte;

-- Sur une DATETIME
SELECT TIME_FORMAT(NOW(), '%r') AS sur_datetime, 
       TIME_FORMAT(CURTIME(), '%r') AS sur_time, 
       TIME_FORMAT(NOW(), '%M %r') AS mauvais_specificateur, 
       TIME_FORMAT(CURDATE(), '%r') AS sur_date;
       
SELECT DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'EUR')) AS date_eur,
       DATE_FORMAT(NOW(), GET_FORMAT(TIME, 'JIS')) AS heure_jis,
       DATE_FORMAT(NOW(), GET_FORMAT(DATETIME, 'USA')) AS date_heure_usa;

SELECT STR_TO_DATE('03/04/2011 à 09h17', '%d/%m/%Y à %Hh%i') AS StrDate,
       STR_TO_DATE('15blabla', '%Hblabla') StrTime;
       
SELECT STR_TO_DATE('11.21.2011', GET_FORMAT(DATE, 'USA')) AS date_usa,
       STR_TO_DATE('12.34.45', GET_FORMAT(TIME, 'EUR')) AS heure_eur,
       STR_TO_DATE('20111027133056', GET_FORMAT(TIMESTAMP, 'INTERNAL')) AS date_heure_int;
       