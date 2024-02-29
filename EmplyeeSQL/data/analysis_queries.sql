--List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT emp_no, last_name, first_name, hire_date 
FROM employees 
WHERE extract(year from hire_date) = 1986;

--List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM dept_emp as de
		LEFT JOIN employees as e
					ON e.emp_no = de.emp_no
		LEFT JOIN departments as d
					ON d.dept_no = de.dept_no

WHERE e.emp_title_id LIKE 'm%';

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

CREATE VIEW all_dept_emp AS -- Create view for the joined table

			(SELECT e.emp_no
			 		,e.emp_title_id
			 		,e.birth_date
			 		,e.last_name
			 		,e.first_name
			 		,e.sex
			 		,e.hire_date
			 		,d.dept_name
			 		,d.dept_no

			FROM 	dept_emp as de
					LEFT JOIN employees as e
								ON e.emp_no = de.emp_no
					LEFT JOIN departments as d
								ON d.dept_no = de.dept_no)
;

SELECT emp_no, last_name, first_name, dept_name
FROM all_dept_emp;


--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT e.first_name, e.last_name, e.sex
FROM employees AS e
WHERE e.first_name = 'Hercules'
		AND e.last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.

CREATE VIEW emp AS  -- Create another view as similar information is required in the 2 questions

			(SELECT
					emp_no
					,last_name
					,first_name
					,dept_name

			FROM	all_dept_emp)
;

SELECT * FROM emp
WHERE	dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT * FROM emp
WHERE dept_name IN ('Sales', 'Development');

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT e.last_name, COUNT(e.last_name) AS frequency
FROM employees AS e
GROUP BY e.last_name
ORDER BY frequency DESC;
