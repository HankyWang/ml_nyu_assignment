function centrefig
s = get(0,'ScreenSize');
f = get(gcf,'position');
f(1) = (s(3)-f(3))/2;
f(2) = (s(4)-(f(4)+20))/2;
set(gcf,'Position',f)