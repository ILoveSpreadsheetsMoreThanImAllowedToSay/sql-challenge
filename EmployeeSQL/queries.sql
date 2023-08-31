-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
JOIN salaries as s ON e.emp_no = s.emp_no;
SELECT * FROM employees;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT DISTINCT e.last_name, e.first_name, e.hire_date
FROM employees as e
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';
--Assistance for BETWEEN from https://www.w3schools.com/sql/sql_dates.asp

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dm.dept_no, dm.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_manager as dm
INNER JOIN employees as e ON dm.emp_no = e.emp_no
INNER JOIN departments as d ON dm.dept_no = d.dept_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

-- Note that the raw csv table of employees is 300,025 in length, while the following join produces 331,603 records even when using INNER JOIN.
-- This is due to the dataset not being able to be cleaned to reflect current position status resulting in ambiguous results.
-- For example, employee 10010, Duangkaew Piveteau exists in both departments d004 (Production) and d006 (Quality Management), with the same hire date of 24-AUG-1989.
-- There is no rectifier present across all tables to reflect a "current position" flag if these data are to all be kept for historical purposes.
-- That said, here is the code...

SELECT de.dept_no,  de.emp_no, e.last_name, e.first_name, d.dept_name, e.hire_date
FROM employees as e 
INNER JOIN dept_emp as de ON e.emp_no = de.emp_no
INNER JOIN departments as d ON de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT e.first_name, e.last_name, e.sex
FROM employees as e
WHERE 
e.first_name = 'Hercules'
	AND
e.last_name LIKE 'B%'; --Love that wildcard character

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM employees as e
INNER JOIN dept_emp as de ON e.emp_no = de.emp_no
INNER JOIN departments as d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales'; --Could have used d007 on the intermediate table, but this removes all ambiguity and is resilient to table modifications, somewhat

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
INNER JOIN dept_emp as de ON e.emp_no = de.emp_no
INNER JOIN departments as d ON d.dept_no = de.dept_no
WHERE 
d.dept_name = 'Sales'
	OR
d.dept_name = 'Development';

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT e.last_name, COUNT(e.last_name)
FROM employees as e
GROUP BY e.last_name
ORDER BY count DESC