-- Deliverable 1

--Retrieve the emp_no, first_name, and last_name columns from the Employees table.
select emp_no, first_name, last_name
FROM employees

--Retrieve the title, from_date, and to_date columns from the Titles table.
select title, from_date, to_date
FROM titles

--Create a new table using the INTO clause.
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no=t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

select * from retirement_titles


--  remove duplicate rows

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- retrieve the number of employees by their most recent job titles 
-- who are about to retire

SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;


-- Deliverable 2

-- create a Mentorship Eligibility table that holds 
-- the employees who are eligible to participate in a mentorship program

SELECT emp_no, first_name, last_name, birth_date
FROM employees

SELECT from_date, to_date
FROM dept_emp

SELECT title FROM titles;

SELECT DISTINCT ON (e.emp_no) 
	e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
	t.from_date,
	t.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no=t.emp_no
WHERE t.to_date = '9999-01-01'
AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;