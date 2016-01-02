function [u] = kmean(X, Y, k)

    distance = @(xn, xm) norm(xn-xm);
    n = size(X,2);
    d = size(X,1);
    u = rand(d,k);
    for iter = 1:10
        r = zeros(n,k);
        for i = 1:n
            idmin = 0;
            dist = 100;
            for j = 1:k
                dis = distance(X(:,i),u(:,j));
                if (dis < dist)
                    dist = dis;
                    idmin = j;
                end
            end
            r(i,idmin) = 1;
        end;
        for i = 1:k
            for j = 1:d
                u(j,i) = sum(r(:,i)'.*X(j,:))/sum(r(:,i));
            end
        end
    end
                
            