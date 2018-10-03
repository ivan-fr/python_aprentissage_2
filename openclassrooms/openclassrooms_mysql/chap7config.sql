SHOW VARIABLES;

SHOW VARIABLES LIKE '%auto_increment%';

SHOW VARIABLES LIKE 'unique_checks';

SELECT @@autocommit;

SHOW GLOBAL VARIABLES;
SHOW SESSION VARIABLES;

SELECT @@GLOBAL.nom_variable;
SELECT @@SESSION.nom_variable;


SHOW VARIABLES LIKE 'last_insert_id';
SHOW SESSION VARIABLES LIKE 'last_insert_id';
SHOW GLOBAL VARIABLES LIKE 'last_insert_id';


SHOW VARIABLES LIKE 'max_connections';
SHOW SESSION VARIABLES LIKE 'max_connections';
SHOW GLOBAL VARIABLES LIKE 'max_connections';


SELECT @@max_connections AS max_connections, 
        @@last_insert_id AS last_insert_id;
SELECT @@GLOBAL.max_connections AS max_connections, 
       @@SESSION.last_insert_id AS last_insert_id;
       

SELECT @@SESSION.max_connections;
SELECT @@GLOBAL.last_insert_id;


SET niveau nom_variable = valeur;
-- OU
SET @@niveau.nom_variable = valeur;


SET SESSION max_tmp_tables = 5; -- Nombre maximal de tables temporaires 
SET @@GLOBAL.storage_engine = InnoDB; -- Moteur de stockage par défaut


SET max_tmp_tables = 12;
SET @@max_tmp_tables = 8;

SET @@max_connections = 200;


SELECT @@GLOBAL.storage_engine, @@SESSION.storage_engine;


SET NAMES encodage;

SET [GLOBAL | SESSION] TRANSACTION ISOLATION LEVEL { REPEATABLE READ | READ COMMITTED | READ UNCOMMITTED | SERIALIZABLE }

