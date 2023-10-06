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
select *from orders;
analyze table orders ;
check table orders,orderitems;
show variables ;
show status ;
show processlist ;

select *from vendors;
select *from products;
select prod_id,vend_id,count(*) from products group by vend_id;
select vend_id,count(*) from products group by vend_id with rollup ;
select *from orders;
select *from orderitems o ;
select cust_id,count(*) from orders group by cust_id ;
select cust_id,count(*) from orders group by cust_id having count(*)>=2;
select vend_id,count(*) from products where prod_price>10 group by vend_id having count(*)>= 2;
select *
from customers
where cust_id in
      (select cust_id from orders where order_num in (select order_num from orderitems where prod_id = 'TNT2'));

select cust_name,cust_state, (select count(*) from orders where orders.cust_id = customers.cust_id ) as orders  from customers;


select *
from vendors inner join products on vendors.vend_id=products.vend_id;



SELECT p1.prod_id,p1.prod_name FROM products AS p1,products AS p2 WHERE p1.vend_id = p2.vend_id AND p2.prod_id ='DTNTR';

SELECT customers.cust_id,orders.order_num FROM customers left OUTER JOIN orders ON orders.cust_id = customers.cust_id;


select customers.cust_id,customers.cust_name, count(orders.order_num)as num from customers left outer join orders on customers.cust_id=orders.cust_id group by customers.cust_id;

select p.vend_id ,p.prod_id,p.prod_price from products p where p.prod_price <=5 or p.vend_id in(1001,1002);

select p.vend_id ,p.prod_id,p.prod_price from products p where p.prod_price <=5 union select p.vend_id ,p.prod_id,p.prod_price from products p where p.vend_id in(1001,1002) order by prod_price;

select *from productnotes;

select note_id,note_text from productnotes where Match(note_text) against('rabbit');

select note_id,note_text from productnotes where Match(note_text) against('anvils' with query expansion );

select note_id,note_text from productnotes where Match(note_text) against('heavy -rope*' IN BOOLEAN MODE );
select note_id,note_text from productnotes where Match(note_text) against('rabbit bait' IN BOOLEAN MODE );
update customers set cust_email='qqwe3@funny.com',cust_name ='Lee' where cust_id=10005
select *
from customers;

select last_insert_id();
alter table vendors add vend_phone char(20);
