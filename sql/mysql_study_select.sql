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
select  concat(vend_name,'(',RTRIM(vend_country),')') as vend_title from vendors;
select *from orders where DATE(order_date)='2005-09-01';
select *from orders where year(order_date)='2005' and month(order_date)='9';

select prod_id,quantity,item_price,quantity*item_price as total from orderitems where order_num='20005';

select *from products;
select *from products limit 0,1;
select *from products limit 4,3;
select *from products limit 3  offset 4;
select *from products order by prod_price desc limit 1;
select *from products where prod_name like 'JetPack 1000';
select *from products where prod_name regexp '.000';
select *from products where prod_name regexp '1000|2000';
select *from products where prod_name regexp '[123] ton';
select *from products where prod_name regexp '[1-5] ton';
select *from products where prod_name regexp '\\([0-9] sticks?\\)';
select *from products where prod_name regexp '[0-9]{4}';
select *from products where prod_name regexp '^[0-9\\.]';
select vend_id,avg(prod_price) as avg_price from products where vend_id ='1003';
# drop table vendors;
select count(*) as total from customers;
select count(cust_email) as total from customers;

select *from products ;

select avg( prod_price)from products ;
select avg(distinct prod_price)from products ;

select sum(quantity) as total_quantity from orderitems;
