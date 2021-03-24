with abc as(select src,dst,avg(prom_time) as years
from (select t1.title as src, t2.title as dst, (YEAR(t2.from_date) - YEAR(t1.from_date) + 1) as prom_time from titles t1 join titles t2 on t1.emp_no = t2.emp_no where t1.title != t2.title and t1.to_date = t2.from_date order by src,dst) trewq
group by src,dst order by src,dst),

nd3 as (select a1.src as s1, a1.dst as d1, a1.years as ave1, a2.src as s2, a2.dst as d2, a2.years as ave2
from abc a1 join abc a2),

f1 as (select s1 as src, d2 as dst, (ave1+ave2) as years from nd3 where d1=s2 and s1 not in (s2,d2) and s2!=d2),

nd4 as (select a1.src as s1, a1.dst as d1, a1.years as ave1, a2.src as s2, a2.dst as d2, a2.years as ave2,  a3.src as s3, a3.dst as d3, a3.years as ave3 
from abc a1 join abc a2 join abc a3 where a1.dst=a2.src and a2.dst=a3.src),

f2 as (select s1 as src, d3 as dst, (ave1+ave2+ave3) as years from nd4 where s1 not in (s2,s3,d3) and s2 not in (s3,d3)),

nd5 as (select a1.src as s1, a1.dst as d1, a1.years as ave1, a2.src as s2, a2.dst as d2, a2.years as ave2, a3.src as s3, a3.dst as d3, a3.years as ave3, a4.src as s4, a4.dst as d4, a4.years as ave4 
from abc a1 join abc a2 join abc a3 join abc a4 where a1.dst=a2.src and a2.dst=a3.src and a3.dst=a4.src and a1.src!=a2.dst and a1.src!=a3.dst and a1.src!=a4.dst and a2.src!=a3.dst and a2.src!=a4.dst and a3.src!=a4.dst order by s1,d1),

f3 as (select s1 as src, d4 as dst, (ave1+ave2+ave3+ave4) as years from nd5),

nd6 as (select a1.src as s1, a1.dst as d1, a1.years as ave1, a2.src as s2, a2.dst as d2, a2.years as ave2, a3.src as s3, a3.dst as d3, a3.years as ave3, a4.src as s4, a4.dst as d4, a4.years as ave4, a5.src as s5, a5.dst as d5, a5.years as ave5 
from abc a1 join abc a2 join abc a3 join abc a4 join abc a5),

f4 as (select s1 as src,d4 as dst, (ave1+ave2+ave3+ave4+ave5) as years from nd6 where s1 not in (s2,s3,s4,s5,d5) and d1=s2 and d2=s3 and d3=s4 and d4=s5 and s2 not in (s3,s4,s5,d5) and s3 not in (s4,s5,d5) and s4 not in (s5,d5)),
fin as ((select src,dst,years from abc) union (select src,dst,years from f1) union (select src,dst,years from f2) union (select src,dst,years from f3) union (select src,dst,years from f4))
select src,dst,years from fin group by src,dst order by src, dst, years;