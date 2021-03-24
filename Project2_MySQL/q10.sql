select t1.empno as h_empno, t1.saly as h_salary, t1.hiredate as h_date, t2.empno as l_empno, t2.saly as l_salary, t2.hiredate as l_date
from(select empl.emp_no empno, sal.salary saly, empl.hire_date hiredate
from employees empl join salaries sal on empl.emp_no = sal.emp_no
where empl.birth_date like "1965%" and sal.to_date > "2020-04-22") t2 join (select empl.emp_no empno, sal.salary saly, empl.hire_date hiredate
from employees empl join salaries sal on empl.emp_no = sal.emp_no
where empl.birth_date like "1965%" and sal.to_date > "2020-04-22") t1
where t1.saly>t2.saly and t1.hiredate > t2.hiredate
order by t1.empno,t2.empno;