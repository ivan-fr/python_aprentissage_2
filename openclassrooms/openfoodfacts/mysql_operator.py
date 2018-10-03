import mysql.connector

mydb = mysql.connector.connect(host="localhost",
                               user="openfoodfacts",
                               passwd="hWfY7Uv82k7L9f2Sr._.",
                               database="openfoodfacts")

print(mydb)

cursor = mydb.cursor()

cursor.execute("SHOW TABLES")

for x in cursor:
    print(x)

