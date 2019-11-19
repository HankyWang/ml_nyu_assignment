import matplotlib.pyplot as plt

C = ['C=1','C=0.1','C=0.01','C=0.001']
acc = [1,1,1,30/72]
margin = [2.752715,2.725277,4.058592,16.539482]
nsv = [14,15,34,63]

plt.figure(0)
plt.subplots_adjust(wspace =0.5, hspace =0)
plt.subplot(1,3,1)
plt.bar(C,acc)
plt.ylabel('Accuracy(%)')
plt.title('C-value/Accuracy')
plt.subplot(1,3,2)
plt.bar(C,margin)
plt.ylabel('Margin Value')
plt.title('C-value/Margin')
plt.subplot(1,3,3)
plt.bar(C,nsv)
plt.ylabel('# of support vectors')
plt.title('C-value/NSV')
plt.suptitle('Linear Kernel')
plt.show()

# order = 2 
C = ['C=1','C=0.1','C=0.01','C=0.001']
acc = [1,1,1,1]
margin = [52.580257,49.856740,49.875338,50.028620]
nsv = [16,16,19,26]

plt.figure(0)
plt.subplots_adjust(wspace =0.5, hspace =0)
plt.subplot(1,3,1)
plt.bar(C,acc)
plt.ylabel('Accuracy(%)')
plt.title('C-value/Accuracy')
plt.subplot(1,3,2)
plt.bar(C,margin)
plt.ylabel('Margin Value')
plt.title('C-value/Margin')
plt.subplot(1,3,3)
plt.bar(C,nsv)
plt.ylabel('# of support vectors')
plt.title('C-value/NSV')
plt.suptitle('Poly Kernel(Order=2)')
plt.show()

# order = 3 
C = ['C=1','C=0.1','C=0.01','C=0.001']
acc = [1,1,1,1]
margin = [786.786722,780.449902,845.457578,783.809176]
nsv = [1,12,36,51]

plt.figure(0)
plt.subplots_adjust(wspace =0.5, hspace =0)
plt.subplot(1,3,1)
plt.bar(C,acc)
plt.ylabel('Accuracy(%)')
plt.title('C-value/Accuracy')
plt.subplot(1,3,2)
plt.bar(C,margin)
plt.ylabel('Margin Value')
plt.title('C-value/Margin')
plt.subplot(1,3,3)
plt.bar(C,nsv)
plt.ylabel('# of support vectors')
plt.title('C-value/NSV')
plt.suptitle('Poly Kernel(Order=3)')
plt.show()

# rbf sigma = 1
C = ['C=1','C=0.1','C=0.01','C=0.001']
acc = [1,1,1,1]
margin = [0.333993,1.587053,15.744020,783.809176]
nsv = [71,72,72,51]

plt.figure(0)
plt.subplots_adjust(wspace =0.5, hspace =0)
plt.subplot(1,3,1)
plt.bar(C,acc)
plt.ylabel('Accuracy(%)')
plt.title('C-value/Accuracy')
plt.subplot(1,3,2)
plt.bar(C,margin)
plt.ylabel('Margin Value')
plt.title('C-value/Margin')
plt.subplot(1,3,3)
plt.bar(C,nsv)
plt.ylabel('# of support vectors')
plt.title('C-value/NSV')
plt.suptitle('Poly Kernel(Order=3)')
plt.show()
