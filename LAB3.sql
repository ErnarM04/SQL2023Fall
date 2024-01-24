-- 1:
-- a
SELECT title
FROM course
WHERE dept_name = 'Biology' AND credits > 3;

-- b
SELECT *
FROM classroom
WHERE building = 'Watson' OR building = 'Painter';

-- c
SELECT *
FROM course
WHERE dept_name = 'Comp. Sci.';

-- d
SELECT *
FROM section
WHERE semester = 'Spring';

-- e
SELECT *
FROM student
WHERE tot_cred > 45 AND tot_cred < 85;

-- f
SELECT *
FROM course
WHERE title LIKE '%[aeiou]';

-- g
SELECT c.*
FROM course c, prereq p
WHERE c.course_id = p.course_id AND p.prereq_id = 'EE-181';

-- 2:
-- a
SELECT dept_name, AVG(salary) AS avg_salary
FROM instructor
GROUP BY dept_name
ORDER BY avg_salary;

-- b
SELECT section.building, COUNT(*) AS course_count
FROM section, classroom
WHERE section.building = classroom.building AND section.room_number = classroom.room_number
GROUP BY section.building
ORDER BY course_count DESC
LIMIT 1;

-- c
SELECT dept_name, COUNT(*) AS course_count
FROM course
GROUP BY dept_name
ORDER BY course_count
LIMIT 1;

-- d
SELECT s.ID, s.name, COUNT(*) AS count
FROM student s, takes t, course c
WHERE s.ID = t.ID AND t.course_id = c.course_id AND c.dept_name = 'Comp. Sci.'
GROUP BY s.ID, s.name
ORDER BY count DESC
LIMIT 1;

-- e
SELECT i.ID, i.name
FROM instructor i, department d
WHERE i.dept_name = d.dept_name AND d.building = 'Taylor';

-- f
SELECT *
FROM instructor
WHERE dept_name IN ('Biology', 'Philosophy', 'Music');

-- g
SELECT ID, name
FROM instructor
WHERE ID IN (SELECT DISTINCT ID FROM teaches WHERE year = 2018)
AND ID NOT IN (SELECT DISTINCT ID FROM teaches WHERE year = 2023);

-- 3:
-- a
SELECT s.ID, s.name
FROM student s, takes t, course c
WHERE s.ID = t.ID AND t.course_id = c.course_id AND c.dept_name = 'Comp. Sci.' AND t.grade IN ('A', 'A-')
ORDER BY s.name;

-- b
SELECT DISTINCT a.i_ID, i.name AS advisor_name
FROM advisor a, student s, takes t, instructor i
WHERE a.s_ID = s.ID AND s.ID = t.ID AND t.grade NOT IN ('B', 'C', 'D', 'F') AND a.i_ID = i.ID;

-- c
SELECT d.dept_name
FROM department d
WHERE NOT EXISTS (
    SELECT 1
    FROM student s, takes t
    WHERE s.dept_name = d.dept_name AND s.ID = t.ID AND t.grade IN ('C', 'F')
);

-- d
SELECT ID, name
FROM instructor
WHERE ID NOT IN (
    SELECT DISTINCT ID
    FROM teaches
    WHERE grade IN ('A', 'A-')
);

-- e
SELECT c.*
FROM course c, section s, time_slot t
WHERE c.course_id = s.course_id AND s.time_slot_id = t.time_slot_id AND t.end_hr < 13;




















SELECT s.ID, s.name
FROM student s, COUNT(*) as count
WHERE s.dept_name = 'Comp. Sci.' and co

;

SELECT *
FROM course
WHERE course_id in (SELECT course.course_id
                           from course, prereq
                           WHERE course.course_id = prereq.prereq_id AND prereq_id = 'EE-181')
ORDER BY course.title;