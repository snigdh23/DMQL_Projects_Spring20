SELECT e1.emp_no AS e1, e2.emp_no AS e2
FROM (SELECT e.emp_no
FROM employees e join dept_emp demp ON e.emp_no = demp.emp_no
WHERE e.birth_date LIKE "1955%" AND demp.dept_no = "d001" AND demp.to_date > '2020-04-15'
ORDER BY e.emp_no) e2 join (SELECT e.emp_no
FROM employees e join dept_emp demp ON e.emp_no = demp.emp_no
WHERE e.birth_date LIKE "1955%" AND demp.dept_no = "d001" AND demp.to_date > '2020-04-15'
ORDER BY e.emp_no) e1
WHERE e2.emp_no > e1.emp_no
ORDER BY e1.emp_no, e2.emp_no;