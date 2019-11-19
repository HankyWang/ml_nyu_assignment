import numpy as np
import matplotlib.pyplot as plt
from scipy.io import loadmat 
from numpy import exp, log, absolute
from numpy.linalg import norm

def sign(y):
    y[y>=0]=1;y[y<0]=-1
    return y


def cal_risk(y, y_pred, N):
    assert(y.shape[-1]==1)
    risk = np.sum(sign(np.multiply(-y, y_pred)))
    return risk/N

def cal_error(y, y_pred, N):
    return float(np.count_nonzero(sign(y_pred)!=y))/N

def LR(x, y, opts):
    samples_num, features_num = x.shape
    max_iters  = opts['max_iters']
    lr         = opts['lr']
    weights    = np.random.random_sample((features_num, 1))
    error_list = []
    risk_list  = []
    iters      = 0

    while iters < max_iters:
        i = np.random.randint(samples_num)
        output = x[i].reshape((1,3)).dot(weights)
        # print(output, y[i])
        if sign(np.multiply(y[i],output))[0]==-1:
            weights += lr * x[i].reshape((3, 1)).dot(y[i].reshape((1,1)))
            y_pred = x.dot(weights)
            error_list.append(cal_error(y, y_pred, samples_num))
            risk_list.append(cal_risk(y, y_pred, samples_num))
            print(error_list[iters], iters)
            iters += 1
            if error_list[-1]==0:
                break

    
    return weights, iters, error_list, risk_list

def show_model(weights, x, y):
    plt.figure(0)
    samples_num = x.shape[0]
    for i in range(samples_num):
        plt.plot(x[i, 0], x[i, 1], 'r.')
    min_x = min(x[:, 0])
    max_x = max(x[:, 0])
    y_min_x = float(-weights[2] - weights[0] * min_x) / weights[1]
    y_max_x = float(-weights[2] - weights[0] * max_x) / weights[1]
    plt.plot([min_x, max_x], [y_min_x, y_max_x], '-b')
    plt.xlabel('X1'); plt.ylabel('X2')
    plt.show()

def show_err_trend(iters, error_list, risk_list):
    plt.figure(1)
    plt.plot(range(iters), error_list,'r-',label='Error')
    plt.plot(range(iters), risk_list, 'g-',label='Risk')
    plt.xlabel('iterations')
    plt.title('Error/Risk-Iteration')
    plt.legend()
    plt.show()

if __name__=="__main__":
    matdata = loadmat('data3.mat')
    _x = matdata['data'][:,:2]
    y  = matdata['data'][:,-1:]
    x  = np.concatenate((_x, np.ones((_x.shape[0],1))), axis=1)
    # print(x.shape)
    # print(y[0].shape, x[0].shape)
    max_iters = 5000
    opts  = {'max_iters': max_iters, 'lr': 1} 
    weights, iters, error_list, risk_list= LR(x, y, opts)
    # print(iters)
    show_model(weights, x, y)
    show_err_trend(iters, error_list, risk_list)

