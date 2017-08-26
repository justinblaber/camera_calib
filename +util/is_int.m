function success = is_int(num)
    % Determines if input is a real, finite, and integer number.
    % 
    % Inputs:
    %   num - scalar; 
    %
    % Outputs:
    %   success - logical;
    success = util.is_num(num) && round(num) == num;
end