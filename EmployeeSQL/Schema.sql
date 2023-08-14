--Creating the table "departments"
CREATE TABLE departments(
	dept_no VARCHAR(5) PRIMARY KEY,
	dept_name VARCHAR(30)
);
SELECT * FROM departments;


--Creating a table for "titles"
CREATE TABLE titles(
	title_id VARCHAR(15) PRIMARY KEY,
	title VARCHAR(30)
);	
SELECT * FROM titles


--creating a table for the employees
CREATE TABLE employees(
	emp_no INTEGER PRIMARY KEY,
	emp_title VARCHAR(15),
	birth_date VARCHAR(10),
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(6),
	hire_date VARCHAR(15),
	FOREIGN KEY (emp_title) REFERENCES titles(title_id)
);
SELECT * FROM employees


--Creating the table for "department employees"
CREATE TABLE dept_emp(
	emp_no INTEGER,
	dept_no VARCHAR(15) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
SELECT * FROM dept_emp


--Creating a table for "department managers"
CREATE TABLE dept_manager(
	dept_no VARCHAR(15),
	emp_no INTEGER,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY(dept_no, emp_no)
);
SELECT * FROM dept_manager


--creating a table "salaries"
CREATE TABLE salaries(
	emp_no INTEGER, PRIMARY KEY
	salary FLOAT,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM salaries
