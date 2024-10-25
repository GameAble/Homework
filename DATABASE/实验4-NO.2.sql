-- 1. 查询成绩大于分的学生的学号和姓名（使用连接）
SELECT s.sno, s.sname
FROM student s JOIN sc ON s.sno = sc.sno
WHERE sc.grade > 90;
GO

-- 1. 查询成绩大于分的学生的学号和姓名（使用子查询）有误，但是我目前做不出来了
SELECT sno, sname
FROM student
WHERE sno IN (
    SELECT sno
    FROM sc
    WHERE grade > 90
);
GO

-- 2. 查询所有学生的学号、姓名，所选课程的课程号、课程名和成绩信息
SELECT s.sno, s.sname, c.cno, c.cname, sc.grade
FROM student s
JOIN sc ON s.sno = sc.sno
JOIN course c ON sc.cno = c.cno;
GO

-- 3. 查询每一门课的间接先修课（先修课的先修课）
SELECT c1.cno AS course_no, c1.cname AS course_name, c2.cname AS indirect_prerequisite_name
FROM course c1
JOIN course c2 ON c1.cpno = c2.cno
JOIN course c3 ON c2.cpno = c3.cno;
GO

-- 4. 查询“Y71814001”号同学选修，但“Y71814003”号同学未选的课程的课程号及课程名
SELECT c.cno, c.cname
FROM course c
JOIN sc sc1 ON c.cno = sc1.cno
WHERE sc1.sno = 'Y71814001'
AND sc1.cno NOT IN (
    SELECT sc2.cno
    FROM sc sc2
    WHERE sc2.sno = 'Y71814003'
);
GO

-- 5. 查询程熙的成绩
SELECT s.sname, c.cname, sc.grade
FROM student s
JOIN sc ON s.sno = sc.sno
JOIN course c ON sc.cno = c.cno
WHERE s.sname = '程熙';
GO

-- 6. 查询没有参加任何一门考试的学生姓名
SELECT s.sname
FROM student s
WHERE NOT EXISTS (
    SELECT 1
    FROM sc
    WHERE sc.sno = s.sno
);
GO

-- 7. 查询程熙高于其选修课程平均分的那些课程的课程名和成绩
SELECT c.cname, sc.grade
FROM course c
JOIN sc ON c.cno = sc.cno
JOIN student s ON s.sno = sc.sno
WHERE s.sname = '程熙'
AND sc.grade > (
    SELECT AVG(grade)
    FROM sc
    WHERE cno = c.cno
);
GO
	
-- 8. 查询每个学生的成绩在分以上的各有多少门，显示姓名和门数
SELECT s.sname, COUNT(sc.cno) AS count_above_80
FROM student s
JOIN sc ON s.sno = sc.sno
WHERE sc.grade > 80
GROUP BY s.sname;
GO

-- 9. 查询平均成绩比程熙平均分高的学生的学生名和平均成绩
WITH ChengXiAvg AS (
    SELECT AVG(sc.grade) AS avg_grade
    FROM sc
    JOIN student s ON sc.sno = s.sno
    WHERE s.sname = '程熙'
)
SELECT s.sname, AVG(sc.grade) AS avg_grade
FROM student s
JOIN sc ON s.sno = sc.sno
GROUP BY s.sname
HAVING AVG(sc.grade) > (SELECT avg_grade FROM ChengXiAvg);
GO
