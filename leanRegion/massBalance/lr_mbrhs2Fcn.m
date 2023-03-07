function lr_mbrhs2 =  lr_mbrhs2Fcn(Ci, Global)
% -------------------------------------------------------------------------
    %  lr_mbrhs2Fcn is a function that returns the 2-right hand side of the
    %  mass balance equation for the lean region inside the fuel reactor.
    % ----------------------------| inlet |--------------------------------
    %   Ci        = concentration of species i in the lean region [mol/cm3]
    %   Global    = constants structure
    % --------
    %   Ef_f      = freeboard porosity                                   []
    %   D_ax      = axial dispersion coefficient                    [cm2/s]
    % ----------------------------| outlet |-------------------------------
    %   lr_mbrhs2 = right-hand side term-1 [mol/cm3-s] [gSolid/g-carrier-s]
% -------------------------------------------------------------------------

    zg2  = Global.reactor.zg2;  
    xl   = zg2(1);
    xu   = zg2(end);
    n    = Global.n2;

% -------------------------------------------------------------------------

    Ef_f = freeboardPorosityFcn();
    D_ax = axialDispersionCoefficientFcn();

    dCi_dz     = dss012(xl,xu,n,Ci, 1);
    tmp_1      = D_ax.*dCi_dz;
    d_tmp_1_dz = dss012(xl,xu,n,tmp_1, 1);
    lr_mbrhs2  = Ef_f.*d_tmp_1_dz;

% -------------------------------------------------------------------------
end
