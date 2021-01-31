from math import log
import cProfile


def func2(k):
    if k > 2 and k < 911:
        j = round(k * log(k)) + k
    else:
        j = round(k ** 1.01 * log(k)) + k + 2

    def func():
        my_list = [i for i in range(2, j)]
        for num in my_list:
            if num != 0:
                for i in range(num * 2, j, num):
                    my_list[i - 2] = 0
        lst = [i for i in my_list if i != 0]

        print(lst)

        return lst

    return func()[k - 1]


# print(func2(300))
# cProfile.run('func2(10000)')
# 1    0.001    0.001    0.093    0.093 task_2.py:5(func2)

# cProfile.run('func2(100000)')
# 1    0.015    0.015    1.202    1.202 task_2.py:5(func2)

cProfile.run('func2(1000000)')
# 1    0.149    0.149   14.846   14.846 task_2.py:5(func2)
