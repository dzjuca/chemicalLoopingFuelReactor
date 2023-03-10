function u_t_2 = particleTerminalVelocityFcn(mu_lp_g_m, rho_lp_g_m, Global)
% -------------------------------------------------------------------------

    dp         = Global.carrier.dp; 
    sphericity = Global.carrier.sphericity;
    rho_p      = Global.carrier.bulkDensity;
    g          = Global.g;
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------

    tmp_1 = 3.*(mu_lp_g_m.^2);
    tmp_2 = 4.*g.*rho_lp_g_m.*(rho_p - rho_lp_g_m);
    delta = (tmp_1./tmp_2).^(1/3);

    tmp_3 = 4.*g.*mu_lp_g_m.*(rho_p - rho_lp_g_m);
    tmp_4 = 3.*(rho_lp_g_m).^2;
    omega = (tmp_3./tmp_4).^(1/3);

% -------------------------------------------------------------------------

    tmp_5 = (24./((dp./delta).^2));
    tmp_6 = ((2.696 - 2.013.*sphericity)./((dp./delta).^(1/2)));

% -------------------------------------------------------------------------

    u_t_1     = omega./(tmp_5 + tmp_6);
    u_t_1(isinf(u_t_1)) = 0;
    u_t_1(isnan(u_t_1)) = 0;

% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

    dp_asterisk = dp.*((rho_lp_g_m.*(rho_p - rho_lp_g_m).*g)./(mu_lp_g_m)).^(1/3);
    ut_asterisk = ((18./(dp_asterisk.^2))+(0.59./dp_asterisk.^(0.5))).^(-1);
    u_t_2 = ut_asterisk.*(mu_lp_g_m.*(rho_p - rho_lp_g_m).*g./(rho_lp_g_m.^2)).^(1/3);

    u_t_2(isinf(u_t_2)) = 0;
    u_t_2(isnan(u_t_2)) = 0;

end


