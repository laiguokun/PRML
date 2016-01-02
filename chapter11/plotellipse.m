function [x,y] = plotellipse(U,S)
    [eigenvec, eigenval] = eig(S);
    if (eigenval(1)>eigenval(2))
        leigenval = eigenval(1,1);
        leigenvec = eigenvec(:,1);
        seigenval = eigenval(2,2);
    else
        leigenval = eigenval(2,2);
        leigenvec = eigenvec(:,2);
        seigenval = eigenval(1,1);
    end
    angle = atan2(leigenvec(2),leigenvec(1));
    if (angle <0)
        angle = angle + 2*pi;
    end
    chisquare_val = 2.4477;
    theta_grid = linspace(0,2*pi);
    phi = angle;
    X0 = U(1,1);
    Y0 = U(2,1);
    a=chisquare_val*sqrt(leigenval);
    b=chisquare_val*sqrt(seigenval);
    ellipse_x_r  = a*cos( theta_grid );
    ellipse_y_r  = b*sin( theta_grid );
    
    R = [ cos(phi) sin(phi); -sin(phi) cos(phi) ];

    r_ellipse = [ellipse_x_r;ellipse_y_r]' * R;
    
    x = r_ellipse(:,1)+X0;
    y = r_ellipse(:,2)+Y0;
    
