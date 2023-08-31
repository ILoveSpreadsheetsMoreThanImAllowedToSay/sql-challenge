--Build Primary Key Containing tables first in order of dependency.  Could go back and alter afterward but meh.

--departments
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
  dept_no VARCHAR(4) PRIMARY KEY,
  dept_name VARCHAR(30) NOT NULL -- Useless table without this.  Why the heck would you create one or more departments without already knowing their name?
-- Length of dept_name set to 30 as longest extant is 18
);

SELECT * FROM departments;

--titles
DROP TABLE IF EXISTS titles;

CREATE TABLE titles (
  title_id VARCHAR(5) PRIMARY KEY,
  title VARCHAR(30) NOT NULL -- Useless without this, what's the point of having titles if they don't exist?  I mean, Titles are nonsense to begin with but.
-- Length of title set to 30 as longest extant is 18
);

SELECT * FROM titles;
--employees
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
  emp_no INTEGER PRIMARY KEY,
  emp_title_id VARCHAR(5) NOT NULL, --Foreign key, can't allow to be missing
  birth_date DATE NOT NULL, --Probably a legal reason to knnow birth date, labor laws and all.
  first_name VARCHAR(100) NOT NULL, -- Self evident for NOT NULL purposes, I would think?
  last_name VARCHAR(100) NOT NULL, -- Self evident for NOT NULL purposes, I would think?
  sex VARCHAR(2), -- 'NOT NULL' not imposed as sex is largely mutable and.  Well I have a lot of opinions on this particular field.  I am transgender, so... Also the current legal options on a Federal level for the US are M, F, and X.  More may be added as understanding evolves.
  hire_date DATE NOT NULL, --Probably necessary
  FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
	
-- First and last names are set to 100 characters as the example dataset contains eastern and western sounding names, which may be difficult to handle depending on how the encoding on the front end works. Unless I misunderstand that; regardless, there could be a lot of diversity in names, so 100 seems good.

);

SELECT * FROM employees;

--dept_emp
DROP TABLE IF EXISTS dept_emp;

CREATE TABLE dept_emp (
  emp_no INTEGER NOT NULL,
  dept_no VARCHAR(5) NOT NULL, -- Length pulled from consituent table
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  PRIMARY KEY (emp_no, dept_no) -- Composite primary key, the above are NOT NULL'd to let this join table work


);

SELECT * FROM dept_emp;

--dept_manager
DROP TABLE IF EXISTS dept_manager;

CREATE TABLE dept_manager (
  dept_no VARCHAR(5) NOT NULL, -- Length pulled from constituent table
  emp_no INTEGER NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (dept_no, emp_no) -- Composite primary key, the above are NOT NULL'd to let this join table work

);

SELECT * FROM dept_manager;


--salaries
DROP TABLE IF EXISTS salaries;

CREATE TABLE salaries (
  salary_id SERIAL PRIMARY KEY, -- Primary key  
  emp_no INTEGER NOT NULL, --Foreign key, needs to be filled out
  salary INTEGER NOT NULL, --Can't be not paying people as this might be used by payroll, come on now.
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),

);

SELECT * FROM salaries;

