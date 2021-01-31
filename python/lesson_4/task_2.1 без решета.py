import cProfile
from math import log


def func(n):
    b = round(n * log(n)) + n
    my_list = []
    k = 0
    for i in range(2, b+1):
        for j in range(2, i):
            if i % j == 0:
                k = k + 1
        if k == 0:
            my_list.append(i)
        else:
            k = 0
    print(my_list[n])
    return my_list

# print(func(50000))


cProfile.run('func(10000)')
# Ждать пожалуй я не буду, очень долго считает