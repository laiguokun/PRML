function [U, S] = Gibbs(u, s, d)
%gibss sampling for the N(X|u,s)
    Z = zeros(d,1);
    head = 1;
    tail = 5;
    A = s ^ -1;
    sample = [];
    disp(A);
    for iter = 1:tail
        for i = 1:d 
            Atmp = A(:, [i, 1:i-1, i+1:d]);
            Atmp = Atmp([i, 1:i-1, i+1:d],:);
            Ua = u(i,1);
            Ub = u([1:i-1,i+1:d], 1);
            Xb = Z([1:i-1,i+1:d], 1);
            Aaa = Atmp(1,1);
            Aab = A(1, [2:d]);
            Uab = Ua - Aaa ^ -1 * Aab * (Xb - Ub);
            ok = true;
            while (ok)
                z1 = rand() * 2 - 1;
                z2 = rand() * 2 - 1;
                r2 = z1^2 + z2^2;
                if (r2 > 1)
                    continue;
                end;
                y1 = z1 * (-2 * log(r2)/ r2) ^ 0.5;
                Z(i,1) = Aaa^-1 * y1 + Uab;
                break;
            end
            if (iter > head)
                sample = [sample; Z'];
            end
        end;
    end;
    U = mean(sample);
    S = cov(sample);
    