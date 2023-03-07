function f_l = freeboardPorosityFcn(Global)
% -------------------------------------------------------------------------

    z     = Global.reactor.z2;
    a_u0  = 7; % s-1
    rho_p = Global.carrier.bulkDensity;
    f_d    = 0.3;

% -------------------------------------------------------------------------
    u_sgf = superficialGasVelocityFreeboardFcn();
    G_sat = saturatedFluxSolidsFcn();
% -------------------------------------------------------------------------

    a = a_u0./u_sgf;
    f_asterisk = G_sat./(u_sgf.*rho_p);

% -------------------------------------------------------------------------

    f_l = f_asterisk + (f_d - f_asterisk).*exp(-a.*z);

% -------------------------------------------------------------------------
end