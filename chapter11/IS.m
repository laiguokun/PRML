function [E] = IS(u, s)
%important sampling to get the exceptation of N(x|u,s)
    L = 200;
    E = 0;
    sample = [];
    z1 = rand(L,1)*2 - 1;
    z2 = rand(L,1)*2 - 1;
    for i = 1 : L
        r2 = z1(i)^2 + z2(i)^2;
        if (r2 > 1)
            continue;
        end;
        y1 = z1(i) * (-2 * log(r2)/ r2) ^ 0.5;
        y2 = z2(i) * (-2 * log(r2)/ r2) ^ 0.5;
        sample = [sample, y1];
    end;
    
    sample = sample * 2;
    
    L = size(sample, 2);
    Sr = 0;
    for i = 1 : L
        zi = sample(i);
        Sr = Sr + (normpdf(zi, u, s) / normpdf(zi, 0, 2));
    end;
    
    for i = 1 : L
        zi = sample(i);
        E = E + zi * (normpdf(zi, u, s) / normpdf(zi, 0, 2)) / Sr;
    end
    