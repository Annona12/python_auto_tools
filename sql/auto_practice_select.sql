/*从表里选出 x 和 y 二者中较大的值的情况*/
SELECT key1,(CASE WHEN x>y THEN x
    ELSE y END )AS greatest FROM Greatests;

SELECT key1,GREATEST(x,y)AS greatest FROM Greatests;

/*从表里选出 x、 y、z 三者中较大的值的情况*/
SELECT key1,(CASE WHEN x>y THEN (CASE WHEN x>z THEN x ELSE z END)
    ELSE (CASE WHEN y>z THEN y ELSE z END) END )AS greatest FROM Greatests;

SELECT CASE
    WHEN SEX=1 THEN SUM(population)
    ELSE SUM(population) END
FROM Poptbl2;
SELECT SUM(population)AS 全国,
       SUM(CASE WHEN pref_name = '德岛' THEN population ELSE 0 END) AS 德岛,
       SUM(CASE WHEN pref_name = '香川' THEN population ELSE 0 END) AS 香川,
       SUM(CASE WHEN pref_name = '爱媛' THEN population ELSE 0 END) AS 爱媛,
       SUM(CASE WHEN pref_name = '高知' THEN population ELSE 0 END) AS 高知,
       SUM(CASE WHEN pref_name IN ('德岛', '香川', '爱媛', '高知')
                THEN population ELSE 0 END) AS 四国 FROM Poptbl2 GROUP BY SEX;

/*思考一个查询语句，使得结果按照 B-A-D-C 这样的指定顺序进行排列*/
SELECT key1, CASE key1
    WHEN 'B' THEN 1
    WHEN 'A' THEN 2
    WHEN 'D' THEN 3
    WHEN 'C' THEN 4
    ELSE NULL END AS sort_col
FROM Greatests order by sort_col;
/*思考一个查询语句，使得结果按照 B-A-D-C 这样的指定顺序进行排列*/
SELECT *FROM Greatests order by CASE key1
    WHEN 'B' THEN 1
    WHEN 'A' THEN 2
    WHEN 'D' THEN 3
    WHEN 'C' THEN 4
    ELSE NULL END;

/*请使用 P.22 的表 Products，求出两列可重组合。结果应该如下所示*/
SELECT F1.name,F2.name FROM fruit F1,fruit F2 where F1.name>=f2.name;
SELECT *FROM fruit;

SELECT *FROM DistrictProducts;
SELECT P1.district, P1.name, P1.price, (SELECT COUNT( DISTINCT P2.price) FROM districtproducts P2 WHERE P1.price<P2.price)+1 AS rank_1 FROM districtproducts P1;

/*假设有下面这样一张表DistrictProducts2，边原本就包含了“位次”列,实现的是往这个列里写入位次*/
UPDATE districtproducts P1 SET ranking =(
    SELECT COUNT(DISTINCT P2.price)+1 FROM districtproducts P2 WHERE P1.district=P2.district AND P1.name=P2.name AND P1.price<P2.price
    );

SELECT P1.district, P1.name, P1.price, (SELECT COUNT( DISTINCT P2.price) FROM districtproducts P2 WHERE P1.price<P2.price)+1 AS rank_1 FROM districtproducts P1;

/*在“寻找缺失的编号”部分，我们写了一条 SQL 语句，让程序只在
存在缺失的编号时返回结果。请将 SQL 语句修改成始终返回一行结果，
即存在缺失的编号时返回“存在缺失的编号”，不存在缺失的编号时返回“不
存在缺失的编号”。*/
SELECT CASE WHEN COUNT((seq+1) NOT IN (SELECT seq FROM seqtbl))>0 THEN '存在缺失的编号' ELSE '不存在缺失的编号' END AS '寻找缺失的编号'  FROM seqtbl  ;

/*
 使用正文中的表 Students，全体学生都在 9 月份提交了报告的学院
 */
 SELECT * FROM students;
# 这个语句肯定是不准确的
SELECT dpt,sbmt_date FROM students  GROUP BY dpt HAVING COUNT(*)=COUNT(sbmt_date) AND MONTH(sbmt_date)=9;
SELECT dpt FROM Students GROUP BY dpt
HAVING COUNT(*) = SUM(CASE WHEN sbmt_date BETWEEN '2005-09-01' AND '2005-09-30'
                           THEN 1 ELSE 0 END);

SELECT *FROM items;
SELECT *FROM shopitems;
/*my_item_cnt 是店铺的现有库存商品种类数，diff_
cnt 是不足的商品种类数*/
SELECT shop,(COUNT(I.item)) AS my_item_cnt,((SELECT COUNT(*) FROM items)-COUNT(I.item)) AS diff_cnt FROM items I,shopitems SH  WHERE I.item = SH.item GROUP BY shop ;

/*抚养的孩子的人数*/
SELECT *FROM Personnel;
SELECT employee, children.child FROM personnel P1 LEFT OUTER JOIN children ON children.child IN(P1.child_3,P1.child_2,P1.child_1);

SELECT employee,COUNT(child) AS child_cnt FROM personnel P1 LEFT OUTER JOIN children ON children.child IN(P1.child_3,P1.child_2,P1.child_1) GROUP BY employee;
