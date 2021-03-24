SELECT dpt.dept_name AS dept_name, COUNT(de.emp_no) AS noe
FROM dept_emp de JOIN departments dpt
WHERE de.dept_no = dpt.dept_no
GROUP BY dpt.dept_name
ORDER BY dpt.dept_name;