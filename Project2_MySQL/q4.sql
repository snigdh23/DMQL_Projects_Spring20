SELECT demp.emp_no AS emp_no, dept.dept_name AS dept_name, demp.from_date AS from_date
FROM dept_emp AS demp JOIN departments AS dept
WHERE demp.to_date > '2020-04-15' AND demp.dept_no = dept.dept_no
ORDER BY emp_no;