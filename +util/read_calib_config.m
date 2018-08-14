function calib_config = read_calib_config(calib_config_path)
    % Reads the calibration config file given in calib_config_path and 
    % outputs a struct containing calibration related info.
    % 
    % Inputs:
    %   calib_config_path - path to calibration config file.
    %
    % Outputs:
    %   calib_config - struct containing the following fields:
    %
    % ------------------------------------------------------------------- %
    %
    %       Calibration board info:    
    %
    %       calibration_target - string; type of calibration target
    %       units - string; units of calibration board dimensions
    %
    %
    % ------------------------------------------------------------------- %
    %
    %       Algorithmic info:
    %
    %       refine_checker_it_cutoff - int; number of iterations performed 
    %           for refinement of checker target
    %       refine_checker_norm_cutoff - scalar; cutoff for the difference 
    %           in checker position for checker refinement
    %       refine_checker_default_window_factor - scalar; default relative
    %           size of checker refinement window compared to the size of 
    %           the calibration board target spacing.
    %       refine_checker_window_min_size - scalar; minimum length of 
    %           refinement window. This will recompute the window_factor to
    %           meet the minimum specified length.
    %
    %       refine_param_it_cutoff - int; number of iterations performed 
    %           for refinement of calibration parameters
    %       refine_param_norm_cutoff - scalar; cutoff for the difference in
    %           norm of calibration parameters
    %       refine_param_lambda_init - scalar; initial lambda for 
    %           Levenberg–Marquardt algorithm
    %       refine_param_lambda_factor - scalar; multiplicative factor for
    %           lambda in Levenberg–Marquardt algorithm
    %
    %       four_point_detect_scaled_array_min_size - int; rescales input 
    %           array such that the smallest dimension is set to this
    %           value (used to reduce computation time).
    %
    %       blob_detect_r_range1 - scalar; lower bound of blob radius 
    %           search; this is non-inclusive.
    %       blob_detect_r_range2 - scalar; upper bound of blob radius 
    %           search; this is non-inclusive.
    %       blob_detect_step - scalar; pixels between samplings of scale
    %           space
    %       blob_detect_num_cutoff - int; only processes this number of the
    %           strongest blob responses
    %       blob_detect_LoG_cutoff - scalar; only processes blobs with a
    %           LoG response higher than this value
    %       blob_detect_it_cutoff - int; number of iterations performed 
    %           for refinement of blob location/scale
    %       blob_detect_norm_cutoff - scalar; cutoff for the difference in
    %           norm of location/scale parameters
    %       blob_detect_eig_ratio_cutoff - scalar; cutoff for the ratio of 
    %           eigenvalues for the second moment matrix
    %       blob_detect_centroid_it_cutoff - int; number of iterations 
    %           performed for the centroid refinement
    %       blob_detect_centroid_norm_cutoff - scalar; cutoff for the 
    %           distance between centroid updates 
    %       blob_detect_M_it_cutoff - int; number of iterations performed 
    %           for the second moment matrix refinement
    %       blob_detect_d_cluster - scalar; cluster blobs within d distance
    %           away from each other
    %       blob_detect_r_cluster - scalar; cluster blobs within r radii
    %           away from each other
    %
    %       ellipse_detect_theta_num_samples - int; number of evenly 
    %           divided samples to use around ellipse.
    %       ellipse_detect_it_cutoff - int; cutoff for the number of 
    %           gradient ascent iterations
    %       ellipse_detect_norm_cutoff - scalar; cutoff for the difference
    %           in norm of ellipse parameters
    %       ellipse_detect_r1_cutoff - scalar; cutoff for major axis
    %       ellipse_detect_r2_cutoff - scalar; cutoff for minor axis
    %       ellipse_detect_num_cutoff - int; only processes this number of 
    %           the strongest ellipse responses
    %       ellipse_detect_d_cluster - scalar; cluster ellipses within d 
    %           distance away from each other
    %       ellipse_detect_r1_cluster - scalar; cluster ellipses within 
    %           r1 major axes away from each other
    %       ellipse_detect_r2_cluster - scalar; cluster ellipses within 
    %           r2 minor axes away from each other
    %       ellipse_detect_rot_cluster - scalar; cluster ellipses within 
    %           rot angle of each other
    % 
    %       frontal_refinement_num_targets_padding - int; number of targets
    %           worth of padding around frontal image.
    %       frontal_refinement_pix_per_target - int; number of pixel
    %           samples per target in frontal space.
    %
    %       marker_config_path - string; path to marker configuration
    %       marker_templates_path - string; path to marker_templates
    %       marker_padding - int; amount of padding used for radius samples
    %           to allow for "wiggle" room
    %
    % ------------------------------------------------------------------- %
    %
    %       Plotting info:
    %
    %       camera_size - scalar; size of camera in specified units; used
    %           for plotting extrinsic parameters.
    %    
    % ------------------------------------------------------------------- %

    % Check to make sure config file exists
    if exist(calib_config_path,'file') == 0
        error(['Config file: "' calib_config_path '" does not exist.']);
    end
    
    % Display contents of config file    
    disp('--------------------------------------------');
    disp('Calibration config file:');
    type(calib_config_path);
    disp(' ');
    
    % Load config file
    calib_config = util.read_data(calib_config_path);
    
    % Perform validations on input fields    
    % Calibration board info
    field_info        = struct('field','calibration_target'                     ,'required',true ,'default',''                             ,'validation_fun',@validate_calibration_target);
    field_info(end+1) = struct('field','num_targets_height'                     ,'required',true ,'default',''                             ,'validation_fun',@validate_pos_int);
    field_info(end+1) = struct('field','num_targets_width'                      ,'required',true ,'default',''                             ,'validation_fun',@validate_pos_int);
    field_info(end+1) = struct('field','target_spacing'                         ,'required',true ,'default',''                             ,'validation_fun',@validate_pos_num);
    field_info(end+1) = struct('field','units'                                  ,'required',true ,'default',''                             ,'validation_fun',@validate_string);
    field_info(end+1) = struct('field','four_point_height'                      ,'required',true ,'default',''                             ,'validation_fun',@validate_pos_num);
    field_info(end+1) = struct('field','four_point_width'                       ,'required',true ,'default',''                             ,'validation_fun',@validate_pos_num);
    % Algorithmic info
    field_info(end+1) = struct('field','homography_it_cutoff'                   ,'required',false,'default',20                             ,'validation_fun',@validate_pos_int);
    field_info(end+1) = struct('field','homography_norm_cutoff'                 ,'required',false,'default',1e-6                           ,'validation_fun',@validate_pos_num);
    field_info(end+1) = struct('field','refine_checker_it_cutoff'               ,'required',false,'default',10                             ,'validation_fun',@validate_pos_int);
    field_info(end+1) = struct('field','refine_checker_norm_cutoff'             ,'required',false,'default',0.05                           ,'validation_fun',@validate_pos_num);
    field_info(end+1) = struct('field','refine_checker_default_window_factor'   ,'required',false,'default',2/3                            ,'validation_fun',@validate_pos_num);
    field_info(end+1) = struct('field','refine_checker_window_min_size'         ,'required',false,'default',10                             ,'validation_fun',@validate_pos_num);
    field_info(end+1) = struct('field','refine_param_it_cutoff'                 ,'required',false,'default',200                            ,'validation_fun',@validate_pos_int);
    field_info(end+1) = struct('field','refine_param_norm_cutoff'               ,'required',false,'default',1e-6                           ,'validation_fun',@validate_pos_num);    
    field_info(end+1) = struct('field','refine_param_lambda_init'               ,'required',false,'default',0.01                           ,'validation_fun',@validate_pos_num);    
    field_info(end+1) = struct('field','refine_param_lambda_factor'             ,'required',false,'default',10                             ,'validation_fun',@validate_pos_num);    
    field_info(end+1) = struct('field','four_point_detect_scaled_array_min_size','required',false,'default',480                            ,'validation_fun',@validate_pos_int);    
    field_info(end+1) = struct('field','blob_detect_r_range1'                   ,'required',false,'default',0.5                            ,'validation_fun',@validate_pos_num);
    field_info(end+1) = struct('field','blob_detect_r_range2'                   ,'required',false,'default',realmax                        ,'validation_fun',@validate_pos_num);
    field_info(end+1) = struct('field','blob_detect_step'                       ,'required',false,'default',0.5                            ,'validation_fun',@validate_pos_num);
    field_info(end+1) = struct('field','blob_detect_num_cutoff'                 ,'required',false,'default',realmax                        ,'validation_fun',@validate_pos_int);   
    field_info(end+1) = struct('field','blob_detect_LoG_cutoff'                 ,'required',false,'default',0.05                           ,'validation_fun',@validate_pos_num);   
    field_info(end+1) = struct('field','blob_detect_it_cutoff'                  ,'required',false,'default',10                             ,'validation_fun',@validate_pos_int);
    field_info(end+1) = struct('field','blob_detect_norm_cutoff'                ,'required',false,'default',1e-6                           ,'validation_fun',@validate_pos_num);    
    field_info(end+1) = struct('field','blob_detect_eig_ratio_cutoff'           ,'required',false,'default',25                             ,'validation_fun',@validate_pos_num);    
    field_info(end+1) = struct('field','blob_detect_centroid_it_cutoff'         ,'required',false,'default',10                             ,'validation_fun',@validate_pos_int);    
    field_info(end+1) = struct('field','blob_detect_centroid_norm_cutoff'       ,'required',false,'default',0.1                            ,'validation_fun',@validate_pos_num);    
    field_info(end+1) = struct('field','blob_detect_M_it_cutoff'                ,'required',false,'default',5                              ,'validation_fun',@validate_pos_int);    
    field_info(end+1) = struct('field','blob_detect_d_cluster'                  ,'required',false,'default',1                              ,'validation_fun',@validate_pos_num);    
    field_info(end+1) = struct('field','blob_detect_r_cluster'                  ,'required',false,'default',1                              ,'validation_fun',@validate_pos_num);    
    field_info(end+1) = struct('field','ellipse_detect_theta_num_samples'       ,'required',false,'default',100                            ,'validation_fun',@validate_pos_int);   
    field_info(end+1) = struct('field','ellipse_detect_it_cutoff'               ,'required',false,'default',50                             ,'validation_fun',@validate_pos_int);   
    field_info(end+1) = struct('field','ellipse_detect_norm_cutoff'             ,'required',false,'default',1e-6                           ,'validation_fun',@validate_pos_num);          
    field_info(end+1) = struct('field','ellipse_detect_r1_cutoff'               ,'required',false,'default',1                              ,'validation_fun',@validate_pos_num);   
    field_info(end+1) = struct('field','ellipse_detect_r2_cutoff'               ,'required',false,'default',1                              ,'validation_fun',@validate_pos_num);   
    field_info(end+1) = struct('field','ellipse_detect_num_cutoff'              ,'required',false,'default',50                             ,'validation_fun',@validate_pos_int);    
    field_info(end+1) = struct('field','ellipse_detect_d_cluster'               ,'required',false,'default',1                              ,'validation_fun',@validate_pos_num);   
    field_info(end+1) = struct('field','ellipse_detect_r1_cluster'              ,'required',false,'default',1                              ,'validation_fun',@validate_pos_num);   
    field_info(end+1) = struct('field','ellipse_detect_r2_cluster'              ,'required',false,'default',1                              ,'validation_fun',@validate_pos_num);   
    field_info(end+1) = struct('field','ellipse_detect_rot_cluster'             ,'required',false,'default',2*pi/36                        ,'validation_fun',@validate_pos_num);   
    field_info(end+1) = struct('field','frontal_refinement_num_targets_padding' ,'required',false,'default',2                              ,'validation_fun',@validate_pos_int);   
    field_info(end+1) = struct('field','frontal_refinement_pix_per_target'      ,'required',false,'default',50                             ,'validation_fun',@validate_pos_int);   
    field_info(end+1) = struct('field','marker_config_path'                     ,'required',false,'default','+markers/marker.conf'         ,'validation_fun',@validate_file_path);
    field_info(end+1) = struct('field','marker_templates_path'                  ,'required',false,'default','+markers/marker_templates.txt','validation_fun',@validate_file_path);   
    field_info(end+1) = struct('field','marker_padding'                         ,'required',false,'default',5                              ,'validation_fun',@validate_pos_int);     
    % Plotting info
    field_info(end+1) = struct('field','camera_size'                            ,'required',false,'default',eps                            ,'validation_fun',@validate_pos_num);
    
    % Check to see if any unrecognized fields exist
    calib_config_fields = fields(calib_config);
    for i = 1:length(calib_config_fields)
        if ~any(strcmp(calib_config_fields{i},{field_info.field}))
            error(['Unrecognized field: "' calib_config_fields{i} '" ' ...
                   'in calibration config file.']);
        end        
    end
    
    % Validate all inputs
    for i = 1:length(field_info)
        % For optional fields that dont exist, set the default value
        if ~any(strcmp(field_info(i).field,calib_config_fields))            
            if field_info(i).required
                error(['Required field: "' field_info(i).field '" was ' ...
                       'not found in calibration config file.']);
            else
                % This is an optional field; set the default value since it
                % was not set
                calib_config.(field_info(i).field) = field_info(i).default;
            end            
        end
        
        % Validate field if a validation function was set
        if ~isempty(field_info(i).validation_fun)
            calib_config = field_info(i).validation_fun(calib_config,field_info(i).field);
        end
    end
end

% Make all validate_* functions take calib_config and the field, and return
% the calib_config. This makes things easier.

function calib_config = validate_calibration_target(calib_config,field)
    switch calib_config.(field)
        case 'checker'
        case 'circle'
        otherwise
            error(['Calibration target: "' calib_config.(field) '" is not supported.']);
    end
end

function calib_config = validate_string(calib_config,field)
    if ~ischar(calib_config.(field)) 
        error(['Field: "' field '" has a value which is not a string.']);
    end
    calib_config.(field) = calib_config.(field);
end

function calib_config = validate_pos_num(calib_config,field)
    if ~util.is_pos(calib_config.(field)) 
        error(['Field: "' field '" has a value which is not a positive number.']);
    end
    calib_config.(field) = calib_config.(field);
end

function calib_config = validate_pos_int(calib_config,field)
    if ~util.is_pos(calib_config.(field)) || ~util.is_int(calib_config.(field))
        error(['Field: "' field '" has a value which is not a positive integer.']);
    end
    calib_config.(field) = calib_config.(field);
end

function calib_config = validate_file_path(calib_config,field)
    if isempty(calib_config.(field)) || exist(calib_config.(field),'file') ~= 2
        error(['Field: "' field '" has a value which is not an existing file.']);
    end
    calib_config.(field) = calib_config.(field);
end
