function [U, S] = MH(u, s)
%MEtropolis-Hastings algorithm for N(x|u,s)
    head = 1000;
    tail = 10000;
    z = 0;
    sample = [];
    for iter = head:tail
        ok = true;
        zz = z;
        while (ok) 
            z1 = rand() * 2 - 1;
            z2 = rand() * 2 - 1;
            r2 = z1^2 + z2^2;
            if (r2 > 1)
                continue;
            end;
            y1 = z1 * (-2 * log(r2)/ r2) ^ 0.5;
            zz = zz + y1*2;
            break;
        end
        A = min([1, normpdf(zz, u, s)/normpdf(z, u, s)]);
        t = rand();
        if (t < A)
            z = zz;
        end
        if (iter > head)
            sample = [sample, z];
        end
    end
    U = mean(sample);
    S = var(sample)^0.5;
    disp(size(sample))