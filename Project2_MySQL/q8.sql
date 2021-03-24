select dept_name, cnt-1 as cnt
from(select dmn.dept_no, dpt.dept_name as dept_name, count(dmn.dept_no) as cnt 
from dept_manager dmn join departments dpt on dmn.dept_no = dpt.dept_no
group by dmn.dept_no
having cnt>2) as sub_table
order by dept_name;