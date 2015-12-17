close all;
clear all;
beta = 10;
n = 30;
[X, Y] = getRdata(n, beta);
plot(X,Y, '.','MarkerFaceColor', 'g');
hold on;

x = 0:0.01:2*pi;
l = size(x,2);
kernel = @(xn,xm) exp(-abs(xn-xm)^2);
    
[Mn, Sn, alphablr, betablr] =  RVM(X, Y, n); 
for i = 1:n
    if (1/alphablr(i) > 1e-3)
        plot(X(i),Y(i), 'o','MarkerFaceColor', 'y');
        hold on;        
    end
end

y = [];
for i = 1:l
    tmp = 0;
    for j = 1:n
        tmp = tmp + Mn(j) * kernel(x(i), X(j));
    end
    y = [y,tmp];
end
plot(x,y,'r');

    


