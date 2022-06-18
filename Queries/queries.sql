 SELECT first_name, last_name

FROM employees 

WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';
--
SELECT first_name, last_name

FROM employees 

WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

--Retirement elegibility

SELECT first_name, last_name

FROM employees 

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--
SELECT COUNT (first_name)

FROM employees 

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--

SELECT first_name, last_name

INTO retirement_info

FROM employees 

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--

SELECT * FROM retirement_info;

--

--Create new table for retiring employees

SELECT e.emp_no, 
e.first_name,
e.last_name,
e.gender,
s.salary,
de.to_date

INTO emp_info

FROM employees as e

INNER JOIN salaries as s

ON (e.emp_no = s.emp_no)

INNER JOIN dept_emp as de

ON (e.emp_no = de.emp_no)

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31') 

AND (de.to_date = '9999-01-01');

--Check the table

SELECT *FROM  retirement_info;

--Joining departments and dept_managar tables

SELECT departments.dept_name,
		dept_manager.emp_no,
		dept_manager.from_date,
		dept_manager.to_date

FROM departments

INNER JOIN dept_manager

ON departments.dept_no=dept_manager.dept_no;

--Joining retirement_info and dept_emp tables

SELECT ri.emp_no, 
		ri.first_name,
		ri.last_name,
		de.to_date

INTO current_emp

FROM retirement_info AS ri

LEFT JOIN dept_emp AS de

ON ri.emp_no=de.emp_no

WHERE de.to_date=('9999-01-01');

-- Check current_emp table

SELECT * FROM current_emp;

-- Employee count by department number

SELECT COUNT (ce.emp_no), de.dept_no, d.dept_name

INTO retirement_emp_dept

FROM current_emp AS ce

LEFT JOIN dept_emp as de

ON ce.emp_no = de.emp_no

JOIN departments AS d

ON (de.dept_no = d.dept_no)

GROUP BY de.dept_no

ORDER BY de.dept_no;

-- Retirement employees by department table

SELECT * FROM retirement_emp_dept;

--

SELECT * FROM salaries

ORDER BY to_date DESC;
