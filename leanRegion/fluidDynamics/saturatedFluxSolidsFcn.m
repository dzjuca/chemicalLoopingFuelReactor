function G_sat = saturatedFluxSolidsFcn()
% -------------------------------------------------------------------------

    u_t     = particleTerminalVelocityFcn();
    u_sgf   = superficialGasVelocityFreeboardFcn();
    rho_g_m = densityGasMixFcn(Cgas, MM);

% -------------------------------------------------------------------------

    G_sat = 23.7.*rho_g_m.*u_sgf.*exp(-5.4.*u_t./u_sgf);
    
% -------------------------------------------------------------------------
end