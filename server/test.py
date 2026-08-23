from db import get_connection

with get_connection() as con:
    with con.cursor() as cursor:
        answer = cursor.execute("""
        SELECT "name", EXTRACT(YEAR FROM "start_date") AS "year" FROM "semesters"
    WHERE "id" = (SELECT "id" FROM "current_semester_id")
    OR "id" = (SELECT "id" FROM "next_semester_id");
    """).fetchall()
        
print(answer)