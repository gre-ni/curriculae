export type Semester = {
    id: number;
    name: "Michaelmas" | "Lent" | "Easter";
    start_date: string;
    end_date: string;
    state: "current" | "upcoming";
};
