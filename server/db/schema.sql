CREATE TABLE IF NOT EXISTS "semesters" (
	"id" SERIAL,
    "name" "semester_type" NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
	PRIMARY KEY ("id"),
    UNIQUE ("name", "start_date") -- Ensuring there is only one Easter 2026, then Easter 2027 etc.
);

CREATE TABLE IF NOT EXISTS "users" (
    "id" SERIAL,
    "username" VARCHAR(120) NOT NULL UNIQUE,
    "password_hash" TEXT NOT NULL,
    "email" VARCHAR(255) UNIQUE, -- For retrieving passwords
    "deleted" BOOLEAN NOT NULL DEFAULT FALSE, -- Soft delete implemented on users
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "modules" (
	"id" SERIAL,
    "user_id" INTEGER NOT NULL,
    "semester_id" INTEGER, -- Null semester modules are backlog to pick from
    "title" VARCHAR(255) NOT NULL,
    "category" "module_type" NOT NULL DEFAULT 'foundational', -- I imagine this as default value in the dropdown menu
	PRIMARY KEY ("id"),
    FOREIGN KEY ("semester_id") REFERENCES "semesters"("id") ON DELETE SET NULL, -- If semester gets deleted, module falls to backlog
    FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE -- All user's data gets deleted when user is actually removed
);

CREATE TABLE IF NOT EXISTS "chapters" (
	"id" SERIAL,
    "user_id" INTEGER NOT NULL,
    "module_id" INTEGER, -- Null module means standalone chapter
    "title" VARCHAR(255) NOT NULL,
    "category" "chapter_type" NOT NULL DEFAULT 'regular',
    "done" BOOLEAN NOT NULL DEFAULT FALSE,
	PRIMARY KEY ("id"),
    FOREIGN KEY ("module_id") REFERENCES "modules"("id") ON DELETE CASCADE,
    FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS "assignments" (
	"id" SERIAL,
    "chapter_id" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "done" BOOLEAN NOT NULL DEFAULT FALSE,
	PRIMARY KEY ("id"),
    FOREIGN KEY ("chapter_id") REFERENCES "chapters"("id") ON DELETE CASCADE
);


CREATE VIEW "active_users" AS
SELECT * FROM "users"
WHERE "deleted" = FALSE;

CREATE VIEW "current_semester_id" AS
SELECT "id" FROM "semesters"
WHERE "start_date" <= CURRENT_DATE
AND "end_date" >= CURRENT_DATE;

CREATE VIEW "next_semester_id" AS
SELECT "id" FROM "semesters"
WHERE "start_date" > CURRENT_DATE
ORDER BY "start_date" ASC
LIMIT 1;

CREATE VIEW "last_semester_id" AS
SELECT "id" FROM "semesters"
WHERE "end_date" < CURRENT_DATE
ORDER BY "end_date" DESC
LIMIT 1;

CREATE VIEW "current_modules" AS
SELECT * FROM "modules"
WHERE "semester_id" = (SELECT "id" FROM "current_semester_id")
OR "semester_id" = (SELECT "id" FROM "next_semester_id");


CREATE INDEX "idx_modules_semester_id" ON modules (semester_id);
CREATE INDEX "idx_modules_user_id" ON modules (user_id);
CREATE INDEX "idx_chapters_module_id" ON chapters (module_id);
CREATE INDEX "idx_chapters_user_id" ON chapters (user_id);
CREATE INDEX "idx_assignments_chapter_id" ON assignments (chapter_id);
