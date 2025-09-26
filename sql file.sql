create database regexsql;
use regexsql;

-- create departments
create table departments (
 dep_id int primary key auto_increment,
 dept_name varchar(100) not null 
 );
 
 -- create employees
  create table employees(
  emp_id int primary key auto_increment,
  first_name varchar(50),
  last_name varchar(50),
  hire_date date,
  salary decimal(12,2),
  dept_id int,
  foreign key (dept_id) references departments  (dep_id) 
   on update cascade
   on delete set null
   );
--  UPDATE CASCADE -- If the primary key value in the parent table changes, 
-- the foreign key values in the child table will be updated automatically to match.

-- DELETE SET NULL -- If the parent row is deleted, 
-- the foreign key column in the child table is set to NULL (instead of being deleted or causing an error).
  
  -- create projects
   create table projects(
     project_id int primary key auto_increment,
     project_name varchar (100),
     start_date date,
     end_date date,
     budget decimal(14,2)
     );
     
     -- assignment table (many -to- many)
     create table employee_projects (
      emp_id     int not null,
      project_id int not null,
      assigned_on date default (current_date),
      primary key (emp_id,project_id),
      foreign key(emp_id) references  employees(emp_id)
        on update cascade
        on delete cascade,
	  foreign key(project_id) references projects(project_id)
        on update cascade
        on delete cascade
        );
        
        -- delete cascade -- complete row will be deleted
        
        -- sales table 
        create table sales (
         sale_id  int primary key auto_increment,
         emp_id    int,
         sale_date date,
         amount  decimal (12,2),
         foreign key (emp_id ) references employees(emp_id)
           on update cascade
           on delete set null 
           );
        
        -- departments 
        insert into
        departments ( dept_name)
        values
        ('research'),
        ('sales'),
        ('hr');
        
        select * from departments
        
        insert into 
        employees 
        (first_name,last_name,hire_date,salary,dept_id)
        values
        ('Alice', 'Wong', DATE '2023-01-15', 75000, 1),
        ('Bob', 'Patel', DATE '2022-06-01', 50000, 2),
       ('Charlie', 'Singh', DATE '2021-09-23', 120000, 1),
('Diana', 'Kumar', DATE '2024-03-10', 45000, 3),
('Ethan', 'Roy', DATE '2023-11-05', 68000, 2),
('Fiona', 'Desai', DATE '2020-12-30', 98000, 1),
('George', 'Mehta', DATE '2023-07-19', 39000, NULL),
('Hannah', 'Shah', DATE '2022-02-14', 54000, 3),
('Ian', 'Chopra', DATE '2023-05-30', 83000, 2),
('Jaya', 'Reddy', DATE '2021-08-08', 105000, NULL);
select * from  employees;
        
insert into 
projects (project_id, project_name,start_date,end_date,budget)   
values
(100, 'AI Platform', DATE '2024-01-01', DATE '2024-12-31', 500000),
(101, 'Sales Dashboard', DATE '2024-03-15', DATE '2024-09-30', 150000),
(102, 'HR Portal', DATE '2024-05-01', DATE '2024-11-30', 120000),
(103, 'Research Initiative', DATE '2023-10-01', DATE '2025-03-31', 800000),
(104, 'Legacy Migration', DATE '2024-07-01', DATE '2025-01-31', 200000);
select * from projects;    
        
 insert into 
 employee_projects (emp_id,project_id,assigned_on)
 values
 (1,100,date '2024-01-01'),
 (3,100,date '2024-01-10'),
 (6,103,date '2023-10-15'),
 (2,101,date '2024-03-20'),
 (5,101,date '2024-04-01'),
 (4,102,date '2024-05-05'),
 (8,102,date '2024-05-10'),
 (9,101,date '2024-06-01');
 select * from employee_projects
 
insert into 
sales (sale_id,emp_id,sale_date,amount)
values
(1000,2,date '2024-01-10',12000),
(1001,2,date '2024-02-05',8000),
(1002,5,date '2023-03-12',22000), 
(1003,9,date '2024-04-01',15000),
(1004,9,date '2024-05-10',17000),
(1005,1,date '2024-06-20',5000),
(1006,3,date '2024-07-01',30000),
(1007,3,date '2024-07-18',18000),
(1008,8,date '2024-02-28',9000),        
(1009,4,date '2024-08-01',11000);

select * from sales
select emp_id, first_name, last_name from employees ;
-- filter records with salary >50000
select emp_id, first_name, last_name from employees where salary >50000;

-- employees without a department
select emp_id, first_name, last_name from employees where dept_id is null;

-- list all employee hired after jan 1,2023.
select emp_id, first_name, last_name from employees where hire_date >2023-01-01

-- retrive employees with salary between 40000 AND 90000
select emp_id, first_name, last_name from employees where salary between 40000 and 90000;

-- sorting employees  based on hire date decending  order
select emp_id, first_name, last_name from employees order by hire_date desc;

--list all employees along with their department name
select e.emp_id, e.first_name, d.dept_name
from employees e
join departments d on e.dept_id=d.dep_id;

-- list of all employees including the ones without depatment
select e.emp_id,e.first_name,d.dept_name
from employees e
left join departments d on e.dept_id=d.dep_id;

-- find average salary per department
select avg(e.salary) as average_salary,d.dept_name
from employees 
select dept_name,avg(salary) from employees e
JOIN departments d ON e.dept_id = d.dep_id
GROUP BY d.dept_name;

-- list department where total salary exceed 200000
SELECT d.dep_id, d.dept_name, SUM(e.salary) AS total_salary
FROM departments d
JOIN employees e ON d.dep_id = e.dept_id
GROUP BY d.dep_id, d.dept_name
HAVING SUM(e.salary) > 200000

-- count how many projects each employee is assigned to ; display only those with 2+ projects

SELECT ep.emp_id, COUNT(ep.project_id) AS project_count
FROM employee_projects ep
GROUP BY ep.emp_id
HAVING COUNT(ep.project_id) >= 2;
select * from employee_projects

-- employees count by department with mionimum 2 employees
select d.dept_name,count(e.emp_id) as emp_count
from employees e
join departments d on e.dept_id = d.dep_id
group by d.dept_name
having count(e.emp_id) >=2;


-- join first name and last name  along with salary rounded
select e.emp_id as "employee id", concat(e.first_name ,' ',e.last_name )as full_name,
round(e.salary,0) as salary_rounded
from employees e;
 
-- add_months(date_expr,n) returns a new date that is n month after date_expr
-- date_add(date,interwal n month )-to add months
-- date_format(date,format) - to format the date

select emp_id,hire_date,
date_format(date_add(hire_date,interval 6 month),'%d-%b-%y') as six_month_later
from employees;
 
-- list all employees along with their department names ,including those unassigned
SELECT e.emp_id,
       CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       d.dept_name
FROM employees e
LEFT JOIN departments d
    ON e.dept_id = d.dep_id;

-- show employees and their assigned projects.
select 
   e.emp_id,
   concat(e.first_name, ' ' ,e.last_name) as employee_name,
   p.project_name
   from employees e
   join employee_projects ep
   on e.emp_id = ep.emp_id
   join projects p
    on ep.project_id = p.project_id
    order by e.emp_id;
    
    -- find projects no employees assigned 
    select 
    p.project_id,
    p.project_name
from projects p
left outer join employee_projects ep
  on p.project_id = ep.project_id
  where ep.emp_id is null;
  
-- employees in departments that have budgets projects
 select emp_id,first_name
 from employees
 where dept_id in (select distinct d.dep_id
 from departments d
 join employees e on d.dep_id = e.dept_id
 where salary <60000)
 
 select emp_id, first_name 
 from employees e_outer
 where exists (select 1 from employees e_inner
 where e_inner.dept_id = e_outer.dept_id)
 
 -- projects -- employee_projects
 
 select project_id, project_name 
from projects p
where exists (select 1 from employee_projects ep
where p.project_id = ep.project_id)

-- 2nd way  

 select project_id, project_name 
from projects p
where exists (select 1 from projects ep
where p.project_id = ep.project_id)

-- return  employees  who exist in employee but not in employree_project with and without project assignment
select e.first_name ,e.last_name 
from employees e
where not exists (select 1 from employee_projects ep
where e.emp_id =ep.emp_id)

or

select e.emp_id,e.first_name
from employees e

where e.emp_id not in (
  select ep.emp_id
  from employee_projects ep
);

or 

SELECT e.emp_id, e.first_name
FROM employees e
LEFT JOIN employee_projects ep 
    ON e.emp_id = ep.emp_id
WHERE ep.emp_id IS NULL;

--  salary rank within department of employees without dept name
select emp_id,first_name,last_name,dept_id,salary,
rank() over (partition by dept_id order by salary desc ) as salary_rank
from employees;

-- agar departmnet name chahaiye isse uper vali quey , add kr do 
-- salary rank within department with dept name

select e.emp_id,e.first_name,e.last_name,e.dept_id,
coalesce(d.dept_name,'unassigned') as dept_name,
e.salary,
rank()over (partition by dept_id order by salary desc) as salary_rank
from employees e
left join departments d on e.dept_id=d.dep_id 
order by d.dept_name,salary_rank

-- identify top 2 employees per department by salary.

select * from(select e.emp_id,e.first_name,e.last_name,e.dept_id,

e.salary,
rank()over (partition by dept_id order by salary desc) as salary_rank
from employees e)
t
where t.salary_rank <= 2
order by dept_id,salary_rank;

-- cumulative sales per employee over time

select sale_id,emp_id,sale_date,amount,
sum(amount)over ( partition by emp_id order by sale_date) as  total
from sales;


-- average
select sale_id,emp_id,sale_date,amount,
avg(amount)over ( partition by emp_id order by sale_date) as  total
from sales;

-- compute a 3-period of moving average of sales amount per employee
select sale_id,emp_id,sale_date,amount,
avg(amount)over ( partition by emp_id order by sale_date rows between 2 preceding 
and current row ) as  moving_avg
from sales;

-- add three new e,ployee to differnt department
insert into employees (first_name,last_name,hire_date,salary,dept_id)
values
('karan','verma',date '2024-9-15',72000,1), -- reserch
('leela','iyer',date '2024-10-10',55000,2), -- sales
('mohit','gupta',date '2024-11-05',46000,3); -- hr

-- give a 5% raise to employees hired before a given date
update employees 
set salary = salary*1.05
where hire_date < '2023-01-10';
SET SQL_SAFE_UPDATES = 0;

-- updates a project 104 if it exists or insert otherwise

insert into projects (project_id,project_name,start_date,end_date,budget)
values (104,'legacy migaration ',date '2024-07-01', date '2025-01-31',25000) as new
on duplicate key update
project_name=new.project_name,
start_date=new.start_date,
end_date=new.end_date,
budget=new.budget;