function test_img
    % Get tests path
    tests_path = fileparts(fileparts(fileparts(mfilename('fullpath'))));

    % Set images
    imgs = util.img.validate_similar_imgs({fullfile(tests_path, 'data', 'circle','1.jpg'), ...
                                           fullfile(tests_path, 'data', 'checker','1.jpg')});

    % Load
    load(fullfile(tests_path, 'data', 'circle','1.mat'));
    load(fullfile(tests_path, 'data', 'checker','1.mat'));

    % Assert
    assert(isequal(imgs(1).get_array_gs(), array_ellipse1));
    assert(isequal(imgs(2).get_array_gs(), array_checker1));
end
