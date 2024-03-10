create database AssessmentDB;

use AssessmentDB;

CREATE TABLE runners(
	Id int,
    name varchar(100)
    );
    
insert into runners values(1,"John Doe");
insert into runners values(2,"Jane Doe");
insert into runners values(3,"Alice Jones");
insert into runners values(4,"Bobby Louis");
insert into runners values(5,"Lisa Romero");

SELECT * FROM runners;

CREATE TABLE races(
	Id int,
    event varchar(100),
    winner_id int
    );
    
insert into races values(1,"100 meter dash",2);
insert into races values(2,"500 meter dash",3);
insert into races values(3,"cross-country",2);
insert into races values(2,"triathalon",NULL);

SELECT * FROM races;

-- Answer 1 
SELECT * FROM runners WHERE id NOT IN (SELECT winner_id FROM races);
-- Answer 1 alternative
SELECT runners.* 
FROM runners 
LEFT JOIN races ON runners.id = races.winner_id 
WHERE races.winner_id IS NULL;

-- Question 2
create table test_a(id numeric);

create table test_b(id numeric);

insert into test_a(id) values
	(10),
    (20),
    (30),
    (40),
    (50);
    
insert into test_b(id) values
	(10),
    (30),
    (50);
-- Que:- Write a query to fetch values in table test_a that are and not in test_b without using the NOT keyword.

-- Answer 2:-
SELECT test_a.* 
FROM test_a 
LEFT JOIN test_b ON test_a.id = test_b.id 
WHERE test_b.id IS NULL;

-- Question 3
-- Write a query to to get the list of users who took the a training lesson more than once in the same day, grouped by user and training lesson, each ordered from the most recent lesson date to oldest date.

-- Answer 3
SELECT users.username, training_details.training_id, training_details.training_date
FROM (
    SELECT user_id, training_id, training_date, COUNT(*) as training_count
    FROM training_details
    GROUP BY user_id, training_id, DATE(training_date)
    HAVING training_count > 1
) as subquery
JOIN users ON users.user_id = subquery.user_id
ORDER BY training_date DESC;

-- Question 4 
create table employee(emp_id int,
	emp_name varchar(100),
    salary int,
    manager_id int);

insert into employee values(10,"Anil",50000,18);
insert into employee values(11,"Vikas",75000,16);
insert into employee values(12,"Nisha",40000,18);
insert into employee values(13,"Nidhi",60000,17);
insert into employee values(14,"Priya",80000,18);
insert into employee values(15,"Mohit",45000,18);
insert into employee values(16,"Rajesh",90000,NULL);
insert into employee values(17,"Raman",55000,16);
insert into employee values(18,"Santosh",65000,17);


-- Answer 4
SELECT
    e.manager_id AS Manager_Id,
    m.emp_name AS Manager,
    AVG(e.salary) AS Average_Salary_Under_Man
FROM
    employee e
JOIN
    employee m ON e.manager_id = m.emp_id
GROUP BY
    e.manager_id, m.emp_name;
