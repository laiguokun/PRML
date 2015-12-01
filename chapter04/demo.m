clear all;
close all;
n1=30;
n2=30;
d=2;
[X, Y] = getdata(n1, n2, d);
plot(X(1,1:n1),X(2,1:n1),'o','MarkerFaceColor','g');
hold on;
plot(X(1,n1+1:n1+n2), X(2,n1+1:n1+n2),'o','MarkerFaceColor','b');
hold on;

x = 0:0.01:1;
l = size(x,2);

% %LSC
% [W] = LSC(X, Y, n1+n2, d);
% x = 0:0.01:1;
% y = (-W(1)-W(2).*x)./(W(3));
% plot(x,y,'m');
% 
% %FLD
% [W] = FLD(X, Y, n1+n2, d);
% x = 0:0.01:1;
% y = (-W(1)-W(2).*x)./(W(3));
% plot(x,y,'y');
% 
% %PGM
% [u1,u2,S] = PGM(X, Y, n1+n2, d);
% [x,y] = plotellipse(u1,S);
% plot(x,y,'b');
% hold on;
% [x,y] = plotellipse(u2,S);
% plot(x,y,'b');
% 
%PDM
% [W] = PDM(X, Y, n1+n2, d);
% x = 0:0.01:1;
% y = (-W(1)-W(2).*x)./(W(3));
% plot(x,y, 'r');
%BLR
[W, S] = BLR(X, Y, n1+n2, d);
ezplot(@(x,y)myfun(x,y,S(1,1),S(1,2),S(1,3),S(2,1),S(2,2),S(2,3),S(3,1),S(3,2),S(3,3),W(1,1),W(2,1),W(3,1)),[0,1])