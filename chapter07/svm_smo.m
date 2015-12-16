function [alpha, b] = svm_smo(X, Y, n, C)
    alpha = zeros(1,n);
    b = 0;
    numChanged = 0;
    examineAll = 1;
    while (numChanged > 0 || examineAll == 1)
        numChanged = 0;
        if (examineAll == 1)
            for i = 1 : n
                [r, alpha, b] = examineExample(i, X, Y, n, C, alpha, b);
                numChanged = numChanged + r;
            end;
            examineAll = 0;
        else
            for i = 1 : n
                if (alpha(i) > 0 && alpha(i) < (C))
                    [r, alpha, b] = examineExample(i, X, Y, n, C, alpha, b);
                    numChanged = numChanged + r;
                end
            end
            examineAll = 1;
        end
    end
    
        
    
