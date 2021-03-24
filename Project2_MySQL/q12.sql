with dptavg as (select demp.dept_no, avg(sal.salary) avgsaly from salaries sal join current_dept_emp demp on sal.emp_no = demp.emp_no where YEAR(sal.to_date) = 9999 group by demp.dept_no),
deptotal as (select count(emp_no) tots ,dept_no from current_dept_emp where YEAR(to_date) = 9999 group by dept_no)
select  dept.dept_name, (count(sal.emp_no)/deptotal.tots)*100 above_avg_pect 
from salaries sal join current_dept_emp cdep on sal.emp_no = cdep.emp_no join departments dept on cdep.dept_no = dept.dept_no join dptavg on dept.dept_no = dptavg.dept_no 
	 join deptotal on dept.dept_no = deptotal.dept_no
where YEAR(sal.to_date) = 9999 and YEAR(cdep.to_date) = 9999 and sal.salary > dptavg.avgsaly
group by dept.dept_no
order by dept.dept_name;