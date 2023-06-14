create database universities_db;
use universities_db;

CREATE TABLE countries (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE cities (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE,
    population INT,
    country_id INT,
    CONSTRAINT fk_cities_countries FOREIGN KEY (country_id)
        REFERENCES countries (id)
);

CREATE TABLE universities (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL UNIQUE,
    address VARCHAR(80) NOT NULL UNIQUE,
    tuition_fee DECIMAL(19 , 2 ) NOT NULL,
    number_of_staff INT,
    city_id INT,
    CONSTRAINT fk_universities_cities FOREIGN KEY (city_id)
        REFERENCES cities (id)
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    age INT,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    is_graduated TINYINT(1),
    city_id INT,
    CONSTRAINT fk_students_cities FOREIGN KEY (city_id)
        REFERENCES cities (id)
);


CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE,
    duration_hours DECIMAL(19 , 2 ),
    start_date DATE,
    teacher_name VARCHAR(60) NOT NULL UNIQUE,
    description TEXT,
    university_id INT,
    CONSTRAINT fk_courses_universities FOREIGN KEY (university_id)
        REFERENCES universities (id)
);


CREATE TABLE students_courses (
    grade DECIMAL(19 , 2 ) NOT NULL,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    CONSTRAINT fk_students_courses_students FOREIGN KEY (student_id)
        REFERENCES students (id),
    CONSTRAINT fk_students_courses_courses FOREIGN KEY (course_id)
        REFERENCES courses (id)
);

-- 2

insert into courses(name,duration_hours,start_date,teacher_name,description,university_id)
(select concat(teacher_name,' ','course'),
length(name)/10,date_add(start_date,interval 5 day),
reverse(teacher_name),
concat('Course',' ',teacher_name,reverse(description)),
day(start_date)
from courses
where id<6);

SELECT 
    *
FROM
    courses;

-- 3

UPDATE universities 
SET 
    tuition_fee = tuition_fee + 300
WHERE
    id BETWEEN 5 AND 12;


--  4

DELETE FROM universities 
WHERE
    number_of_staff IS NULL;


-- 5
SELECT 
    *
FROM
    cities
ORDER BY population DESC;


-- 6

SELECT 
    first_name, last_name, age, phone, email
FROM
    students
WHERE
    age > 20
ORDER BY first_name DESC , email , id
LIMIT 10;

-- 7

SELECT 
    CONCAT(first_name, ' ', last_name) AS 'full_name',
    SUBSTRING(email, 2, 10) AS 'username',
    REVERSE(phone) AS 'password'
FROM
    students AS s
WHERE
    (SELECT 
            COUNT(*)
        FROM
            students_courses
        WHERE
            s.id = student_id) = 0
ORDER BY `password` DESC;


-- 8


SELECT 
    COUNT(*) AS 'students_count', u.name
FROM
    universities AS u
        JOIN
    courses AS c ON u.id = c.university_id
        JOIN
    students_courses AS sc ON sc.course_id = c.id
GROUP BY u.name
HAVING `students_count` > 7
ORDER BY `students_count` DESC , u.name DESC;


-- 9

SELECT 
    u.name AS 'university_name',
    c.name AS 'city_name',
    u.address AS 'address',
    (SELECT 
            CASE
                    WHEN u.tuition_fee < 800 THEN 'cheap'
                    WHEN u.tuition_fee < 1200 THEN 'normal'
                    WHEN u.tuition_fee < 2500 THEN 'high'
                    WHEN u.tuition_fee > 2499 THEN 'expensive'
                END
        ) AS 'price_rank',
    u.tuition_fee AS 'tuition_fee'
FROM
    universities AS u
        JOIN
    cities AS c ON u.city_id = c.id
ORDER BY tuition_fee;


-- 10

delimiter //
create function udf_average_alumni_grade_by_course_name(course_name VARCHAR(60))
returns decimal(10,2)
deterministic
begin 
return(
select avg(sc.grade) as 'average_alumni_grade'
from courses as c
join students_courses as sc on sc.course_id = c.id
join students as s on s.id = sc.student_id

where c.name=course_name  and is_graduated=1);

end//



select c.name,avg(sc.grade) 
from courses as c
join students_courses as sc on sc.course_id = c.id
join students as s on s.id = sc.student_id

where c.name= 'Quantum Physics' and is_graduated=1;

-- 11


delimiter//
create procedure udp_graduate_all_students_by_year (year_started INT)
begin 

update students as s
join students_courses as sc on sc.student_id = s.id
join courses as c on c.id = sc.course_id

set s.is_graduated=1
where year(c.start_date) = year_started;

end//
delimitier ;
CALL udp_graduate_all_students_by_year(2017); 


delimiter ;
select * 
from students as s
join students_courses as sc on sc.student_id = s.id

join courses as c on c.id = sc.course_id
where s.is_graduated=0 and year(c.start_date) =2017;


SELECT EXTRACT(DAY FROM '2000-02-03');

SELECT DAY('2000-02-03')
;

SELECT SUBSTRING('SoftUni',1,4);
