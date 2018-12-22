function test_save_stereo_calib_fp()
    % Get temporary file
    temp_path = tempname;

    calib_config.target_type = 'checker';
    calib_config.num_targets_height = 1;
    calib_config.num_targets_width = 1;
    calib_config.target_spacing = 1;
        
    calib.L.intrin.A = eye(3);
    calib.L.intrin.d = ones(3,1);
    
    calib.L.extrin.img_path = 'test';
    calib.L.extrin.R = eye(3);
    calib.L.extrin.t = ones(3,1);
    calib.L.extrin.p_fp_p_ds = ones(4,2);
    calib.L.extrin.p_cb_p_ds = ones(1,2);
    calib.L.extrin.cov_cb_p_ds = {eye(2,2)};
    calib.L.extrin.idx_valid = ones(1,1);    
    
    calib.R.intrin.A = eye(3);
    calib.R.intrin.d = ones(3,1);
    
    calib.R.extrin.img_path = 'test';
    calib.R.extrin.R = eye(3);
    calib.R.extrin.t = ones(3,1);
    calib.R.extrin.p_fp_p_ds = ones(4,2);
    calib.R.extrin.p_cb_p_ds = ones(1,2);
    calib.R.extrin.cov_cb_p_ds = {eye(2,2)};
    calib.R.extrin.idx_valid = ones(1,1);  
    
    calib.R_s = eye(3);
    calib.t_s = ones(3,1);
    
    util.save_stereo_calib_fp(calib, calib_config, temp_path);

    % Check file contents
    assert(strcmp(fileread(temp_path),['% Calibration configuration' newline, ...                                                             
                                       'target_type = checker' newline, ...                                                                           
                                       'num_targets_height = 1' newline, ...                                                                          
                                       'num_targets_width = 1' newline, ...                                                                           
                                       'target_spacing = 1' newline newline, ...  
                                       '% Intrinsics_L' newline, ...
                                       'A_L = ' newline, ...
                                       '1 0 0' newline, ...
                                       '0 1 0' newline, ...
                                       '0 0 1' newline newline, ...
                                       'd_L = ' newline, ...
                                       '1' newline, ...
                                       '1' newline, ...
                                       '1' newline newline, ...
                                       '% Extrinsics_1_L' newline, ...
                                       'img_path_1_L = test' newline newline, ...
                                       'R_1_L = ' newline, ...
                                       '1 0 0' newline, ...
                                       '0 1 0' newline, ...
                                       '0 0 1' newline newline, ...
                                       't_1_L = ' newline, ...
                                       '1' newline, ...
                                       '1' newline, ...
                                       '1' newline newline, ...
                                       'p_fp_p_ds_1_L = ' newline, ...
                                       '1 1' newline, ...
                                       '1 1' newline, ...
                                       '1 1' newline, ...
                                       '1 1' newline newline, ...
                                       'p_cb_p_ds_1_L = ' newline, ...
                                       '1 1' newline newline, ...
                                       'cov_cb_p_ds_1_L = ' newline, ...
                                       '1 0' newline, ...
                                       '0 1' newline newline, ...
                                       'idx_valid_1_L = ' newline, ...
                                       '1' newline newline, ...
                                       '% Intrinsics_R' newline, ...
                                       'A_R = ' newline, ...
                                       '1 0 0' newline, ...
                                       '0 1 0' newline, ...
                                       '0 0 1' newline newline, ...
                                       'd_R = ' newline, ...
                                       '1' newline, ...
                                       '1' newline, ...
                                       '1' newline newline, ...
                                       '% Extrinsics_1_R' newline, ...
                                       'img_path_1_R = test' newline newline, ...
                                       'R_1_R = ' newline, ...
                                       '1 0 0' newline, ...
                                       '0 1 0' newline, ...
                                       '0 0 1' newline newline, ...
                                       't_1_R = ' newline, ...
                                       '1' newline, ...
                                       '1' newline, ...
                                       '1' newline newline, ...
                                       'p_fp_p_ds_1_R = ' newline, ...
                                       '1 1' newline, ...
                                       '1 1' newline, ...
                                       '1 1' newline, ...
                                       '1 1' newline newline, ...
                                       'p_cb_p_ds_1_R = ' newline, ...
                                       '1 1' newline newline, ...
                                       'cov_cb_p_ds_1_R = ' newline, ...
                                       '1 0' newline, ...
                                       '0 1' newline newline, ...
                                       'idx_valid_1_R = ' newline, ...
                                       '1' newline newline, ...
                                       'R_s = ' newline, ...
                                       '1 0 0', newline, ...
                                       '0 1 0', newline, ...
                                       '0 0 1', newline, newline, ...
                                       't_s = ', newline, ...
                                       '1', newline, ...
                                       '1', newline, ...
                                       '1', newline, newline]));

    % Remove temporary file
    delete(temp_path);
end