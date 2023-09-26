# 开发者：Annona
# 开发时间：2023/9/19 16:08
import logging

import pymysql
import cx_Oracle


class DatabaseTool:
    def __init__(self):
        self.connection = None

    def conn_oracle(self, dsn, user, password):
        """
        连接oracle数据库
        :param dsn: 数据库的数据源名称，它可以是一个 TNS 格式的连接字符串，或者是一个字典对象.
        :param username: 要连接的数据库用户的用户名
        :param password: 要连接的数据库用户的密码
        :return: 返回连接实例
        """
        try:
            self.connection = cx_Oracle.connect(dsn=dsn, user=user, password=password)
        except cx_Oracle.Error as e:
            logging.error('数据库连接失败，失败原因：{}'.format(e))
            raise Exception('数据库连接失败，失败原因：{}'.format(e))

    def conn_mysql(self, host, port, user, password, database, charset):
        """
        连接mysql数据库
        :param host: ip
        :param port: 端口
        :param user: 用户名
        :param passwd: 密码
        :param database: 数据库实例
        :param charset: 编码格式
        :return: 连接实例
        """
        try:
            self.connection = pymysql.connect(
                host=host,
                port=port,
                user=user,
                password=password,
                database=database,
                charset=charset
            )
        except pymysql.Error as e:
            logging.error('数据库连接失败，失败原因：{}'.format(e))
            raise Exception('数据库连接失败，失败原因：{}'.format(e))

    # mysql中创建数据库

    # 查询数据库关键字
    def sql_select(self, sql):
        try:
            cursor = self.connection.cursor()
            cursor.execute(sql)
            results = cursor.fetchall()
            # value = [val for val,in results]
            cursor.close()
            # return value
            return results
        except cx_Oracle.Error as e:
            logging.error("执行SQL查询失败，失败原因{}".format(e))
            raise
        except pymysql.Error as e:
            logging.error("执行SQL查询失败，失败原因{}".format(e))
            raise

    def close_connection(self):
        if self.connection:
            self.connection.close()


# if __name__ == '__main__':
#     db_tools = DatabaseTool()
#     try:
#         db_tools.conn_oracle(
#             dsn=dsn,
#             user=oracle_user,
#             password=oracle_password
#         )
#         # db_tools.conn_mysql(
#         #     host=mysql_host,
#         #     port=mysql_port,
#         #     user=mysql_user,
#         #     password=mysql_password,
#         #     database=mysql_database,
#         #     charset=mysql_charset
#         # )
#         requests = db_tools.sql_select(sql='select *from ttrd_fix_order')
#         print(requests)
#     except Exception as e:
#         print("查询数据库失败,失败原因：{}".format(e))
#     finally:
#         pass
#         # test.close()
#         # db_tools.close_connection()
