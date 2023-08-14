# SQL-Challenege

This Challenge is an analysis for a given dataset about people whom the company employed during the 1980s and 1990s. This dataset contains six CSV files.

departments.csv: file containing department names and nos.
dept_emp.csv: file containing employee and department nos.
dept_manager.csv: file containing department nos and employee nos
employees.csv: file containing employee no. and their base information 
salaries.csv: file containing employee no. and their salaries
titles.csv: file containing title names and IDs

For this project, we have designed the tables to hold the data from the CSV files, import the CSV files into a SQL database, 
and then answer questions about the data through data modeling, data engineering, and data analysis, respectively.

------------------------------------------------------------
Data Modelling through ERD shows the results that
------------------------------------------------------------
1.Employee's can be part of different departments.
2. Employees can have different titles.
3.Departments can have multiple managers.
4.Employee's salary is stored seperatly.

--------------------------------------------------------------------------------------------------------
A table schema was then created so that the data could be loaded into SQL for further analysis
--------------------------------------------------------------------------------------------------------
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
	emp_no INTEGER,
	salary FLOAT,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM salaries

------------------------------------------
Data Analysis
------------------------------------------
A sample analysis of 8 queries on the dataset was done, which were

1.List the employee number, last name, first name, sex, and salary of each employee.
2.List the first name, last name, and hire date for the employees who were hired in 1986.
3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
6.List each employee in the Sales department, including their employee number, last name, and first name.
7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

List the employee number, last name, first name, sex, and salary of each employee.
----------------------------------------------------------------------------------
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM Employees as e
JOIN Salaries as s on e.emp_no = s.emp_no;


List the first name, last name, and hire date for the employees who were hired in 1986.
_______________________________________________________________________________________
SELECT last_name, first_name, hire_date
FROM employees
WHERE hire_date like '%1986';


List the manager of each department along with their department number, department name,
employee number, last name, and first name
----------------------------------------------------------------------------------------
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager as dm
JOIN departments as d ON dm.dept_no = d.dept_no
JOIN employees as e ON e.emp_no = dm.emp_no;


List the department number for each employee along with that employee’s employee number,
last name, first name, and department name.
----------------------------------------------------------------------------------------
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
JOIN dept_emp as de ON de.emp_no = e.emp_no
JOIN departments as d ON d.dept_no = de.dept_no;


List first name, last name, and sex of each employee whose first name is Hercules and whose
last name begins with the letter B
--------------------------------------------------------------------------------------------
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' and last_name like 'B';


List each employee in the Sales department, including their employee number, last name, and
first name
--------------------------------------------------------------------------------------------
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
JOIN dept_emp as dm ON e.emp_no = dm.emp_no
JOIN departments as d ON d.dept_no = dm.dept_no
WHERE d.dept_name = 'Sales';


List each employee in the Sales and Development departments, including their employee number,
last name, first name, and department name
----------------------------------------------------------------------------------------------
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
JOIN dept_emp as dm ON e.emp_no = dm.emp_no
JOIN departments as d ON d.dept_no = dm.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';


List the frequency counts, in descending order, of all the employee last names (that is, how many
employees share each last name).
--------------------------------------------------------------------------------------------------
SELECT last_name, COUNT(last_name) as "frequency counts of last name"
FROM Employees
GROUP BY last_name
ORDER BY count(last_name) desc;
