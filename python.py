import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
def SVM():
    x, y = ([(1, 2), (2, 3), (3, 3), (2, 1), (3, 2)], [1, 1, 1, -1, -1])
    model = SVC(kernel="linear", C=1e9)
    x = np.array(x)
    model.fit(x, y)

    # precise = model.score(x_test, y_test)
    # print(precise)
    # 画出散点图
    plt.scatter(x[:3, 0], x[:3, 1], label='1')
    plt.scatter(x[3:5, 0], x[3:5, 1], label='-1')
    # 查看权重矩阵
    weight = model.coef_[0]
    print(model.coef_)
    # 取出截距
    bias = model.intercept_[0]
    k = -weight[0] / weight[1]
    b = -bias / weight[1]
    print(k, b, weight[0], weight[1], bias)
    # 获取支持向量
    support_vector = model.support_vectors_
    # 画出支持向量
    for i in support_vector:
        plt.scatter(i[0], i[1], marker=',', c='black')

    # 画出超平面
    xx = np.linspace(0, 8, 10)
    yy = k * xx + b
    plt.plot(xx, yy)
    # 画出上下margin
    margin = 1 / np.sqrt(np.sum(model.coef_ ** 2))
    yy_up = yy + np.sqrt(1+k**2) * margin
    yy_down = yy - np.sqrt(1+k**2) * margin
    plt.plot(xx, yy_up)
    plt.plot(xx, yy_down)
    plt.legend()
    plt.show()


if __name__ == '__main__':
    SVM()