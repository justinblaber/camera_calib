function test_apply_homography_p2p
    p_1s = [0 0;
            0 1;
            1 0;
            1 1];

    H_12 = [ 0.486486486486487   0.105405405405405   0.100000000000000;
            -0.216216216216216   0.521621621621622   0.300000000000000;
            -0.162162162162162   0.027027027027027   1.000000000000000];

    % Ground truth
    p_2s = [0.1 0.3;
            0.2 0.8;
            0.7 0.1;
            0.8 0.7];
    
    % Compare computed points to ground truth
    assert(all(all(abs(alg.apply_homography_p2p(p_1s,H_12) - p_2s) < eps('single'))));
end
