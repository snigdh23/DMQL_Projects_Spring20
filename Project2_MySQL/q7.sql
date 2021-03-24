select mt1.EmployeeNo emp_no, mt2.dept_name dept_name
from (select emp_no EmployeeNo, dept_no DeptNo from (select emp_no, dept_no, datediff(to_date,from_date) dr from dept_manager where emp_no in (select emp_no from dept_manager where to_date < "2020-04-20")
order by dept_no asc, dr desc) sub_table1
where not exists (select * 
from (select emp_no, dept_no, datediff(to_date,from_date) dr from dept_manager
where emp_no in (select emp_no from dept_manager where to_date < "2020-04-20")
order by dept_no asc, dr desc) sub_table2 where sub_table2.dept_no = sub_table1.dept_no and sub_table2.dr > sub_table1.dr)) mt1 join departments mt2 on mt1.DeptNo = mt2.dept_no
order by emp_no asc;