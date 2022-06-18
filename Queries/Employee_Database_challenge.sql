--#DELIVERABLE 1
-- ##1.Write a query and execute it to create a retirement_titles table for employees who are born between
--January 1, 1952 and December 31, 1955.
SELECT e.emp_no, e.first_name, e.last_name, t.titles, t.from_date, t.to_date

INTO retirement_titles

FROM employees AS e

INNER JOIN titles AS t

ON (e.emp_no = t.emp_no)

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');

--##2. Write and execute a query to create a unique_titles table that contains the employee number, 
--first and last name, and most recent title.
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles

FROM retirement_titles

WHERE (to_date='9999-01-01')

ORDER BY emp_no, to_date DESC;


--##3. Write and execute another query to create a retiring_titles table that contains the number of titles
--filled by employees who are retiring.
SELECT title, COUNT (title) AS "title count"

INTO retiring_titles

FROM unique_titles

GROUP BY title

ORDER BY "title count" DESC;


--#DELIVERABLE 2
--Write and execute a query to create a mentorship_eligibility table for current employees who were born 
--between January 1, 1965 and December 31,1965.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title

INTO mentorship_eligibility

FROM employees AS e

JOIN dept_emp AS de

ON (e.emp_no = de.emp_no)

JOIN titles AS t

ON (e.emp_no = t.emp_no)

WHERE (birth_date BETWEEN 'January 1, 1965 ' AND 'December 31, 1965')

AND (de.to_date = '9999-01-01')

ORDER BY e.emp_no


--Join retirement_emp_dept with departments table to see the department names along with their number 
--and the number of employees retiring from each department.
SELECT COUNT (ce.emp_no), de.dept_no, d.dept_name

INTO retirement_dept

FROM current_emp AS ce

LEFT JOIN dept_emp as de

ON ce.emp_no = de.emp_no

JOIN departments AS d

ON (de.dept_no = d.dept_no)

GROUP BY de.dept_no

ORDER BY de.dept_no;

--Count the number of total employees eligible for the mentorship program
SELECT COUNT (emp_no)

FROM mentorship_eligibility;

--Mentors avalaible by title
SELECT title, COUNT (title)

FROM mentorship_eligibility

GROUP BY title;


--Total retiring employees
SELECT SUM (count)

FROM retiring_titles;