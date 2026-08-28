import { useEffect, useState } from "react";
import type { Semester } from "../types";

const BASE_URL = import.meta.env.VITE_API_URL;

export const SemesterBar = () => {
    const [semester, setSemester] = useState<Semester>();

    useEffect(() => {
        async function loadSemester() {
            const response = await fetch(`${BASE_URL}/api/semester`);
            const data = await response.json();
            console.log(data);
            setSemester(data);
        }
        loadSemester();
    }, []);

    if (semester !== undefined) {
        return (
            <div>
                <p>{semester.name}</p>
            </div>
        );
    }
    return <p>I don't know, something went wrong.</p>;
};
