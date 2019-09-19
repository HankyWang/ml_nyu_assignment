import numpy as np
import matplotlib.pyplot as plt
from numpy.linalg import inv, pinv, norm
from scipy.io import loadmat

def polyreg(x_train, y_train, lamb, x_test, y_test):
    xTx        = x_train.T.dot(x_train) + lamb * np.identity(x_train.shape[-1])
    theta      = inv(xTx).dot(x_train.T).dot(y_train)
    # train_err  = (0.5/x_train.shape[0]) * np.sum(np.power(y_train-x_train.dot(theta),2))
    # test_err   = (0.5/x_test.shape[0])  * np.sum(np.power(y_test-x_test.dot(theta),2))
    norm_theta = norm(theta)
    train_err  = (0.5/x_train.shape[0]) * (np.sum(np.power(y_train-x_train.dot(theta),2))+  lamb * norm_theta * norm_theta)
    test_err   = (0.5/x_test.shape[0])  * (np.sum(np.power(y_test-x_test.dot(theta),2))  +  lamb * norm_theta * norm_theta)
    return train_err, test_err


if __name__=="__main__":
    matdata = loadmat('problem2.mat')
    x = matdata['x']
    y = matdata['y']
    indices = np.random.permutation(x.shape[0])
    test_size = int(x.shape[0]*0.6)
    train_indices, test_indices = indices[:test_size], indices[test_size:]
    x_train, x_test = x[train_indices], x[test_indices]
    y_train, y_test = y[train_indices], y[test_indices]
    errs = [polyreg(x_train, y_train, i, x_test, y_test) for i in range(1000)]
    train_errs = [err[0] for err in errs]
    test_errs  = [err[1] for err in errs]
    min_ind = np.argmin(test_errs)
    plt.figure(0)
    ltrain, = plt.plot(range(1000), train_errs,'-b', label='train')
    ltest , = plt.plot(range(1000), test_errs,'-r',  label='test')
    plt.plot(min_ind, test_errs[min_ind], 'xr')
    plt.text(min_ind, test_errs[min_ind], "({},{})".format(str(min_ind), '%.2f'%test_errs[min_ind]))
    plt.xlabel('lambda'); plt.ylabel('error')
    plt.legend(handles=[ltrain, ltest])
    plt.show()
    