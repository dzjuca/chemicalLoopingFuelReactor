function  [solid, C_s] = bc_lp_s_Fcn(u, C_gs_dp, Global)
% -----------------------------------------------------------------

    Emf     = Global.fDynamics.Emf;
    fw      = Global.fDynamics.fw;
    n1      = Global.n1;
    id_s_f  = 'solid_freeboard';

% -------------------------------------------------------------------------

    [ub,db,us,ue,alpha]= ubFcn(Global);

% -----------------------------------------------------------------

    [f1s, f2s, f3s] = assignValuesFcn(u, Global, id_s_f);

    C_s_w  = C_gs_dp.C_s_w;
    C_s_e  = C_gs_dp.C_s_e;
    C_s_we = (C_s_w + C_s_e)./2;
    f1s(1) = C_s_we(n1,1);
    f2s(1) = C_s_we(n1,2);
    f3s(1) = C_s_we(n1,3);


%     C_s_w  = C_gs_dp.C_s_w;
% 
%     f1s(1) = C_s_w(n1,1);
%     f2s(1) = C_s_w(n1,2);
%     f3s(1) = C_s_w(n1,3);

% -----------------------------------------------------------------

    solid.f1s = f1s; 
    solid.f2s = f2s; 
    solid.f3s = f3s; 
    C_s = [f1s, f2s, f3s];
end