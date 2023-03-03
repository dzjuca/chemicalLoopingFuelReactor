% -------------------------------------------------------------------------
% ------------------------ FLUIDIZED BED REACTOR --------------------------
%                    Chemical Looping Combustion - CLC
%     Author: Daniel Z. Juca
% ------------------------ | initiation | ---------------------------------
    close all
    clear Iterations
    clc
% ---------- global constants ---------------------------------------------
    Global = globalDataFcn();
    NoN  = (1:Global.n*Global.Num_esp);
% ---------- initial condition --------------------------------------------
    u0   = initialConditions(Global);
% ---------- time simulation (s) ------------------------------------------
    t0   = 0.0; 
    tf   = 3.5*60;
    tout = linspace(t0,tf,100)';
% ---------- Implicit (sparse stiff) integration --------------------------
    reltol   = 1.0e-6; abstol = 1.0e-6;  
    options  = odeset('RelTol',reltol,'AbsTol',abstol,'NonNegative',NoN);
    S        = JPatternFcn(Global);
    options  = odeset(options,'JPattern',S); 
    pdeModel = @(t,u)pdeFcn(t,u,Global);
    [t,u]    = ode15s(pdeModel,tout,u0,options);  
%% -----
    graphsFmgAllSpeciesFcn(t, u, Global)
    graphs_C_g_b_Fcn(t,u, Global)
    graphs_C_g_e_Fcn(t,u, Global)
    graphs_C_s_w_Fcn(t,u, Global)
    graphs_C_s_e_Fcn(t,u, Global)
    graphsCgbAllSpeciesFcn(t,u, Global)
    graphsCgeAllSpeciesFcn(t,u, Global)
    graphsCswAllSpeciesFcn(t,u, Global)
    graphsCseAllSpeciesFcn(t,u, Global)
% ---------------------------| End Program |-------------------------------