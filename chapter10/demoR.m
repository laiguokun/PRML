beta = 10;
n = 30;
[X, Y] = getRdata(n, beta);
plot(X,Y, '.','MarkerFaceColor', 'g');
hold on;

Phi = [ones(1,n)];
for i = 1:3
   Phi = [Phi; X'.^i];
end;
W = VLR(Phi,Y);
x = 0:0.01:2*pi;
n = size(x,2);
Phi = [ones(1,n)];
for j = 1:3
    Phi = [Phi; x.^j];
end
y = W' * Phi;
plot(x,y,'r');
        