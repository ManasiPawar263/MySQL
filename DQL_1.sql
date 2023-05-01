# DQL queries on database company_db

# select query

# select all the columns in the table employee
select * from employee;

# get all the details of deapartment
select * from department;

# select fname and salary in employee
select fname, salary from employee;

# select dname, dnumber in department table
select dname, dnumber from department;

# select distinct i.e, unique values from column dno from employee table(we can add multiple column name also)
select distinct dno
from employee;

# get distinct relationship values from dependent table
select distinct relationship
from dependent;


# aliases

# Retrive first name and last name of all employees using alias
-- 1.
select fname as first_name
from employee;

-- 2. we can use it without using as
select fname  first_name
from employee;


# WHERE

# Retrive the details of all female employee
select *
from employee
where sex = 'f';

# Retrive the table with project location as houston
select *
from project
where plocation = 'houston';

# Retrive details of all employee who draw a salary which is at least 30000
select * from employee
where salary >= 30000;


# AND operator

# Retrive deatails of all male employee who draw a salary which is at least 30000 using AND operator
select * from employee
where sex = 'm' and salary >= 30000;

# get fname of all female employee which belongs to department 5
select * from employee
where sex = 'f' and dno = 5;


# OR

# Retrive details of projects that are based out houston or stafford
select * from project
where plocation = 'houston' or 'stafford';

# get details of all employee belongs to dno 5, 4
select * from employee
where dno = 5 or 4;

# NOT(it will also denoted by symbol '!=', '<>')

# Retrive the department location which is not houston
select * from project
where plocation != 'houston';


# between

# get fname and salary of getting between 20k to 30k 
select * from employee
where salary between 20000 and 30000;

# get details of employee whose pno = 10 and working hours between 10 to 30 hours - works-on
select * from works_on
where pno = 10 and hours between 10 and 30;


# Like 

# Display employee whoes name ends with a 
select fname from employee
where fname like '%a';

# Display employee name which has second letter e
select fname from employee
where fname like '_e%';

# Display employee name which has third letter m
select fname from employee
where fname like '__m%';

# Dispaly any name which has ci in it
select fname from employee
where fname like '%ci%';

# get project names, dnum which has got ctx and cty in their project name
select pname, dnum from project
where pname like '%ctx%' or pname like '%cty%';


# IN operator

# dno in 4 and 5
select * from employee
where dno in (4,5);

# get details of works on table who works for pno 1,2,3,30,10
select * from works_on
where pno in (1,2,3,30,10);

# get all the details of the project where project name is ProductX and ProductY also Newbenefits
select * from project
where pname in ('ProductX', 'ProductY', 'Newbenefits');


# NOT IN operator 

# NOT IN  dep location not in houston
select * from dept_locations
where dlocation not in ('houston');


# Null operator
# is null

# super_ssn is null
select * from employee
where super_ssn is null;

# is not null

# super_ssn is not null
select * from employee
where super_ssn is not null;

# get details of employee who got working hours as is null - works_on
select * from works_on
where hours is null;


# Order by (by default it takes ascending, if we want descending order put desc)

# Display the employees sorted by their salary in ascending order take fname and salary 
select fname, salary
from employee
order by salary;

# Display the employees sorted by their salary in descending order take fname and salary
select fname, salary from employee
order by salary desc;

# Interview question (important)

# Display top 3 salary making people as output using order by method
select * from employee
order by salary desc
limit 3;

# Display top 3 salary making people under dno 5
select * from employee
where dno = 5
order by salary desc
limit 3;

# get details of a person who is getting third highest salary
select * from employee
order by salary desc
limit 2,1;      # here 2 gives how many rows you want to skip & 1 gives how many rows you want to keep


# aggregation function

# display the female employee with min and max salary
select min(salary), max(salary)
from employee
where sex = 'f';


# Count 

# Count the number of female employee
select count(*), count(ssn), count(distinct ssn) as unq from employee
where sex = 'f';

# get count of total supervisors and unique supervisors
select count(*), count(super_ssn), count(distinct super_ssn) as unq from employee;

# get number of employees belongs to project no 1 - works on table
select count(essn) as total from works_on
where pno = 1;

# get the total number projects in works on table out of which how many of them are unique
select count(pno), count(distinct pno) as unq from works_on;


# Sum

# sum the overall salary of male employee who belongs to dno 5
select sum(salary) as total, count(ssn) as num from employee
where sex = 'm' and  dno = 5;

# get total working hours employee with id = essn 999887777 is investing on project 10
select sum(hours) as total from works_on
where essn = 999887777 and pno = 10;


# Average

# Display the average of project hours also use round function
select round(avg(hours), 2) as average    # here 2 indicates how many values we want after a decimal point
from works_on;


# CONCAT

# display the ssn and fully concatenated name of all employees
-- use concat function as in CONCAT(fname, ' ', minit, ' ', lname)
select concat(fname, ' ', minit, ' ', lname) as fullname
from employee;

# date function

# year(), month(), and day()
select bdate, year(bdate) as year_bdate,
month(bdate) as month_bdate,
day(bdate) as day_bdate from employee;


# group by

# Display the number of employee in each department(dno)
select dno, count(ssn) as total
from employee
group by dno
order by total;   # it will show in order wise like in ascending order if we want in descending we'll just put desc

# get total working hours per each of the employee present in works on table
select essn, sum(hours) as total
from works_on
group by essn
order by total;

# get total working hours of top 3 employee present in works on table 
select essn, sum(hours) as total
from works_on
group by essn
order by total desc
limit 3;

# get total salary per each gender and order it in increasing order
select sex, sum(salary) as total 
from employee
group by sex
order by total;

# get year of bday wise total salary
select bdate, sum(salary) as total
from employee
group by bdate;

# Display the average salary of employee (department and gender wise)
select dno, sex, avg(salary)
from employee
group by dno, sex;

# Display the number of male employee in each department
select dno, sex, count(ssn) as num
from employee
where sex = 'm'
group by dno;

# display the number of projects per each location
select plocation, count(pname) as project
from project
group by plocation;

# get total working hours of employee based on employee and pno
select essn, pno, sum(hours)
from works_on
group by essn, pno;

# get number of dependents per each employee in the company
select essn, count(dependent_name) as num
from dependent
group by essn;

# HAVING clause applied on aggregated values

# Display the dno of those departments that has 4 employee
select count(ssn) as num, dno
from employee
group by dno
having num = 4;

# Display the sum of salary in each department that has salary as 55000
select sum(salary) as total, dno
from employee
group by dno
having total = 55000;

# get total working hours per each employee and filter those employee whose total hours is greater than 25 hours
select essn, sum(hours) as total
from works_on
group by essn
having total > 25;

# Interview question -> display the duplicates records

# Display duplicates ids(super_ssn) in employee table based on id
select super_ssn, count(super_ssn) as id
from employee
group by super_ssn
having id > 1;


# Joins

# Inner join the two tables employee and denpendent 
select * from employee
inner join dependent     # by default the join will be inner, if we dont write inner still it will work
on employee.ssn = dependent.essn;


# Left join

# Left join the two tables employee and denpendent 
select * from employee
left join dependent     
on employee.ssn = dependent.essn;

# Right join

# Right join the two tables employee and denpendent 
select * from employee
right join dependent     
on employee.ssn = dependent.essn;

# small variation to the above query to write it optimistically
select * from employee as e
right join dependent as d         # we just do aliase here to make it more easy
on e.ssn = d.essn;

# Creating 1 temporary table for analysis
drop table if exists temp_1;
create table temp_1 as
select d.*, e.salary
from dependent as d 
join employee as e 
on d.essn = e.ssn
join department as dep
on e.dno = dep.dnumber;

# get names and salary of employees who belongs to research department
select e.fname, e.salary, e.dno, d.dname
from employee as e
join department as d
on e.dno = d.dnumber
where dname = 'research';

# get total salary and total working hours of all the employees
select e.ssn, sum(salary) salary, sum(hours) hours
from employee as e
join works_on as w
on e.ssn = w.essn
group by e.ssn;

# get first name of employees whoes total working hours is greater than 35 hours
select e.fname, sum(w.hours) as hours
from employee as e
join works_on as w
on e.ssn = w.essn
group by e.ssn
having hours > 35;

# get name of employee and dependents also filter only male dependents
select e.fname, e.ssn, d.dependent_name
from employee as e
join dependent as d
on e.ssn = d.essn
where d.sex = 'm';

# get project names which has working hours between 10 to 20
select p.pname, p.pnumber, w.hours
from project as p
join works_on as w
on p.pnumber = w.pno
where hours between 10 and 20;


# Union

select fname, ssn, sex from employee
where sex = 'f'
union
select fname, ssn, sex from employee
where sex = 'm';


# Sub queries

# Display the fname and salary of employee whose salary is more than the average salary of all the employees
# using normal method
select round(avg(salary)) from employee;
-- 35125
select fname, salary from employee
where salary > 35125;

# using sub query
select fname, salary
from employee
where salary > (select round(avg(salary)) from employee); # the query in paranthesis is inner query and the 
														  -- whole query is outer query
													
# Display the fname of employee working in research department use sub query
select fname, dno 
from employee
where dno in (select dnumber from department where dname = 'research');

# Important interview question

# get count of employee who are in employee table are also in dependent table
select count(ssn) as count 
from employee
where ssn in (select essn from dependent); 

# get fname of those employee whose pno = 10,1,3 and their working hours is greater than 30
select fname from employee
where ssn in (select essn from works_on where hours > 20 and pno in (10,1,3));


# Window function

# Ranking function in sql
# The RANK() function is a window function that assigns a rank to each row.

# Rank each employee based on salary
select
     fname,
     sex,
     salary,
     RANK () over (
         order by salary desc
	 ) rank_1
from 
     employee;

# Rank working hours of each employee in works on table
select
	 essn,
     hours,
     RANK () over (
           order by hours desc
	 ) working_hours
from
    works_on;
    
# Partitioning rank by dno
select
      fname,
      sex,
      salary,
      dno,
      rank () over (
      partition by dno 
      order by salary desc
      ) price_rank_bydno
from
	employee;
    
select
      fname,
      sex,
      salary,
      dno,
      dense_rank () over (
      partition by dno 
      order by salary desc
      ) price_rank_bydno
from
	employee;
    
# Rank working hours of each employee in works on table and partition by pno
select
      essn,
      hours,
      dense_rank () over (
      partition by pno 
      order by hours desc
      ) rank_bypno
from
	works_on;
    
    
# Row number
select
      fname,
      sex,
      salary,
      dno,
      rank () over (
         order by salary desc
      ) rank_1,
      row_number () over (
         order by salary desc
      ) row_num
from
	employee;
    
# Lead

select 
	fname,
    ssn,
    salary,
    lead(salary, 1) over (       # here 1 is indicating leading salary by 1 value
	     order by salary desc
	) next_person_salary
from
    employee;
 
 # Lag
 
select 
	fname,
    ssn,
    salary,
    lag(salary, 1) over (       # here 1 is indicating lagging salary by 1 value
	     order by salary desc
	) prev_person_salary
from
    employee;

    
# Views in SQL

CREATE VIEW first_view as
select 
     fname,
     sex,
     salary,
     rank () over (
       order by salary desc
	 ) rank1,
     row_number () over (
       order by salary desc
	 ) row_num
from 
    employee;
    
# Replacing the present view 
CREATE OR REPLACE VIEW first_view AS
select *
from employee
where fname = 'James';

# Dropping the view
drop view first_view;

