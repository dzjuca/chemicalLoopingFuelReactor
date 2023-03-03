function RH2 = mbrhs2Fcn(alpha,ub,CiBW,CiE,Global,caracter)
% -------------------------------------------------------------------------
    % mbrhs2Fcn - function allows to obtain the second term (Right Hand 
    % Side)of the mass balance model
    % ----------------------------| inlet |--------------------------------
    %    alpha = fraction of bubbles in bed                            f(z)
    %       ub = bubbles velocity                                      f(z)
    %     CiBW = gas concentration - Burbuja & Estela  phases          f(z)
    %      CiE = gas concentration - Emulsion phase                    f(z)
    %   Global = constants structure
    % caracter = phase identifier (Gas,Solid)
    % ----------------------------| outlet |-------------------------------
    %      RH2 = right-hand side term-2  [  mol/cm3-s] [gSolid/g-carrier-s] 
% -------------------------------------------------------------------------
    fw      = Global.fDynamics.fw;
    Emf     = Global.fDynamics.Emf; 
    Dcat    = Global.carrier.bulkDensity;
    zg      = Global.reactor.zg; 
    xl      = zg(1);
    xu      = zg(end);
    n       = Global.n;
    lambda1 = zeros(n,1);
    lambda2 = zeros(n,1);
% -------------------------------------------------------------------------   
    if     strcmp(caracter,'FGas')
        temporal1 = (alpha+alpha*fw*Emf).*ub;
             temporal2 = dss012(xl,xu,n,temporal1, 1);
            %temporal2 = dss020(xl,xu,n,temporal1, 1)';
            %temporal2 = dss004(xl,xu,n,temporal1)';
        for i = 1:n
            if      temporal2(i) < 0
                        lambda1(i) = 1;          
                        lambda2(i) = 0;
            elseif temporal2(i) >= 0
                        lambda1(i) = 0;
                        lambda2(i) = 1;
            else
                    disp('Error - Inconsistency in mbrhs2Fcn.m FGas')
            end
        end
        RH2 = (lambda1.*CiBW + lambda2.*CiE).*temporal2;
% -------------------------------------------------------------------------
    elseif strcmp(caracter,'FSolido')
        temporal1 = (1-Emf)*alpha*fw.*ub*Dcat;
            % temporal2 = dss012(xl,xu,n,temporal1, 1);
              temporal2 = dss020(xl,xu,n,temporal1, 1)';
            % temporal2 = dss004(xl,xu,n,temporal1)';
        for i = 1:n
            if      temporal2(i) < 0
                        lambda1(i) = 1;
                        lambda2(i) = 0;
            elseif temporal2(i) >= 0
                        lambda1(i) = 0;
                        lambda2(i) = 1;
            else
                    disp('Error - Inconsistency in mbrhs2Fcn.m FGas')
            end
        end
        RH2 = (lambda1.*CiBW + lambda2.*CiE).*temporal2;
% -------------------------------------------------------------------------
    else
        disp('Error - Inconsistency in mbrhs2Fcn.m')
    end
% -------------------------------------------------------------------------
end