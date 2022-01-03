
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
