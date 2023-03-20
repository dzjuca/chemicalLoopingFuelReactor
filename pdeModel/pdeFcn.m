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

    ncall   = Global.iterations;
    Tbed  (1:Global.n1,1) = Global.Tbed;
    % Tbed_2(1:Global.n2,1) = Global.Tbed;
    % id_g_f  = 'gas_freeboard'; id_s_f  = 'solid_freeboard';
% --------------------| Variables Initial Configuration |------------------
% ---------- non-negative values check ------------------------------------
    u(u < 0) = 0;
% --------------------| Fluidized Bed |------------------------------------ 
% -----
    ut_dp_mb = denseMassBalanceFcn(u, Tbed, Global);
% ------ 
% --------------------| Mass Balance - Gas   - Freeboard Phase |-----------
% --------------------| Mass Balance - Solid - Freeboard Phase |-----------

% --------------------| Temporal Variation Vector dudt |-------------------
    ut = ut_dp_mb;
% --------------------| Number Calls To pdeFcn |---------------------------
    disp([ncall.getNcall, t]);
    ncall.incrementNcall();
% --------------------| pdeFcn - End |-------------------------------------
end 