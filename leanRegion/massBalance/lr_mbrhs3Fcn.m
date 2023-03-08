function lr_mbrhs3 = lr_mbrhs3Fcn(Ci)
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
 
%     Dcat    = Global.carrier.bulkDensity;
%     C_gas   = CT.C_g;
%     C_solid = CT.C_s;
%     kinetic = kineticFcn(C_gas, C_solid, T_lr, Global, id2);

% -------------------------------------------------------------------------

%     if     strcmp(id1,'lr_gasPhase')
% 
%         lr_mbrhs3 = (1 - Ef_f).*kinetic.*Dcat;
%              
%     elseif strcmp(id1,'lr_solidPhase')
% 
%         lr_mbrhs3 = kinetic;
% 
%     else
% 
%         disp('Error - Inconsistency - lr_mbrhs3Fcn.m')
%         lr_mbrhs3 = 0;
% 
%     end

% -------------------------------------------------------------------------

    lr_mbrhs3 = Ci.*0;

% -------------------------------------------------------------------------
end