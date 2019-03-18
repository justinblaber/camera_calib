function test_write_single_calib()
    % Get temporary file
    temp_path = tempname;

    calib.intrin.A = eye(3);
    calib.intrin.d = ones(3, 1);

    calib.extrin.img_cb = class.img.base('test');
    calib.extrin.R = eye(3);
    calib.extrin.t = ones(3, 1);
    calib.extrin.p_fp_p_ds = ones(4, 2);
    calib.extrin.p_cb_p_ds = ones(1, 2);
    calib.extrin.cov_cb_p_ds = {eye(2, 2)};
    calib.extrin.p_cb_p_d_ms = ones(1, 2);
    calib.extrin.idx_valid = ones(1, 1);

    util.write_single_calib(calib, temp_path);

    % Check file contents
    assert(strcmp(fileread(temp_path), ['% Intrinsics' newline, ...
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
