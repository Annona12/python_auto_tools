# DROP TABLE PopTbl;
CREATE TABLE IF NOT EXISTS PopTbl(
    pref_name VARCHAR(32) PRIMARY KEY COMMENT '地区名',
    population INTEGER NOT NULL COMMENT '人数'
)ENGINE=InnoDB COMMENT='人口统计表';
# 初始化表
INSERT INTO PopTbl VALUES('德岛', 100);
INSERT INTO PopTbl VALUES('香川', 200);
INSERT INTO PopTbl VALUES('爱媛', 150);
INSERT INTO PopTbl VALUES('高知', 200);
INSERT INTO PopTbl VALUES('福冈', 300);
INSERT INTO PopTbl VALUES('佐贺', 100);
INSERT INTO PopTbl VALUES('长崎', 200);
INSERT INTO PopTbl VALUES('东京', 400);
INSERT INTO PopTbl VALUES('群马', 50);

CREATE TABLE IF NOT EXISTS PopTbl2(
    pref_name VARCHAR(32) COMMENT '地区名',
    sex CHAR(1) NOT NULL COMMENT '性别',
    population INTEGER NOT NULL COMMENT '人口',
    PRIMARY KEY(pref_name, sex)
)ENGINE=InnoDB COMMENT='人口统计表2';

INSERT INTO PopTbl2 VALUES('德岛', '1',	60 );
INSERT INTO PopTbl2 VALUES('德岛', '2',	40 );
INSERT INTO PopTbl2 VALUES('香川', '1',	100);
INSERT INTO PopTbl2 VALUES('香川', '2',	100);
INSERT INTO PopTbl2 VALUES('爱媛', '1',	100);
INSERT INTO PopTbl2 VALUES('爱媛', '2',	50 );
INSERT INTO PopTbl2 VALUES('高知', '1',	100);
INSERT INTO PopTbl2 VALUES('高知', '2',	100);
INSERT INTO PopTbl2 VALUES('福冈', '1',	100);
INSERT INTO PopTbl2 VALUES('福冈', '2',	200);
INSERT INTO PopTbl2 VALUES('佐贺', '1',	20 );
INSERT INTO PopTbl2 VALUES('佐贺', '2',	80 );
INSERT INTO PopTbl2 VALUES('长崎', '1',	125);
INSERT INTO PopTbl2 VALUES('长崎', '2',	125);
INSERT INTO PopTbl2 VALUES('东京', '1',	250);
INSERT INTO PopTbl2 VALUES('东京', '2',	150);

/* 员工工资信息表 */
CREATE TABLE  IF NOT EXISTS Salaries(
    name VARCHAR(32) PRIMARY KEY COMMENT '员工姓名',
    salary INTEGER NOT NULL COMMENT '员工工资'
)ENGINE=InnoDB COMMENT='员工工资表';

INSERT INTO Salaries VALUES('相田', 300000);
INSERT INTO Salaries VALUES('神崎', 270000);
INSERT INTO Salaries VALUES('木村', 220000);
INSERT INTO Salaries VALUES('齐藤', 290000);

/* 在UPDATE语句里进行条件分支 */
CREATE TABLE SomeTable(
    p_key CHAR(1) PRIMARY KEY COMMENT '主键',
    col_1 INTEGER NOT NULL COMMENT '第一列',
    col_2 CHAR(2) NOT NULL COMMENT '第二列'
)ENGINE=InnoDB COMMENT='SomeTable表';

INSERT INTO SomeTable VALUES('a', 1, '一');
INSERT INTO SomeTable VALUES('b', 2, '二');
INSERT INTO SomeTable VALUES('c', 3, '三');

/* 表之间的数据匹配 */
CREATE TABLE CourseMaster(
    course_id   INTEGER PRIMARY KEY,
    course_name VARCHAR(32) NOT NULL
)ENGINE=InnoDB COMMENT='课程一览表';

INSERT INTO CourseMaster VALUES(1, '会计入门');
INSERT INTO CourseMaster VALUES(2, '财务知识');
INSERT INTO CourseMaster VALUES(3, '簿记考试');
INSERT INTO CourseMaster VALUES(4, '税务师');

CREATE TABLE OpenCourses(
    month INTEGER ,
    course_id INTEGER ,
    PRIMARY KEY(month, course_id)
)ENGINE=InnoDB COMMENT='开设的课程表';

INSERT INTO OpenCourses VALUES(200706, 1);
INSERT INTO OpenCourses VALUES(200706, 3);
INSERT INTO OpenCourses VALUES(200706, 4);
INSERT INTO OpenCourses VALUES(200707, 4);
INSERT INTO OpenCourses VALUES(200708, 2);
INSERT INTO OpenCourses VALUES(200708, 4);

/* 在CASE表达式中使用聚合函数 */
CREATE TABLE StudentClub(
    std_id  INTEGER,
    club_id INTEGER,
    club_name VARCHAR(32),
    main_club_flg CHAR(1),
    PRIMARY KEY (std_id, club_id)
)ENGINE=InnoDB COMMENT='社团表';

INSERT INTO StudentClub VALUES(100, 1, '棒球',        'Y');
INSERT INTO StudentClub VALUES(100, 2, '管弦乐',      'N');
INSERT INTO StudentClub VALUES(200, 2, '管弦乐',      'N');
INSERT INTO StudentClub VALUES(200, 3, '羽毛球','Y');
INSERT INTO StudentClub VALUES(200, 4, '足球',    'N');
INSERT INTO StudentClub VALUES(300, 4, '足球',    'N');
INSERT INTO StudentClub VALUES(400, 5, '游泳',        'N');
INSERT INTO StudentClub VALUES(500, 6, '围棋',        'N');

CREATE TABLE IF NOT EXISTS fruit(
    name char(30) COMMENT '商品名称',
    price float NOT NULL
)ENGINE=InnoDB,COMMENT '水果产品表';
INSERT INTO fruit VALUES('苹果',50);
INSERT INTO fruit VALUES('橘子',100);
INSERT INTO fruit VALUES('香蕉',80);
INSERT INTO fruit VALUES('西瓜',50);
INSERT INTO fruit VALUES('柠檬',30);
INSERT INTO fruit VALUES('葡萄',50);
# DROP TABLE fruit;

# DROP TABLE Addresses;
CREATE TABLE IF NOT EXISTS Addresses(
    name varchar(32) COMMENT '姓名',
    family_id char(30) NOT NULL COMMENT '家庭ID',
    address varchar(32) NOT NULL COMMENT '住址',
    PRIMARY KEY (name,family_id)
)ENGINE=InnoDB,COMMENT '家庭住址表';
INSERT INTO Addresses VALUES('前田义明', '100', '东京都港区虎之门3-2-29');
INSERT INTO Addresses VALUES('前田由美', '100', '东京都港区虎之门3-2-92');
INSERT INTO Addresses VALUES('加藤茶',   '200', '东京都新宿区西新宿2-8-1');
INSERT INTO Addresses VALUES('加藤胜',   '200', '东京都新宿区西新宿2-8-1');
INSERT INTO Addresses VALUES('福尔摩斯',  '300', '贝克街221B');
INSERT INTO Addresses VALUES('华生',  '400', '贝克街221B');


/* 3.NOT IN和NOT EXISTS不是等价的 */
CREATE TABLE Class_A(
    name VARCHAR(16) PRIMARY KEY,
    age  INTEGER,
    city VARCHAR(16) NOT NULL
)ENGINE=InnoDB,COMMENT 'Class_A';

CREATE TABLE Class_B(
    name VARCHAR(16) PRIMARY KEY,
    age  INTEGER,
    city VARCHAR(16) NOT NULL
)ENGINE=InnoDB,COMMENT 'Class_B';

INSERT INTO Class_A VALUES('布朗', 22, '东京');
INSERT INTO Class_A VALUES('拉里',   19, '埼玉');
INSERT INTO Class_A VALUES('伯杰',   21, '千叶');

INSERT INTO Class_B VALUES('齐藤',  22,   '东京');
INSERT INTO Class_B VALUES('田尻',  23,   '东京');
INSERT INTO Class_B VALUES('山田',  NULL, '东京');
INSERT INTO Class_B VALUES('和泉',  18,   '千叶');
INSERT INTO Class_B VALUES('武田',  20,   '千叶');
INSERT INTO Class_B VALUES('石川',  19,   '神奈川');

/* 4.限定谓词和NULL */
DELETE FROM Class_A;
INSERT INTO Class_A VALUES('布朗', 22, '东京');
INSERT INTO Class_A VALUES('拉里',   19, '埼玉');
INSERT INTO Class_A VALUES('伯杰',   21, '千叶');

DELETE FROM Class_B;
INSERT INTO Class_B VALUES('齐藤', 22, '东京');
INSERT INTO Class_B VALUES('田尻', 23, '东京');
INSERT INTO Class_B VALUES('山田', 20, '东京');
INSERT INTO Class_B VALUES('和泉', 18, '千叶');
INSERT INTO Class_B VALUES('武田', 20, '千叶');
INSERT INTO Class_B VALUES('石川', 19, '神奈川');

/* 5.限定谓词和极值函数不是等价的 */
DELETE FROM Class_B;
INSERT INTO Class_B VALUES('和泉', 18, '千叶');
INSERT INTO Class_B VALUES('武田', 20, '千叶');
INSERT INTO Class_B VALUES('石川', 19, '神奈川');

/* 用HAVING子句进行子查询：求众数(求中位数时也用本代码) */
CREATE TABLE Graduates(
    name   VARCHAR(16) PRIMARY KEY,
    income INTEGER NOT NULL
)ENGINE=InnoDB,COMMENT '毕业生工资表';

INSERT INTO Graduates VALUES('桑普森', 400000);
INSERT INTO Graduates VALUES('迈克',     30000);
INSERT INTO Graduates VALUES('怀特',   20000);
INSERT INTO Graduates VALUES('阿诺德', 20000);
INSERT INTO Graduates VALUES('史密斯',     20000);
INSERT INTO Graduates VALUES('劳伦斯',   15000);
INSERT INTO Graduates VALUES('哈德逊',   15000);
INSERT INTO Graduates VALUES('肯特',     10000);
INSERT INTO Graduates VALUES('贝克',   10000);
INSERT INTO Graduates VALUES('斯科特',   10000);