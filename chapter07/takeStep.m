function [res, alpha, b] = takeStep(i1, i2, alpha, b, X, Y, n, C)
    kernel = @(xn,xm) xn'*xm;
    res = 0;
    if (i1 == i2) 
        return;
    end;
    alpha1 = alpha(i1);
    alpha2 = alpha(i2);
    y1 = Y(i1);
    y2 = Y(i2);
    E1 = svmout(alpha, b, X, Y, n, i1) - y1;
    E2 = svmout(alpha, b, X, Y, n, i2) - y2;
    s = y1 * y2;
    L = 0;H = 0;
    eps = 1e-6;
    if (s == -1)
        L = max([0, alpha2 - alpha1]);
        H = min([C, C + alpha2 - alpha1]);
    else
        L = max([0, alpha1 + alpha2 - C]);
        H = min([C, alpha1 + alpha2]);
    end;
    if (L == H)
        return;
    end;
    k11 = kernel(X(:,i1), X(:,i1));
    k12 = kernel(X(:,i1), X(:,i2));
    k22 = kernel(X(:,i2), X(:,i2));
    eta = 2*k12-k11-k22;
%    disp(eta);
    if (eta < 0)
        a2 = alpha2 - y2 * (E1-E2)/eta;
%        disp(a2);
        if (a2 < L)
            a2 = L;
        end;
        if (a2 > H)
            a2 = H;
        end;
    else
        Lobj = L;
        Hobj = H;
        for i = 1:n
            if (i == i2)
                Lobj = Lobj - 0.5 * L * L * kernel(X(:,i), X(:,i2));
                Hobj = Hobj - 0.5 * H * H * kernel(X(:,i), X(:,i2));
            else
                Lobj = Lobj - L * alpha(i) * Y(i) * Y(i2) * kernel(X(:,i), X(:,i2));
                Hobj = Hobj - H * alpha(i) * Y(i) * Y(i2) * kernel(X(:,i), X(:,i2));
            end
        end
        a2 = alpha2;
        if (Lobj > Hobj + eps)
            a2 = L;
        end
        if (Lobj < Hobj - eps)
            a2 = H;
        end
    end;
    if (a2 < eps) 
        a2 = 0;
    end
    if (a2 > C - eps)
        a2 = C;
    end
    if (abs(a2 - alpha2) < eps * (a2 + alpha2 + eps))
        return;
    end;
    a1 = alpha1 + s *(alpha2 - a2);
    if (a1 < eps) 
        a1 = 0;
    end
    if (a1 > C - eps)
        a1 = C;
    end
 %   disp([i1,i2,a1,a2]);
    alpha(i1) = a1;
    alpha(i2) = a2;
 %   disp(alpha);
    AS = [];
    for i = 1:n 
        if (alpha(i) > 0 && alpha(i) < C)
            AS = [AS, i];
        end;
    end;
    S = size(AS,2);
    if (S~=0)
        b = 0;
     %   disp(AS);
        for i = 1:S
            b = b + Y(AS(i));
            for j = 1:S
                b = b - alpha(AS(j)) * Y(AS(j)) * kernel(X(:, AS(i)), X(:, AS(j)));
            end
        end
        b = b/S;
    end;
    res = 1;
 %   disp(b);
            
    