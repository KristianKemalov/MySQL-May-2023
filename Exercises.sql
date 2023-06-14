CREATE DATABASE newbase;
use newbase;


-- 1 
CREATE TABLE people (
    person_id INT UNIQUE NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10 , 2 ) DEFAULT 0,
    passport_id INT UNIQUE
);


CREATE TABLE passports (
    passport_id INT AUTO_INCREMENT PRIMARY KEY,
    passport_number VARCHAR(8) UNIQUE
); 

alter table people
add constraint pk_people
primary key(person_id),
add constraint fk_people_passports
foreign key (passport_id)
references passports(passport_id);

insert into passports
values
(101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2');


insert into people
values
(1,'Roberto',43300.00,102),
(2,'Tom',56100.00,103),
(3,'Yana',60200.00,101);


-- 2


CREATE TABLE manufacturers (
    manufacturer_id INT UNIQUE NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    established_on DATE
);


CREATE TABLE models (
    model_id INT UNIQUE AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL,
    manufacturer_id INT NOT NULL
);


alter table manufacturers
add constraint pk_manufacturers 
primary key (manufacturer_id);

alter table models
add constraint pk_models
primary key (model_id),
add constraint fk_modesl_manufacturers
foreign key (manufacturer_id)
references manufacturers(manufacturer_id);


insert into manufacturers
values (1,'BMW','1916-03-01'),
	   (2,'Tesla','2003-01-01'),
	   (3,'Lada','1966-05-01');
       
       
insert into models
values
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3);


-- 3

CREATE TABLE students (
    student_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE exams (
    exam_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE students_exams (
    student_id INT,
    exam_id INT,
    CONSTRAINT pk_students_exams PRIMARY KEY (exam_id , student_id),
    CONSTRAINT fk_students_exams FOREIGN KEY (exam_id)
        REFERENCES exams (exam_id),
    CONSTRAINT fk_exams_students FOREIGN KEY (student_id)
        REFERENCES students (student_id)
);


insert into students
values (1,'Mila'),
	   (2,'Toni'),
	   (3,'Ron');

insert into exams
values (101,'Spring MVC'),
	   (102,'Neo4j'),
	   (103,'Oracle 11g');
       

insert into students_exams
values (1,101),
	   (1,102),
	   (2,101),
	   (3,103),
	   (2,102),
	   (2,103);
       
-- 4
CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    manager_id INT
);

alter table teachers
add constraint fk_teachers_manager_id
foreign key(manager_id)
references teachers(manager_id);



-- 5

create database online_store;
use online_store;


CREATE TABLE cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);


CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    birthday DATE,
    city_id INT,
    CONSTRAINT fk_customers_cities FOREIGN KEY (city_id)
        REFERENCES cities (city_id)
);
 
 
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);
 
 
CREATE TABLE order_items (
    order_id INT,
    item_id INT,
    CONSTRAINT pk_order_items PRIMARY KEY (order_id , item_id)
);
 
CREATE TABLE item_types (
    item_type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

 
CREATE TABLE items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    item_type_id INT,
    CONSTRAINT fk_items_order_items FOREIGN KEY (item_type_id)
        REFERENCES item_types (item_type_id)
);
 

 
 ALTER TABLE order_items
 ADD CONSTRAINT fk_order_items_items
FOREIGN KEY (item_id)
 REFERENCES items(item_id);
 
 ALTER TABLE order_items
 
 ADD CONSTRAINT fk_order_items_orders
 FOREIGN KEY (order_id)
 REFERENCES orders(order_id);
 


-- 6

create database university;
use university;


CREATE TABLE subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(50)
);

CREATE TABLE majors (
    major_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_number VARCHAR(12),
    student_name VARCHAR(50),
    major_id INT,
    CONSTRAINT fk_students_majors FOREIGN KEY (major_id)
        REFERENCES majors (major_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_date DATE,
    payment_amount DECIMAL(8 , 2 ),
    student_id INT,
    CONSTRAINT fk_payments_students FOREIGN KEY (student_id)
        REFERENCES students (student_id)
);


CREATE TABLE agenda (
    student_id INT,
    subject_id INT,
    CONSTRAINT pk_agenda PRIMARY KEY (student_id , subject_id),
    CONSTRAINT fk_agenda_subjects FOREIGN KEY (subject_id)
        REFERENCES subjects (subject_id),
    CONSTRAINT fk_agenda_students FOREIGN KEY (student_id)
        REFERENCES students (student_id)
);



-- 9
SELECT 
    mountains.mountain_range,
    peaks.peak_name,
    peaks.elevation AS 'peak_elevation'
FROM
    mountains,
    peaks
WHERE
    mountain_range = 'Rila'
        AND peaks.mountain_id = 17
ORDER BY `peak_elevation` DESC;


