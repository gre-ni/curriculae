from db import get_connection

with get_connection() as con:
    with con.cursor() as cursor:
        cursor.execute("""CREATE TABLE "cards" (
	"id" SERIAL,
    "name" VARCHAR(32) NOT NULL,
	PRIMARY KEY("id")
);""")