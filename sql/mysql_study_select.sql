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
select *from customers,orders,orderitems where customers.cust_id=orders.cust_id and orderitems.order_num=orders.order_num and prod_id='TNT2';

select *from productcustomers where prod_id='TNT2';

select *from vendorlocate;

select *from customersemail;

select avg(prod_price) as avg_price from products;
call productavgprice();

call productavgprice1(@lowp,@highp,@avgp);
select @lowp;

call ordertotal(20005,@total);
select @total;
call ordertotal1(20005,0,@total);
select @total;

call ordertotal1(20005,1,@total);

select @total;
show create procedure ordertotal1;

select *from orders;
select *from ordertotals;
call cursortest002();
select  *from vendors;
select *from products;
select @test;
# INSERT INTO orders(order_date, cust_id)VALUES( NOW(), 10004);
select @testorder;
select *from orders where order_num='20005';
select *from orderitems where order_num='20005';
select *from archive_orders;
# delete from orders where order_num='20012';

# 事务
select *from ordertotals;
start transaction ;
delete from ordertotals;
select *from ordertotals;
rollback ;
select *from ordertotals;

start transaction ;
delete from orderitems where order_num='20005';
savepoint delete1;
delete from orders where order_num='20005';
rollback to delete1;
commit ;
select @@autocommit;

show character set ;
show collation ;

select *from customers order by cust_name collate latin1_general_cs;

select *from user;
# rename user Annona_test to Annona;
show grants for Annona;