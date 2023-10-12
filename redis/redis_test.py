# 开发者：Annona
# 开发时间：2023/10/12 15:55

from redis import *
if __name__ == '__main__':
    try:
        # 创建StrictRedis对象，与redis服务器建⽴连接
        str = StrictRedis()
        # 添加键
        set_result = str.set('name','Annona')
        set_result1 = str.set('name1','Annona1')
        # 获取键
        get_result = str.get('name')
        get_result1 = str.get('name1')
        # 获取键
        get_keys = str.keys()
        delete_result = str.delete('name')
        print('get_result:',get_result)
        print('get_result1:',get_result1)

        print('delete_result:',delete_result)
        print('get_result:',get_result)
        print('get_keys:',get_keys)


    except Exception as e:
        print(e)