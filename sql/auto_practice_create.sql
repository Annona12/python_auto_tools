/* 练习题1-1：多列数据的最大值（练习题1-1-3也会用到） */
CREATE TABLE Greatests(
    key1 CHAR(1) PRIMARY KEY,
    x   INTEGER NOT NULL,
    y   INTEGER NOT NULL,
    z   INTEGER NOT NULL
)ENGINE=InnoDB COMMENT='比较表';

INSERT INTO Greatests VALUES('A', 1, 2, 3);
INSERT INTO Greatests VALUES('B', 5, 5, 2);
INSERT INTO Greatests VALUES('C', 4, 7, 1);
INSERT INTO Greatests VALUES('D', 3, 3, 8);

/* 练习题1-2-2：分地区排序 */
CREATE TABLE DistrictProducts(
    district  VARCHAR(16) NOT NULL,
    name      VARCHAR(16) NOT NULL,
    price     INTEGER NOT NULL,
 PRIMARY KEY(district, name, price)
)ENGINE=InnoDB COMMENT='地区水果价位表';
alter table DistrictProducts add ranking INTEGER;
INSERT INTO DistrictProducts VALUES('东北', '橘子',	100);
INSERT INTO DistrictProducts VALUES('东北', '苹果',	50);
INSERT INTO DistrictProducts VALUES('东北', '葡萄',	50);
INSERT INTO DistrictProducts VALUES('东北', '柠檬',	30);
INSERT INTO DistrictProducts VALUES('关东', '柠檬',	100);
INSERT INTO DistrictProducts VALUES('关东', '菠萝',	100);
INSERT INTO DistrictProducts VALUES('关东', '苹果',	100);
INSERT INTO DistrictProducts VALUES('关东', '葡萄',	70);
INSERT INTO DistrictProducts VALUES('关西', '柠檬',	70);
INSERT INTO DistrictProducts VALUES('关西', '西瓜',	30);
INSERT INTO DistrictProducts VALUES('关西', '苹果',	20);