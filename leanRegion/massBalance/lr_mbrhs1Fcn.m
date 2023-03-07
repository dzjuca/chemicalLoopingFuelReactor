function lr_mbrhs1 = lr_mbrhs1Fcn(u_gs_lr, Ci, Global)
% -------------------------------------------------------------------------
    %  lr_mbrhs1Fcn is a function that returns the right hand side of the
    %  mass balance equation for the lean region inside the fuel reactor.
    % ----------------------------| inlet |--------------------------------
    %   u_gs_lr   = gas|solid velocity in the lean region            [cm/s]
    %   Ci        = concentration of species i in the lean region [mol/cm3]
    %   Global    = constants structure
    % ----------------------------| outlet |-------------------------------
    %   lr_mbrhs1 = right-hand side term-1 [mol/cm3-s] [gSolid/g-carrier-s]
% -------------------------------------------------------------------------

    zg2  = Global.reactor.zg2;  
    xl   = zg2(1);
    xu   = zg2(end);
    n    = Global.n2;
    
% -------------------------------------------------------------------------

    dCi_dz    = dss012(xl,xu,n,Ci, 1);
    lr_mbrhs1 = u_gs_lr.*dCi_dz;

% -------------------------------------------------------------------------
end