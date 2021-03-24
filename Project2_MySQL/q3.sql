SELECT E.last_name, S.salary, S.from_date, S.to_date 
FROM salaries S JOIN employees E on S.emp_no = E.emp_no
ORDER BY E.last_name, S.salary, S.from_date, S.to_date;