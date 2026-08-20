-- My types for enums in columns
CREATE TYPE "module_type"
AS ENUM ('foundational', 'project', 'curiosity');

CREATE TYPE "chapter_type"
AS ENUM ('regular', 'elective', 'career');

CREATE TYPE "semester_type"
AS ENUM ('Michaelmas', 'Lent', 'Easter');

-- My tables
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
    "username" VARCHAR(120) NOT NULL,
    "password_hash" TEXT NOT NULL,
	PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "modules" (
	"id" SERIAL,
    "user_id" INTEGER NOT NULL,
    "semester_id" INTEGER, -- Null semester modules are backlog to pick from
    "title" VARCHAR(255) NOT NULL,
    "category" "module_type" NOT NULL DEFAULT 'foundational' ::module_type,
	PRIMARY KEY ("id"),
    FOREIGN KEY ("semester_id") REFERENCES "semesters"("id"),
    FOREIGN KEY ("user_id") REFERENCES "users"("id")
);

CREATE TABLE IF NOT EXISTS "chapters" (
	"id" SERIAL,
    "user_id" INTEGER NOT NULL,
    "module_id" INTEGER, -- Null module means standalone chapter
    "title" VARCHAR(255) NOT NULL,
    "category" "chapter_type" NOT NULL DEFAULT 'regular' ::chapter_type,
    "done" BOOLEAN NOT NULL DEFAULT FALSE,
	PRIMARY KEY ("id"),
    FOREIGN KEY ("module_id") REFERENCES "modules"("id"),
    FOREIGN KEY ("user_id") REFERENCES "users"("id")
);

CREATE TABLE IF NOT EXISTS "assignments" (
	"id" SERIAL,
    "chapter_id" INTEGER,
    "title" VARCHAR(255) NOT NULL,
	PRIMARY KEY ("id"),
    FOREIGN KEY ("chapter_id") REFERENCES "chapters"("id")
);
