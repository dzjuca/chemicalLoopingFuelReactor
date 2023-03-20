function ut = pdeFcn(t,u,Global)
% -------------------------------------------------------------------------
    % pdeFcn function define the EDOs for the numerical solution with 
    % the method of lines
    % ----------------------------| input |--------------------------------
    %       t = interval of integration, specified as a vector
    %       u = time-dependent terms, specified as a vector
    %  Global = constant values structure 
    % ----------------------------| output |-------------------------------
    %      ut =  time-dependent terms variation, specified as a vector
    % ---------------------------------------------------------------------
% --------------------| constants values |---------------------------------

    ncall                 = Global.iterations;
    Tbed_dp  (1:Global.n1,1) = Global.Tbed;
    Tbed_lp(1:Global.n2,1) = Global.Tbed;

% --------------------| Variables Initial Configuration |------------------
% ---------- non-negative values check ------------------------------------
    u(u < 0) = 0;
% --------------------| Fluidized Bed |------------------------------------ 
% -------------------------------------------------------------------------
    mb_dp    = denseMassBalanceFcn(u, Tbed_dp, Global);
    ut_dp_mb = mb_dp.ut;  
    C_gs_dp  = mb_dp.C_gs_dp;  
% -------------------------------------------------------------------------
    mb_lp    = leanMassBalanceFcn(u, C_gs_dp, Tbed_lp, Global);
    ut_lp_mb = mb_lp.ut;  
% --------------------| Temporal Variation Vector dudt |-------------------
    ut = [ut_dp_mb; ut_lp_mb];
% --------------------| Number Calls To pdeFcn |---------------------------
    disp([ncall.getNcall, t]);
    ncall.incrementNcall();
% --------------------| pdeFcn - End |-------------------------------------
end 