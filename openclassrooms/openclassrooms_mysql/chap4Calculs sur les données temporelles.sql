SELECT DATEDIFF('2011-12-25','2011-11-10') AS nb_jours;
SELECT DATEDIFF('2011-12-25 22:12:18','2011-11-10 12:15:41') AS nb_jours;
SELECT DATEDIFF('2011-12-25 22:12:18','2011-11-10') AS nb_jours;

-- Avec des DATETIME
SELECT '2011-10-08 12:35:45' AS datetime1, '2011-10-07 16:00:25' AS datetime2, TIMEDIFF('2011-10-08 12:35:45', '2011-10-07 16:00:25') as difference;

-- Avec des TIME
SELECT '12:35:45' AS time1, '00:00:25' AS time2, TIMEDIFF('12:35:45', '00:00:25') as difference;

SELECT TIMESTAMPDIFF(DAY, '2011-11-10', '2011-12-25') AS nb_jours,
       TIMESTAMPDIFF(HOUR,'2011-11-10', '2011-12-25 22:00:00') AS nb_heures_def, 
       TIMESTAMPDIFF(HOUR,'2011-11-10 14:00:00', '2011-12-25 22:00:00') AS nb_heures,
       TIMESTAMPDIFF(QUARTER,'2011-11-10 14:00:00', '2012-08-25 22:00:00') AS nb_trimestres;
       
SELECT ADDDATE('2011-05-21', INTERVAL 3 MONTH) AS date_interval,  
        -- Avec DATE et INTERVAL
       ADDDATE('2011-05-21 12:15:56', INTERVAL '3 02:10:32' DAY_SECOND) AS datetime_interval, 
        -- Avec DATETIME et INTERVAL
       ADDDATE('2011-05-21', 12) AS date_nombre_jours,                                        
        -- Avec DATE et nombre de jours
       ADDDATE('2011-05-21 12:15:56', 42) AS datetime_nombre_jours;                           
        -- Avec DATETIME et nombre de jours
        
SELECT DATE_ADD('2011-05-21', INTERVAL 3 MONTH) AS avec_date,       
        -- Avec DATE
       DATE_ADD('2011-05-21 12:15:56', INTERVAL '3 02:10:32' DAY_SECOND) AS avec_datetime;  
        -- Avec DATETIME
        
	
SELECT '2011-05-21' + INTERVAL 5 DAY AS droite,                    
        -- Avec DATE et intervalle à droite
       INTERVAL '3 12' DAY_HOUR + '2011-05-21 12:15:56' AS gauche; 
        -- Avec DATETIME et intervalle à gauche
        
SELECT TIMESTAMPADD(DAY, 5, '2011-05-21') AS avec_date,            
        -- Avec DATE
       TIMESTAMPADD(MINUTE, 34, '2011-05-21 12:15:56') AS avec_datetime;  
        -- Avec DATETIME
        
SELECT NOW() AS Maintenant, ADDTIME(NOW(), '01:00:00') AS DansUneHeure,  
        -- Avec un DATETIME
       CURRENT_TIME() AS HeureCourante, ADDTIME(CURRENT_TIME(), '03:20:02') AS PlusTard; 
        -- Avec un TIME
        
SELECT SUBDATE('2011-05-21 12:15:56', INTERVAL '3 02:10:32' DAY_SECOND) AS SUBDATE1, 
       SUBDATE('2011-05-21', 12) AS SUBDATE2,
       DATE_SUB('2011-05-21', INTERVAL 3 MONTH) AS DATE_SUB;

SELECT SUBTIME('2011-05-21 12:15:56', '18:35:15') AS SUBTIME1,
       SUBTIME('12:15:56', '8:35:15') AS SUBTIME2;
       
SELECT '2011-05-21' - INTERVAL 5 DAY;

SELECT ADDDATE(NOW(), INTERVAL -3 MONTH) AS ajout_negatif, SUBDATE(NOW(), INTERVAL 3 MONTH) AS retrait_positif;
SELECT DATE_ADD(NOW(), INTERVAL 4 HOUR) AS ajout_positif, DATE_SUB(NOW(), INTERVAL -4 HOUR) AS retrait_negatif;
SELECT NOW() + INTERVAL -15 MINUTE AS ajout_negatif, NOW() - INTERVAL 15 MINUTE AS retrait_positif;


SELECT FROM_UNIXTIME(1325595287);

SELECT UNIX_TIMESTAMP('2012-01-03 13:54:47');

SELECT MAKEDATE(2012, 60) AS 60eJour2012, MAKETIME(3, 45, 34) AS heureCree;

SELECT SEC_TO_TIME(102569), TIME_TO_SEC('01:00:30');

SELECT LAST_DAY('2016-02-03') AS fevrier2016, LAST_DAY('2100-02-03') AS fevrier2100;

