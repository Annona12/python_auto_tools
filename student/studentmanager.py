# 开发者：Annona
# 开发时间：2023/10/12 16:31
"""
系统功能
添加学员
删除学员
修改学员
查询学员信息
显示所有学员信息
保存学员信息
退出系统
一、实现这个系统功能的思路：

"""
from student import Student


class StudentManager:
    def __init__(self):
        self.student_list = []
    def run(self):
        print('请选择如下功能编号：')
        print('1:添加学员')
        print('2:删除学员')
        print('3:修改学员信息')
        print('4:查询学员信息')
        print('5:显示所有学员信息')
        print('6:保存学员信息')
        print('7:退出系统')
        self.load_student()
        while True:
            menu_num = int(input('请输入您需要操作的编号：'))
            if menu_num == 1:
                self.add_student()
                continue
            elif menu_num == 2:
                self.delete_student()
                continue
            elif menu_num == 3:
                self.update_student()
                continue
            elif menu_num == 4:
                self.select_single_student()
                continue
            elif menu_num == 5:
                self.select_all_student()
                continue
            elif menu_num == 6:
                self.save_studen()
                continue
            elif menu_num == 7:
                # 退出系统
                print('感谢使用该系统，下次再见！！')
                break
            else:
                print('您输入的操作编号有误，请重新输入！！')
                continue
    def add_student(self):
        name = input('请输入姓名：')
        age = int(input('请输入年龄：'))
        sex = input('请输入性别：')
        tel = input('请输入电话：')
        student = Student(name,age,sex,tel)
        self.student_list.append(student)
        print('添加学生成功:',name,age,sex,tel)
    def delete_student(self):
        deletc_name = input('请输入你需要删除的学生姓名：')
        for i in self.student_list:
            if deletc_name == i.name:
                self.student_list.remove(i)
                print(f'{deletc_name}个人信息删除完成')
                break
        else:
            print('查无此人！')
    def update_student(self):
        update_name = input('请输入需要修改人的姓名:')
        for i in self.student_list:
            if update_name == i.name:
                i_name = input('请输入姓名：')
                i_age = int(input('请输入年龄：'))
                i_sex = input('请输入性别：')
                i_tel = input('请输入电话：')
                print(f'{update_name}个人信息修改完成')
                break
        else:
            print('查无此人')
    def select_single_student(self):
        select_name = input('请输入需要修改人的姓名:')
        for i in self.student_list:
            if select_name == i.name:
                print('查询的个人信息为：',i.name,i.age,i.sex,i.tel)
                break
        else:
            print('查无此人')
    def select_all_student(self):
        # 1. 打印表头
        print('姓名\t性别\t手机号')
        # 2. 打印学员数据
        for i in self.student_list:
            print(f'{i.name}\t{i.age}\t{i.sex}\t{i.tel}')
    def save_studen(self):
        # 1. 打开文件
        f = open('student.data', 'w',encoding='utf-8')
        # 2. 文件写入数据
        # 2.1 [学员对象] 转换成 [字典]
        new_list = [i.__dict__ for i in self.student_list]
        # 2.2 文件写入 字符串数据
        f.write(str(new_list))
        # 3. 关闭文件
        f.close()
        print('学生信息保存成功！')
    def load_student(self):
        try:
            f = open('student.data','r',encoding='utf-8')
        except Exception as e:
            f = open('student.data','w',encoding='utf-8')
        else:
            data = f.read()
            new_list = eval(data)
            self.student_list = [ Student(i['name'],i['age'],i['sex'],i['tel']) for i in new_list]
        finally:
            f.close()

