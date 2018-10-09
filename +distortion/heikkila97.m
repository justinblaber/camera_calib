function sym_p_n2p_n_d = heikkila97()
    % This is the distortion model in heikkila97. Note that the function 
    % must have arguments which start with:
    %
    %   x_n, y_n
    %
    % in that order, and then are followed by distortion parameters.
    %
    % Inputs:
    %   None
    %
    % Outputs:    
    %   sym_p_n2p_n_d - symbolic function; describes mapping between 
    %       normalized coordinates and distorted normalized coordinates.
    
    % Declare symbolic function
    syms sym_p_n2p_n_d(x_n,y_n,k1,k2,p1,p2)
    
    % Radial distortion
    x_n_r = x_n.*(1 + k1.*(x_n.^2 + y_n.^2) + k2.*(x_n.^2+y_n.^2).^2);
    y_n_r = y_n.*(1 + k1.*(x_n.^2 + y_n.^2) + k2.*(x_n.^2+y_n.^2).^2);
    
    % Distorted normalized points
    x_n_d = x_n_r + 2*p1*x_n.*y_n + p2*(3*x_n.^2 + y_n.^2);
    y_n_d = y_n_r + p1*(x_n.^2 + 3*y_n.^2) + 2*p2*x_n.*y_n;
    
    % Define symbolic function
    sym_p_n2p_n_d(x_n,y_n,k1,k2,p1,p2) = [x_n_d, y_n_d];    
end