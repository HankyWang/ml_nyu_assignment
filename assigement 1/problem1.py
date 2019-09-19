import numpy as np
import matplotlib.pyplot as plt
from numpy.linalg import inv, pinv
from scipy.io import loadmat

def polyreg(x_train, y_train, Dim, x_test, y_test):
    Dim_pow = np.array(range(Dim+1))
    X_train = np.power(x_train, Dim_pow)
    # print(X_train.shape)
    # for i in range(Dim):
    model = np.linalg.pinv(X_train).dot(y_train)
    # model = inv(X_train.T.dot(X_train)).dot(X_train.T).dot(y_train)
    # print(model.shape)
    train_err = (0.5/X_train.shape[0])*np.sum(np.power(y_train-X_train.dot(model),2))
    X_test = np.power(x_test, Dim_pow)
    if Dim in (1,2,3,5,10,20):
        # print(model[0,:])
        plt.figure(Dim)
        plt.plot(x_train, y_train, 'r.', label='training data')
        plt.plot(x_test, y_test, 'g.', label='testing data')
        plt.plot(x_train, X_train.dot(model), 'b.')
        plt.title('d='+str(Dim))
        plt.legend()
        plt.show()
    test_err = (0.5/X_test.shape[0])*np.sum(np.power(y_test-X_test.dot(model),2))
    return train_err, test_err


if __name__=="__main__":
    matdata = loadmat('problem1.mat')
    x = matdata['x']
    y = matdata['y']
    indices = np.random.permutation(x.shape[0])
    test_size = int(x.shape[0]*0.6)
    train_indices, test_indices = indices[:test_size], indices[test_size:]
    x_train, x_test = x[train_indices], x[test_indices]
    y_train, y_test = y[train_indices], y[test_indices]
    max_dim = 100
    errs = [polyreg(x_train, y_train, i, x_test, y_test) for i in range(1,max_dim)]
    train_errs = [err[0] for err in errs]
    test_errs  = [err[1] for err in errs]
    min_ind = np.argmin(test_errs)
    plt.figure(0)
    ltrain, = plt.plot(range(1,max_dim), train_errs,'b',label='train')
    ltest,  = plt.plot(range(1,max_dim), test_errs, 'r',label='test')
    plt.plot(min_ind, test_errs[min_ind], 'xr')
    plt.text(min_ind, test_errs[min_ind], "(dim={})".format(str(min_ind)))
    plt.xlabel('Dimension'); plt.ylabel('Error')
    plt.title('Cross-validation')
    plt.legend(handles=[ltrain, ltest])
    plt.show()
    