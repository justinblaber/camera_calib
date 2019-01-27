function test_save_single_calib_fp()
    % Get temporary file
    temp_path = tempname;

    calib.config.target_type = 'checker';
    calib.config.num_targets_height = 1;
    calib.config.num_targets_width = 1;
    calib.config.target_spacing = 1;

    calib.intrin.A = eye(3);
    calib.intrin.d = ones(3, 1);

    calib.extrin.img_cb = class.img('test');
    calib.extrin.R = eye(3);
    calib.extrin.t = ones(3, 1);
    calib.extrin.p_fp_p_ds = ones(4, 2);
    calib.extrin.p_cb_p_ds = ones(1, 2);
    calib.extrin.cov_cb_p_ds = {eye(2, 2)};
    calib.extrin.p_cb_p_d_ms = ones(1, 2);
    calib.extrin.idx_valid = ones(1, 1);

    util.save_single_calib_fp(calib, temp_path);

    % Check file contents
    assert(strcmp(fileread(temp_path), ['% Calibration configuration' newline, ...
                                        'target_type = checker' newline, ...
                                        'num_targets_height = 1' newline, ...
                                        'num_targets_width = 1' newline, ...
                                        'target_spacing = 1' newline newline, ...
                                        '% Intrinsics' newline, ...
                                        'A = ' newline, ...
                                        '1 0 0' newline, ...
                                        '0 1 0' newline, ...
                                        '0 0 1' newline newline, ...
                                        'd = ' newline, ...
                                        '1' newline, ...
                                        '1' newline, ...
                                        '1' newline newline, ...
                                        '% Extrinsics_1' newline, ...
                                        'img_path_1 = test' newline newline, ...
                                        'R_1 = ' newline, ...
                                        '1 0 0' newline, ...
                                        '0 1 0' newline, ...
                                        '0 0 1' newline newline, ...
                                        't_1 = ' newline, ...
                                        '1' newline, ...
                                        '1' newline, ...
                                        '1' newline newline, ...
                                        'p_fp_p_ds_1 = ' newline, ...
                                        '1 1' newline, ...
                                        '1 1' newline, ...
                                        '1 1' newline, ...
                                        '1 1' newline newline, ...
                                        'p_cb_p_ds_1 = ' newline, ...
                                        '1 1' newline newline, ...
                                        'cov_cb_p_ds_1 = ' newline, ...
                                        '1 0' newline, ...
                                        '0 1' newline newline, ...
                                        'p_cb_p_d_ms_1 = ' newline, ...
                                        '1 1' newline newline, ...
                                        'idx_valid_1 = ' newline, ...
                                        '1' newline newline]));

    % Remove temporary file
    delete(temp_path);
end
