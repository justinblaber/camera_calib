function save_stereo_calib_fp(calib, calib_config, file_path)
    % Saves a stereo four point calibration to file.
    %
    % Inputs:
    %   calib - struct;
    %       .L - struct; calibration for left camera
    %       .R - struct; calibration for right camera
    %       .R_s - array; 3x3 rotation matrix describing rotation from
    %           left to right camera
    %       .t_s - array; 3x1 translation vector describing translation
    %           from left to right camera
    %   calib_config - struct; struct returned by util.read_calib_config()
    %   file_path - string; path to calibration
    %
    % Outputs:
    %   None

    % This will clear the file
    fclose(fopen(file_path, 'w'));

    % Write calib_config
    util.write_comment('Calibration configuration', file_path);
    util.write_data(calib_config, file_path);
    util.write_newline(file_path);
    
    % Write left
    util.write_single_calib_fp(calib.L, file_path, '_L');

    % Write right
    util.write_single_calib_fp(calib.R, file_path, '_R');

    % Write R_s and t_s
    util.write_array(calib.R_s, 'R_s', file_path);
    util.write_newline(file_path);
    util.write_array(calib.t_s, 't_s', file_path);
    util.write_newline(file_path);
end