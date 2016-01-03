clear all;
close all;
k = 3;
d = 2;
u = rand(k,d)*10;
s = zeros(d,d,k);
for i = 1:k
    s(:,:,i) = 0.1 * eye(d);
end
a = ones(k)/k;
a = rand(k,k);
for i = 1:k
    a(i,:) = a(i,:)/norm(a(i,:),1);
end
disp(a);
p = ones(k,1)/k;
n = 100;
[x] = HMMsample(u,s,a,p,n);

[U] = kmean(x,k);
U = U';
plot(x(1,:),x(2,:),'o');
[U,S,P,A] = HMM(x,k,U);
disp(A);