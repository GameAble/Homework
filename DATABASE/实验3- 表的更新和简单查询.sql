SELECT [sno]
      ,[sname]
      ,[sdept]
  FROM [student]
GO

SELECT sno, sname,sdept
FROM student 
WHERE sname LIKE '李%'
ORDER BY sno ASC 
LIMIT 2

SELECT *
FROM student 
WHERE sno LIKE '%1914%' and (sage between 19 and 21) and ssex='女';

SELECT * FROM student
WHERE sdept IN ('互联网学院', '电子工程学院') AND sage < 20;

SELECT count (*) FROM student
WHERE sdept IN ('互联网学院')

SELECT count (distinct sdept) FROM student

select sdept ,count(*) as '数量' from student group by sdept
select sdept ,count(*) as '数量' from student WHERE sdept NOT LIKE '互联网学院' group by sdept 

SELECT AVG(grade) AS '平均成绩'
FROM sc
WHERE Cno = '02';

select Cno ,count(*) as '数量' from sc group by Cno

SELECT Cno, AVG(grade) AS '平均成绩'
FROM sc
group by Cno

SELECT Sno, AVG(grade) AS '平均成绩'
FROM sc
group by Sno

SELECT Sno, AVG(grade) AS '平均成绩'
FROM sc
group by Sno HAVING AVG(grade)>80 

SELECT Sno,COUNT(Cno) AS "课程数" ,Avg(grade) FROM sc
GROUP BY Sno
HAVING COUNT(Cno) >1

SELECT Sname,2024-Sage from student
Where ssex = '男'
