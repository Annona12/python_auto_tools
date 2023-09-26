show databases ;
show tables ;
show columns from vendors ;
describe vendors;
show status ;
show grants ;
SHOW ERRORS;
SHOW WARNINGS;
# 供应商表
select *from vendors;

select *from products;
select *from products limit 0,1;
select *from products limit 4,3;
select *from products limit 3  offset 4;
select *from products order by prod_price desc;
select *from products order by prod_price desc,prod_name desc;


# drop table vendors;