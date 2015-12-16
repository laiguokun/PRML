function [res,alpha,b] = examineExample(i2, X, Y, n, C, alpha, b)

    y2 = Y(i2,1);
    alpha2 = alpha(i2);
    E2 = svmout(alpha, b, X, Y, n, i2) - y2;
    r2 = E2 * y2;
    eps = 1e-6;
    res = 0;
 %   disp([r2,i2]);
    if ((r2 < 1 && alpha2 < C) || (r2 > 1 && alpha2 > 0))
        count = 0;
        Emax = -100000;
        Emin = 100000;
        imax = 0;
        imin = 0;
        for i = 1:n
            if (alpha(i) < C || alpha(i) > 0)
                count = count + 1;
                E = svmout(alpha, b, X, Y, n, i) - Y(i,1);
                if (E>Emax)
                    Emax = E;
                    imax = i;
                end;
                if (E<Emin)
                    Emin = E;
                    imin = i;
                end;
            end
        end
        if (count > 1)
            if (E2 > 0)
                i1 = imin;
            else
                i1 = imax;
            end
            [res, alpha, b] = takeStep(i1, i2, alpha, b, X, Y, n, C);
            if (res == 1)
                return;
            end
        end
        for i = randperm(n)
            if (alpha(i) < C || alpha(i) > 0)
                i1 = i;
                [res, alpha, b] = takeStep(i1, i2, alpha, b, X, Y, n, C);
                if (res == 1)
                    return;
                end
            end
        end
        for i = randperm(n)
            [res,alpha, b] = takeStep(i, i2, alpha, b, X, Y, n, C);
            if (res == 1)
                return;
            end
        end
    end
                
        