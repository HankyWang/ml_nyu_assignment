from sklearn import svm
import numpy as np
import matplotlib.pyplot as plt
from scipy.io import loadmat 

if __name__=='__main__':
    data = loadmat('shoesducks.mat')
    x = data['X']
    y = data['Y']
    y = y.reshape([-1,])
    # print(X.shape, Y.shape)
    indices = np.random.permutation(x.shape[0])
    test_size = int(x.shape[0]*0.5)
    train_indices, test_indices = indices[:test_size], indices[test_size:]
    x_train, x_test = x[train_indices], x[test_indices]
    y_train, y_test = y[train_indices], y[test_indices]
    model = svm.SVC(C=0.01, kernel='rbf',gamma=1)
    model.fit(x_train,y_train)
    print(model.score(x_test, y_test))