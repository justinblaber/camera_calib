function plot_single_extrinsic(rotations,translations,colors,alphas,calib_config,a)
    % This will plot extrinsics for a single camera rig
    
    % Matlab's 3D plot is not very good; to get it in the orientation I want,
    % I've just switched the x, y, and z components with:
    %   x => y
    %   y => z
    %   z => x
    
    if ~exist('a','var')
        f = figure(); 
        a = axes(f);
    end
    cla(a);
        
    % Hold
    hold(a,'on');

    % Plot checker boards
    height_offset = (calib_config.four_point_height-calib_config.num_squares_height*calib_config.square_size)/2;
    width_offset = (calib_config.four_point_width-calib_config.num_squares_width*calib_config.square_size)/2;
    for i = 1:length(rotations)    
        % Get affine xform
        xform = [rotations{i} translations{i}; zeros(1,3) 1];

        % Plot calibration board
        debug.plot_cb_board_3D(calib_config, ...
                               xform, ...
                               colors(i,:), ...
                               alphas(i), ...
                               a);

        % Plot text   
        debug.plot_text_3D(num2str(i), ...
                           width_offset-calib_config.square_size/2, ...
                           height_offset-calib_config.square_size/2, ...
                           0, ...
                           xform, ...
                           colors(i,:), ...
                           10, ...
                           'bold', ...
                           a);
    end

    % Plot camera
    debug.plot_camera_3D(eye(4), ...
                         'k', ...
                         0.5, ...
                         1, ...
                         'b', ...
                         2, ...
                         10, ...
                         calib_config, ...
                         a);

    % Format plot
    set(a,'Ydir','reverse');
    set(a,'Zdir','reverse');
    daspect(a,[1 1 1]);
    grid(a,'on');
    view(a,3);
    axis(a,'tight');
    
    % Remove hold
    drawnow
    hold(a,'off');
end