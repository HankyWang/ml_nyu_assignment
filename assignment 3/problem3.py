import numpy as np
import matplotlib.pyplot as plt
from numpy.linalg import eig
from scipy.io import loadmat

if __name__=='__main__':
    data = loadmat('teapots.mat')
    X = data['teapotImages']
    u = np.mean(X, axis=0).reshape(1,1900)
    x = X - np.repeat(u,100,axis=0)
    C = x.T.dot(x)/(x.shape[0]-1)
    D, V = eig(C)
    print(x.shape)
    print(C)
    print(D[:3])
    print(V[:,:3])
    