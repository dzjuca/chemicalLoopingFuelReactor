function u_t = particleTerminalVelocityFcn()
% -------------------------------------------------------------------------

    dp         = Global.carrier.dp; 
    sphericity = Global.carrier.sphericity;
    rho_p      = Global.carrier.bulkDensity;
% -------------------------------------------------------------------------
    mu_g_m     = viscosityGasMixFcn(Global, T, Cgas);
    rho_g_m    = densityGasMixFcn(Cgas, MM);
% -------------------------------------------------------------------------

    tmp_1 = 3.*(mu_g_m.^2);
    tmp_2 = 4.*g.*rho_g_m.*(rho_p - rho_g_m);
    delta = (tmp_1./tmp_2).^(1/3);

    tmp_3 = 4.*g.*mu_g_m.*(rho_p - rho_g_m);
    tmp_4 = 3.*(rho_g_m)^2;
    omega = (tmp_3./tmp_4)^(1/3);

% -------------------------------------------------------------------------

    tmp_5 = (24./((dp./delta).^2));
    tmp_6 = ((2.696 - 2.013.*sphericity)./((dp./delta).^(1/2)));

% -------------------------------------------------------------------------

    u_t = omega./(tmp_5 + tmp_6);
    id = isinf(u_t);
    u_t(id) = 0;

% -------------------------------------------------------------------------
end


