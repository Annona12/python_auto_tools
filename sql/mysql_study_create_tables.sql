##################################################################
#管理供应商
#vendors表存储销售产品的供应商。每个供应商在这个表中有一个记录，供应商ID（vend_id）列用来匹配产品和供应商
##################################################################
create table if not exists vendors(
  vend_id    int  not null  AUTO_INCREMENT comment '供应商ID',
  vend_name    char(50) not null comment '供应商名',
  vend_address char(50)  comment '供应商的地址',
  vend_city    char(50)  comment '供应商的城市',
  vend_state   char(5)   comment '供应商的州',
  vend_zip     char(10)  comment '供应商的邮政编码',
  vend_country char(50)  comment '供应商的国家',
  primary key (vend_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='供应商表';

########################################################################
#产品表：products表
#products表包含产品目录，每行一个产品。每个产品有唯一的ID（prod_id列），通过vend_id（供应商的唯一ID）关联到它的供应商。
########################################################################
create table if not exists products(
  prod_id    char(10)      not null comment '产品ID',
  vend_id    int           not null comment '产品供应商ID（关联到vendors表中的vend_id）',
  prod_name  char(255)     not null comment '产品名',
  prod_price decimal(8,2)  not null comment '产品价格',
  prod_desc  text          comment '产品描述',
  primary key (prod_id)
) ENGINE=InnoDB COMMENT='产品表';
########################################################################
#顾客表：customers表
#customers表customers表存储所有顾客的信息。每个顾客有唯一的ID（cust_id列）
########################################################################
create table if not exists customers
(
  cust_id      int       not null AUTO_INCREMENT comment '顾客ID',
  cust_name    char(50)  not null comment '顾客名',
  cust_address char(50)  comment '顾客的地址',
  cust_city    char(50)  comment '顾客的城市',
  cust_state   char(5)   comment '顾客的州',
  cust_zip     char(10)  comment '顾客的邮政编码',
  cust_country char(50)  comment '顾客的国家',
  cust_contact char(50)   comment '顾客的联系名',
  cust_email   char(255)  comment '顾客的联系email地址',
  primary key(cust_id)
) ENGINE=InnoDB COMMENT='顾客表';
########################################################################
#订单表：orders表
#orders表存储顾客订单（但不是订单细节）。每个订单唯一地编号（order_num列）。订单用cust_id列（它关联到customer表的顾客唯一ID）与相应的顾客关联。
########################################################################
create table if not exists orders(
  order_num  int      not null AUTO_INCREMENT comment '订单号',
  order_date datetime not null comment '订单日期',
  cust_id    int      not null comment '订单顾客 ID （关系到customers表的cust_id）',
  primary key(order_num)
) ENGINE=InnoDB COMMENT='订单表';
########################################################################
#订单表：orderitems表
#orderitems表存储每个订单中的实际物品，每个订单的每个物品占一行。对orders中的每一行，orderitems中有一行或多行。
#每个订单物品由订单号加订单物品（第一个物品、第二个物品等）唯一标识
########################################################################
create table if not exists orderitems(
  order_num  int          not null comment '订单号（关联到orders表的order_num）',
  order_item int          not null comment '订单物品号（在某个订单中的顺序）',
  prod_id    char(10)     not null comment '产品ID（关联到products表的prod_id）',
  quantity   int          not null comment '物品数量',
  item_price decimal(8,2) not null comment '物品价格',
  primary key(order_num, order_item)
)ENGINE=InnoDB COMMENT='订单详细表';

######################################################
# productnotes表
# 存储与特定产品有关的注释。并非所有产品都有相关的注释，而有的产品可能有许多相关的注释
######################################################
CREATE TABLE productnotes
(
  note_id    int           not null AUTO_INCREMENT comment '注释ID',
  prod_id    char(10)      not null comment '产品ID（对应于products表中的prod_id）',
  note_date datetime       not null comment '增加注释的日期',
  note_text  text          comment '注释文本',
  primary key(note_id),
  FULLTEXT(note_text)
) ENGINE=MyISAM COMMENT='产品注释表';

#####################
# Define foreign keys
#####################
alter table orderitems add constraint fk_orderitem_orders foreign key (order_num) references orders(order_num);
alter table orderitems add constraint fk_orderitem_products foreign key (prod_id) references products(prod_id);
alter table orders add constraint fk_orders_customers foreign key(cust_id) references customers (cust_id);
alter table products add constraint fk_products_vendors foreign key(vend_id) references vendors (vend_id);

# 创建视图：已订购了任意产品的所有客户的列表
create view productcustomers as
    select customers.cust_id,cust_contact,prod_id
    from customers,orders,orderitems
    where customers.cust_id=orders.cust_id and orderitems.order_num=orders.order_num ;

# 创建输出特定格式的视图
create view vendorlocate as
    select concat(trim(vend_name),'(',trim(vend_country),')') as vend_title
    from vendors;

# 创建一个邮件信息不为空的视图
create view customersemail as
    select cust_id,cust_name,cust_email
    from customers
    where cust_email is not null;

# 创建存储过程:返回产品平均价格的存储过程
create procedure productavgprice()
begin
    select avg(prod_price) as avg_price from products;
end;

# 创建存储过程:返回产品平均价格的存储过程进阶版
create procedure productavgprice1(
     OUT low_price decimal(8,2),
     OUT high_price decimal(8,2),
     OUT agv_price decimal(8,2)
)
begin
    select min(prod_price)into low_price from products;
    select max(prod_price)into high_price from products;
    select avg(prod_price) from products into agv_price;
end;

# 创建包含IN和OUT参数的存储过程
create procedure ordertotal(
    IN onumber int,
    OUT ototal decimal(8,2)
)
begin
    select sum(quantity*item_price)
    from orderitems
    where order_num=onumber into ototal;
end;

# 更加智能的存储过程
create procedure ordertotal1 (
    IN onumber int,
    IN taxable boolean,
    OUT ototal decimal(8,2)
)comment 'Obtain order total,optionally adding tax'
begin
    declare total decimal(8,2);
    declare taxrate int default 6;
    select sum(item_price*quantity) from orderitems where order_num=onumber into total;

    if taxable then
        select total+(total/100*taxrate) into total;
    end if;
    select total into ototal;
end;

# 创建游标
create procedure cursortest()
begin
    declare ordernumbers cursor for
    select order_num from orders;
end;

# 创建游标进阶
create procedure cursortes01()
begin
    declare o int;
    declare ordernumbers cursor for
    select order_num from orders;
    open ordernumbers;
    fetch ordernumbers into o;
    close ordernumbers;
end;

# drop procedure cursortest002;
# 创建游标终极版本
create procedure cursortest002()
begin
    declare done boolean default 0;
    declare o int;
    declare t decimal(8,2);

    declare orderunmbers1 cursor for
        select order_num from orders;
    declare continue handler for sqlstate '02000' set done=1;
    create table if not exists ordertotals(
        order_num int comment '订单编号',
        total decimal(8,2) comment '总金额'
    );
    open orderunmbers1;
    repeat
        fetch orderunmbers1 into o;
        call ordertotal1(o,1,t);
        insert into ordertotals (order_num, total) values (o,t);
        until  done end repeat;
        close orderunmbers1;
end;