function test_normalize_array
    A = [0.547215529963803   0.840717255983663   0.929263623187228   0.616044676146639; ...
         0.138624442828679   0.254282178971531   0.349983765984809   0.473288848902729; ...
         0.149294005559057   0.814284826068816   0.196595250431208   0.351659507062997; ...
         0.257508254123736   0.243524968724989   0.251083857976031   0.830828627896291];
    
    % Assert
    assert(all(all(abs(alg.normalize_array(A, 'min-max') - [0.516785782042614   0.888006603513615   1.000000000000000   0.603840848238072
                                                                            0   0.146283840993564   0.267327155555686   0.423283356539809
                                                            0.013494857066835   0.854574880710731   0.073321445537571   0.269446631948733
                                                            0.150364179069831   0.132678127396543   0.142238606359417   0.875499472153281]) < 1e-4)));
    assert(all(all(abs(alg.normalize_array(A, 'mean-norm') - [ 0.123120635150234   0.505703489805824   0.621124691559948   0.212840213931704
                                                              -0.409482517215587  -0.258721336160245  -0.133973223598438   0.026756361389045
                                                              -0.395574620241111   0.471248515283385  -0.333916906886723  -0.131788875948934
                                                              -0.254516110324604  -0.272743482673870  -0.262890384135385   0.492813550064760]) < 1e-4)));
end