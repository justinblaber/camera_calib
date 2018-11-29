function test_dp_p_d_dextrinsic
    p_ws = [100   100];
        
    % Undistort
    a = 1.0e+02 * [5.811989327265433;
                   3.115861087870574;
                   2.342314804973926];
    d = [ 0.072064394856535;
         -0.202044348085313;
         -0.025155451778392;
          0.009925044485141];
    R = [ 0.050919203994491   0.997916660938669   0.039617830399779
         -0.916296817923636   0.030901849434057   0.399305919270645
          0.397249765421689  -0.056634031487905   0.915961358546222];
    t = 1.0e+02 * [-5.674725592797016
                    4.560810914904970
                    9.393392677755116];
    drt_dm = [                 0   0.022041418396075   0.916296817923636                   0                   0                   0; ...
                               0  -0.396637809597971   0.050919203994491                   0                   0                   0; ...
                               0  -0.917710533813584                   0                   0                   0                   0; ...
               0.039617830399779  -0.003142341398632  -0.030901849434057                   0                   0                   0; ...
               0.399305919270645   0.056546787823071   0.997916660938669                   0                   0                   0; ...
               0.915961358546222  -0.024515198305466                   0                   0                   0                   0; ...
              -0.997916660938669   0.050822150938021  -0.399305919270645                   0                   0                   0; ...
              -0.030901849434057  -0.914550337228013   0.039617830399779                   0                   0                   0; ...
               0.056634031487905   0.396492599148623                   0                   0                   0                   0; ...
                               0                   0                   0   1.000000000000000                   0                   0; ...
                               0                   0                   0                   0   1.000000000000000                   0; ...
                               0                   0                   0                   0                   0   1.000000000000000];
    dp_p_d_dextrinsic = alg.dp_p_d_dextrinsic(p_ws, ...
                                              @(p,H)alg.apply_homography_c2e(p,H,11.837742948488916), ...
                                              @(p,H)alg.dp_dh_c2e(p,H,11.837742948488916), ...
                                              R, ...
                                              t, ...
                                              {@(x_p,y_p,a,x_o,y_o,k1,k2,p,t)[(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0)./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)+((1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)-(x_o-x_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).*((p.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+(p.*(1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./a-(t.*(1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./a),((1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)-(y_o-y_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).*((p.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+(p.*(1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./a-(t.*(1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./a)],@(x_p,y_p,a,x_o,y_o,k1,k2,p,t)[((1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)+(x_o-x_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).*((t.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(p.*(1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./a+(t.*(1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./a),(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0)./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)+((1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)+(y_o-y_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).*((t.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(p.*(1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./a+(t.*(1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./a)],@(x_p,y_p,a,x_o,y_o,k1,k2,p,t)[((k1.*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0).*2.0).*(x_o-x_p))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)-(x_o-x_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).*(1.0./a.^2.*p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0)-1.0./a.^2.*t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0)+(p.*(k1.*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0).*2.0).*(x_o-x_p))./a-(t.*(k1.*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0).*2.0).*(y_o-y_p))./a),((k1.*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0).*2.0).*(y_o-y_p))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)-(y_o-y_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).*(1.0./a.^2.*p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0)-1.0./a.^2.*t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0)+(p.*(k1.*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0).*2.0).*(x_o-x_p))./a-(t.*(k1.*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*(1.0./a.^3.*(x_o-x_p).^2.*2.0+1.0./a.^3.*(y_o-y_p).^2.*2.0).*2.0).*(y_o-y_p))./a)],@(x_p,y_p,a,x_o,y_o,k1,k2,p,t)[-(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0)./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)-((1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)+(x_o-x_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).*((p.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+(p.*(1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./a-(t.*(1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./a)+1.0,-((1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)+(y_o-y_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).*((p.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+(p.*(1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./a-(t.*(1.0./a.^2.*k1.*(x_o.*2.0-x_p.*2.0)+1.0./a.^2.*k2.*(x_o.*2.0-x_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./a)],@(x_p,y_p,a,x_o,y_o,k1,k2,p,t)[-((1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)-(x_o-x_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).*((t.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(p.*(1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./a+(t.*(1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./a),-(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0)./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)-((1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)-(y_o-y_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).*((t.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(p.*(1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(x_o-x_p))./a+(t.*(1.0./a.^2.*k1.*(y_o.*2.0-y_p.*2.0)+1.0./a.^2.*k2.*(y_o.*2.0-y_p.*2.0).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).*2.0).*(y_o-y_p))./a)+1.0],@(x_p,y_p,a,x_o,y_o,k1,k2,p,t)[-((x_o-x_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)-((t.*(y_o-y_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2))./a-(p.*(x_o-x_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2))./a).*(x_o-x_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0),-((y_o-y_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)-((t.*(y_o-y_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2))./a-(p.*(x_o-x_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2))./a).*(y_o-y_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0)],@(x_p,y_p,a,x_o,y_o,k1,k2,p,t)[-((x_o-x_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2)./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)+((p.*(x_o-x_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2)./a-(t.*(y_o-y_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2)./a).*(x_o-x_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0),-((y_o-y_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2)./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)+((p.*(x_o-x_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2)./a-(t.*(y_o-y_p).*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2)./a).*(y_o-y_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0)],@(x_p,y_p,a,x_o,y_o,k1,k2,p,t)[((x_o-x_p).^2.*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).^2)./a,((x_o-x_p).*(y_o-y_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).^2)./a],@(x_p,y_p,a,x_o,y_o,k1,k2,p,t)[-((x_o-x_p).*(y_o-y_p).*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).^2)./a,-((y_o-y_p).^2.*1.0./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0).^2.*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0).^2)./a]}, ...
                                              a, ...
                                              d, ...
                                              drt_dm);
                         
    % Get finite difference approximation
    f_p_p2p_p_d = @(x_p,y_p,a,x_o,y_o,k1,k2,p,t)[x_o-((x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0),y_o-((y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./((p.*(x_o-x_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a-(t.*(y_o-y_p).*(k1.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2)+k2.*(1.0./a.^2.*(x_o-x_p).^2+1.0./a.^2.*(y_o-y_p).^2).^2+1.0))./a+1.0)];
    H = alg.a2A(a)*[R(:,1) R(:,2) t];
    p_ps = alg.apply_homography_c2e(p_ws,H,11.837742948488916);
    p_p_ds = alg.p_p2p_p_d(p_ps,f_p_p2p_p_d,a,d);  
    
    delta = 1e-7;
    m = vertcat(alg.rot2euler(R),t);
    dp_p_d_dextrinsic_finite = [];
    for i = 1:numel(m)
        m_delta = m;
        m_delta(i) = m_delta(i) + delta;
        
        R_delta = alg.euler2rot(m_delta(1:3));
        t_delta = m_delta(4:end);
                
        H_delta = alg.a2A(a)*[R_delta(:,1) R_delta(:,2) t_delta];
        p_ps_delta = alg.apply_homography_c2e(p_ws,H_delta,11.837742948488916);
        p_p_ds_delta = alg.p_p2p_p_d(p_ps_delta,f_p_p2p_p_d,a,d);
        
        dp_p_d_dextrinsic_finite = [dp_p_d_dextrinsic_finite ((p_p_ds_delta-p_p_ds)./delta)']; %#ok<AGROW>
    end
    
    % Assert
    assert(all(all(abs(dp_p_d_dextrinsic - [27.941642292891199 -25.142079321352803  54.057655537383908   0.587681438726269   0.019597707726203   0.271888383168330; ...
                                             3.641642090524822   0.374808666478910  62.429311433381862   0.010983229014390   0.585929421885145  -0.216092423917091]) < 1e-4)));
                                         
    assert(all(all(abs(dp_p_d_dextrinsic - dp_p_d_dextrinsic_finite) < 1e-4)));
end