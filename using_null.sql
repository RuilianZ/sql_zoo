
teacher
id	dept	name	phone	mobile
101	1	Shrivell	2753	07986 555 1234
102	1	Throd	2754	07122 555 1920
103	1	Splint	2293
104		Spiregrain	3287
105	2	Cutflower	3212	07996 555 6574
106		Deadyawn	3345
...
dept
id	name
1	Computing
2	Design
3	Engineering
...

The school includes many departments. Most teachers work exclusively for a single department. Some teachers have no department.

Note the INNER JOIN misses the teachers with no department and the departments with no teacher.
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

Use a different JOIN so that all teachers are listed.
SELECT teacher.name, dept.name
 FROM teacher left JOIN dept
           ON (teacher.dept=dept.id)

Use a different JOIN so that all departments are listed.
SELECT teacher.name, dept.name
 FROM teacher right JOIN dept
           ON (teacher.dept=dept.id)

Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'
SELECT
name,
COALESCE(mobile, '07986 444 2266')
FROM teacher

Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
SELECT
teacher.name,
COALESCE(dept.name, 'None')
FROM teacher
left join dept on teacher.dept = dept.id
