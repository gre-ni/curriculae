-- Draft queries:

-- Fill in semester information (at seeding stage)
INSERT INTO "semester" ("name", "start_date", "end_date")
VALUES
('Michaelmas', '2026-10-01', '2026-12-19'),
('Lent','2027-01-05','2027-03-25'),
('Easter','2027-04-17','2027-06-25');

-- Create a new user / registration
INSERT INTO "users" ("username","password_hash","email")
VALUES
('admin','$2b$12$KIXQJf8yV5X7Qz3mN8vLZeYh1Wg4RtC6BpS9oJdA2LnMcT7uKvXHW','admin.curriculae@gmail.com');

-- Add a new chapter to a module
INSERT INTO "chapters" ("user_id", "module_id", "title")
VALUES
(5, 3, 'Optimizing Startegies');

-- Add 3 assignments to a chapter
INSERT INTO "assignments" ("chapter_id", "title")
VALUES
(6, 'Chapter 2 in Designing Data-Intensive Applications'),
(6, 'Practice indexing on movies db'),
(6, 'Submit PSET problem 3');

-- Check that entered password matches, get id of who logged in:
SELECT "id" FROM "active_users" -- We don't want to sign in a user that's been deleted
WHERE "username" = 'admin'
AND "password_hash" = '$2b$12$KIXQJf8yV5X7Qz3mN8vLZeYh1Wg4RtC6BpS9oJdA2LnMcT7uKvXHW';

-- What semester is it today or next? In 'Easter, 2027' format:
SELECT "name", EXTRACT(YEAR FROM "start_date") AS "year" FROM "semesters"
WHERE "id" = (SELECT "id" FROM "current_semester_id")
OR "id" = (SELECT "id" FROM "next_semester_id");

-- What modules am I currently signed up to?
SELECT "name" FROM "current_modules"
WHERE "user_id" = 5; -- My assumed user id, from session storage

-- Show all chapters and assignments belonging to this module
SELECT * FROM "chapters"
JOIN "assignment" ON "chapters"."id" = "assignments"."chapter_id"
WHERE "module_id" = 3;

-- Change assignment name
UPDATE "assignments" SET "title" = 'Read Chapter 3'
WHERE "id" = 5;

-- Select module for upcoming semester
UPDATE "modules" SET "semester_id" = (
    SELECT "id" FROM "next_semester_id"
)
WHERE "module_id" = 3;

-- Mark chapter with an 'elective' tag
UPDATE "chapters" SET "category" = 'elective'
WHERE "id" = 3;

-- Mark assignment as done
UPDATE "assignments" SET "done" = TRUE
WHERE "id" = 6;

-- 'Delete' a user, a soft delete from the UI
UPDATE "users" SET "deleted" = TRUE
WHERE "id" = 16;

-- Delete an assignment
DELETE FROM "assignments" WHERE "id" = 3;


