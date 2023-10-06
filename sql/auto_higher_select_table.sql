SELECT *FROM PopTbl;
/*把县编号转换成地区编号 (1)*/
SELECT CASE
       WHEN pref_name='德岛' THEN '四国'
       WHEN pref_name='香川' THEN '四国'
       WHEN pref_name='爱媛' THEN '四国'
       WHEN pref_name='高知' THEN '四国'
       WHEN pref_name='福冈' THEN '九州'
       WHEN pref_name='长崎' THEN '九州'
       WHEN pref_name='佐贺' THEN '九州'
       ELSE '其他' END AS DISTRICT,
       SUM(population)
    FROM poptbl GROUP BY
    CASE
    WHEN pref_name='德岛' THEN '四国'
    WHEN pref_name='香川' THEN '四国'
    WHEN pref_name='爱媛' THEN '四国'
    WHEN pref_name='高知' THEN '四国'
    WHEN pref_name='福冈' THEN '九州'
    WHEN pref_name='长崎' THEN '九州'
    WHEN pref_name='佐贺' THEN '九州'
    ELSE '其他' END;
/*要按人数量等级（pop_class）查询都道府县个数的时候,
  可以在查询的时候使用别名后续在分组的时候就可以按照别名字段分组
  但是不推荐使用，因为有的数据库会报错*/
SELECT CASE
       WHEN population < 100 THEN '01'
       WHEN population>=100 AND population<200 THEN '02'
       WHEN population>=200 AND population<300 THEN '03'
       WHEN population>=300 THEN '04'
       ELSE null END AS POP_CLASS,
       COUNT(*) AS COUNT_NUM
    FROM poptbl GROUP BY POP_CLASS;
/*然后求按性别、县名汇总的人数*/
SELECT *FROM poptbl2;
SELECT pref_name,
       SUM(CASE WHEN sex=1 THEN population ELSE 0 END) AS '男',
       SUM(CASE WHEN sex=2 THEN population ELSE 0 END) AS '女'
FROM poptbl2 GROUP BY pref_name;

SELECT *FROM salaries;

UPDATE salaries SET salary = CASE
    WHEN salary>=300000 THEN salary*0.9
    WHEN salary>=250000 AND salary<280000 THEN salary*1.2
    ELSE salary END;

SELECT *FROM sometable;
UPDATE sometable SET p_key =CASE
    WHEN p_key='a' THEN 'b'
    WHEN p_key='b' THEN 'a'
    ELSE p_key END
    WHERE p_key IN('a','b');

/*这个语句存在问题*/
-- 用 CASE 表达式调换主键值
UPDATE SomeTable
 SET p_key = CASE WHEN p_key = 'a'
 THEN 'b'
 WHEN p_key = 'b'
 THEN 'a'
 ELSE p_key END
 WHERE p_key IN ('a', 'b');

SELECT *FROM CourseMaster;
SELECT *FROM opencourses;
SELECT course_name,
       CASE WHEN course_id in(SELECT course_id FROM opencourses WHERE month=200706 )THEN 'O' ELSE 'X' END AS '6月',
       CASE WHEN course_id in(SELECT course_id FROM opencourses WHERE month=200707 )THEN 'O' ELSE 'X' END AS '7月',
       CASE WHEN course_id in(SELECT course_id FROM opencourses WHERE month=200708 )THEN 'O' ELSE 'X' END AS '8月' FROM CourseMaster ORDER BY course_id;

SELECT *FROM StudentClub;
/*1. 获取只加入了一个社团的学生的社团 ID。*/
SELECT  std_id,club_id,club_name FROM studentclub GROUP BY std_id HAVING COUNT(*)=1;
/*获取加入了多个社团的学生的主社团 ID*/
SELECT  std_id,club_id,club_name,main_club_flg FROM studentclub WHERE main_club_flg='Y';

SELECT  std_id,(CASE
    WHEN COUNT(*)=1 THEN club_id
    ELSE MAX(CASE
        WHEN main_club_flg='Y' THEN club_id
        ELSE NULL END )END)  AS 'main_club' FROM studentclub GROUP BY std_id;


SELECT f.*FROM fruit f;
SELECT P1.name AS name1,P2.name AS name2 FROM fruit AS P1,fruit AS P2 where P1.name!=P2.name;

/*组合的查询结果*/
SELECT P1.name AS name1,P2.name AS name2 FROM fruit AS P1,fruit AS P2 where P1.name>P2.name;
/*如果存在三个数据进行组合*/
SELECT P1.name AS name1,P2.name AS name2,P3.name AS name3 FROM fruit AS P1,fruit AS P2 ,fruit AS P3 where P1.name>P2.name and P2.name>P3.name;

/*删除重复的列，使用mysql暂时不知道怎么实现*/

SELECT A1.name,A1.family_id,A1.address FROM addresses A1,addresses A2  WHERE A1.family_id=A2.family_id AND A1.address<> A2.address;
/*从下面这张商品表里找出价格相等的商品的组合。*/
SELECT DISTINCT F1.name, F1.price FROM fruit F1 ,fruit F2 WHERE F1.price=F2.price AND F1.name<> F2.name;
/*-- 排序从 1 开始。如果已出现相同位次，则跳过之后的位次*/
SELECT f.name,f.price,(SELECT COUNT(F2.PRICE )FROM fruit F2 WHERE F2.price<F.price)+1 AS rank_1 FROM fruit f ;
SELECT f.name,f.price,(SELECT COUNT( DISTINCT F2.PRICE )FROM fruit F2 WHERE F2.price<F.price)+1 AS rank_1 FROM fruit f ;
-- 排序 ：使用自连接
SELECT P1.name,
 MAX(P1.price) AS price,
 COUNT(P2.name) +1 AS rank_1
 FROM fruit P1 LEFT OUTER JOIN fruit P2
 ON P1.price < P2.price
 GROUP BY P1.name
 ORDER BY rank_1;
/*与 B 班住在东京的学生年龄不同的 A 班学生*/
SELECT *FROM class_a;
SELECT *FROM class_b;

/*不能实现*/
SELECT name FROM class_a WHERE AGE NOT IN (SELECT age FROM class_b WHERE city ='东京');

SELECT * FROM class_a A WHERE  NOT EXISTS( SELECT *FROM Class_B B WHERE A.age = B.age AND city = '东京');
/*比 B 班住在东京的所有学生年龄都小的 A 班学生*/

SELECT *FROM class_a WHERE age < ALL (SELECT age FROM class_b WHERE city='东京');
-- 查询比 B 班住在东京的年龄最小的学生还要小的 A 班学生
SELECT *
 FROM Class_A
 WHERE age < ( SELECT MIN(age)
 FROM Class_B
 WHERE city = '东京' );

SELECT income,COUNT(*) FROM Graduates GROUP BY income;