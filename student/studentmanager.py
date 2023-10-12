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
class StudentManager:
    def __init__(self):
        self.student_list = []
    def run(self):
        print('请选择如下功能：')
        print('1:添加学员')
        print('2:删除学员')
        print('3:修改学员信息')
        print('4:查询学员信息')
        print('5:显示所有学员信息')
        print('6:保存学员信息')
        print('7:退出系统')
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
                break
    def add_student(self):
        print('添加')
    def delete_student(self):
        pass
    def update_student(self):
        pass
    def select_single_student(self):
        pass
    def select_all_student(self):
        pass
    def save_studen(self):
        pass
    def exit_manager(self):
        pass

