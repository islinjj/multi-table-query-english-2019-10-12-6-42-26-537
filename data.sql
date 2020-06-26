# 1.Query the existence of 1 course 查询同时存在1课程和2课程的情况
select s.name,sc.courseId,sc.score,s.id from student_course sc,student s 
where sc.courseId in(select courseId from student_course where sc.courseId = 1 or sc.courseId = 2)
and sc.studentId = s.id

# 2.Query the presence of both 1 and 2 courses
select s.name,sc.courseId,sc.score,s.id from student_course sc,student s 
where sc.courseId in(select courseId from student_course where sc.courseId = 1 or sc.courseId = 2)
and sc.studentId = s.id;

# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
select sc.studentId,s.name,round(avg(sc.score),2) averageScore from student_course sc left join student s
on sc.studentId = s.id
group by sc.studentId,s.name having round(avg(sc.score),2)>=60;

# 4.Query the SQL statement of student information that does not have grades in the student_course table
select * from student where id not in(select studentId from student_course);

# 5.Query all SQL with grades
select s.id,s.name,s.age,s.sex from student_course sc left join student s on sc.studentId = s.id
group by sc.studentId,s.id,s.name,s.age,s.sex;

# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
select s.id,s.name,s.age,s.sex,stu.c1,stu.c2
from (select t1.studentId sId,t1.courseId c1,t2.courseId c2 from
	(select s1.studentId,s1.courseId from student_course s1 where s1.courseId=1) t1,
	(select s2.studentId,s2.courseId from student_course s2 where s2.courseId=2) t2
    where t1.studentId = t2.studentId
    )stu,student s
where stu.sId = s.id;

# 7.Retrieve 1 student score with less than 60 scores in descending order
select s.name,s.age,s.id,s.sex,sc.score,sc.courseId
from student_course sc left join student s on sc.studentId = s.id
where sc.courseId = 1 and sc.score<60
order by sc.score desc;

# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
select c.id,c.name,round(avg(sc.score),2) avgScore from student_course sc left join course c on sc.courseId = c.id
group by c.id,c.name 
order by round(avg(sc.score),2) desc,c.id asc;

# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
select s.name,sc.score from student s,student_course sc,course c
where c.name='Math' and c.id = sc.courseId and s.id = sc.studentId and sc.score < 60;
