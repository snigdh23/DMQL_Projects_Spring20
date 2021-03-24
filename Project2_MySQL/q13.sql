with xyz as (select t1.title as src, t2.title as dst from (select distinct(title) from titles) t1 join (select distinct(title) from titles) t2 order by t2.title, t1.title),
abc as (select t1.title as src, t2.title as dst from titles t1 join titles t2 on t1.emp_no = t2.emp_no where t1.title != t2.title and t1.to_date = t2.from_date group by src, dst),
def as (select a1.src as a1src, a1.dst as a1dst, a2.dst as a2dst, a3.dst as a3dst, a4.dst as a4dst from abc a1 join abc a2 join abc a3 join abc a4 where a1.dst = a2.src and a2.dst=a3.src and a3.dst = a4.src),
comb as (select d1.a1src, d1.a1dst from def d1 union select d2.a1src, d2.a2dst from def d2 union select d3.a1src, d3.a3dst from def d3 union select d4.a1src, d4.a4dst from def d4),
fincomb as (select a1src as src, a1dst as dst from comb order by a1src,a1dst)
select src,dst from xyz where (src,dst) not in (select fincomb.src,fincomb.dst from fincomb) order by xyz.src, xyz.dst;