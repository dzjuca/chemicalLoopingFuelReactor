function ut_dp_mb = denseMassBalanceFcn(u, Tbed, Global)
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% --------------------| constants values |---------------------------------
    index1  = Global.n1;
% ---------- bubble - ubFcn.m ---------------------------------------------
    [ub,db,us,ue,alpha] = ubFcn(Global);   
% --------------------| Boundary Conditions Dense Phase |------------------
    [gas.bubble, C_g_b]   = bc_dp_gb_Fcn (u, Global); 
    [gas.emulsion, C_g_e] = bc_dp_ge_Fcn (u, Global); 
    [solid, C_s_w, C_s_e] = bc_dp_swe_Fcn(u, Global); 
% ---------- concentrations dense phase vector ----------------------------
    u1b = gas.bubble.u1b;   u2b = gas.bubble.u2b;   u3b = gas.bubble.u3b;
    u4b = gas.bubble.u4b;   u5b = gas.bubble.u5b;   u6b = gas.bubble.u6b;
    u1e = gas.emulsion.u1e; u2e = gas.emulsion.u2e; u3e = gas.emulsion.u3e;
    u4e = gas.emulsion.u4e; u5e = gas.emulsion.u5e; u6e = gas.emulsion.u6e;
    u7w = solid.wake.u7w;   u8w = solid.wake.u8w;   u9w = solid.wake.u9w;
    u7e = solid.emulsion.u7e; 
    u8e = solid.emulsion.u8e; 
    u9e = solid.emulsion.u9e;
% -------------------------------------------------------------------------
    C_gs_dp.C_g_b = C_g_b; C_gs_dp.C_g_e = C_g_e;
    C_gs_dp.C_s_w = C_s_w; C_gs_dp.C_s_e = C_s_e;
% --------------------| Mass Balance - Gas - Bubble & Wake Phase | --------
    id_1 = 'FGBurbuja'; id_2 = 'FGas';
    u1bt = massBalanceFcn(u1b, u1e, C_gs_dp, Tbed, alpha, ub, db, ... 
                          Global, id_1, id_2, 'CH4');
    u2bt = massBalanceFcn(u2b, u2e, C_gs_dp, Tbed, alpha, ub, db, ...
                          Global, id_1, id_2, 'CO2');
    u3bt = massBalanceFcn(u3b, u3e, C_gs_dp, Tbed, alpha, ub, db, ...
                          Global, id_1, id_2, 'CO' );
    u4bt = massBalanceFcn(u4b, u4e, C_gs_dp, Tbed, alpha, ub, db, ...
                          Global, id_1, id_2, 'H2' );
    u5bt = massBalanceFcn(u5b, u5e, C_gs_dp, Tbed, alpha, ub, db, ...
                          Global, id_1, id_2, 'H2O');
    u6bt = massBalanceFcn(u6b, u6e, C_gs_dp, Tbed, alpha, ub, db, ... 
                          Global, id_1, id_2, 'N2' );
% --------------------| Mass Balance - Gas - Emulsion Phase |--------------
    id_1 = 'FGEmulsion'; 
u1et = massBalanceFcn(u1b,u1e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'CH4');
u2et = massBalanceFcn(u2b,u2e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'CO2');
u3et = massBalanceFcn(u3b,u3e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'CO' );
u4et = massBalanceFcn(u4b,u4e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'H2' );
u5et = massBalanceFcn(u5b,u5e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'H2O');
u6et = massBalanceFcn(u6b,u6e,C_gs_dp,Tbed,alpha,[ub,ue],db,Global,id_1,id_2,'N2' );
% --------------------| Mass Balance - Solid - Wake Phase |----------------
id_1 = 'FSEstela'; id_2 = 'FSolido';
u7wt = massBalanceFcn(u7w,u7e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'NiO');
u8wt = massBalanceFcn(u8w,u8e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'Ni' );
u9wt = massBalanceFcn(u9w,u9e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'C'  );
% --------------------| Mass Balance - Solid - Emulsion Phase |------------
id_1 = 'FSEmulsion'; 
u7et = massBalanceFcn(u7w,u7e,C_gs_dp,Tbed,alpha,[ub,us],db,Global,id_1,id_2,'NiO');
u8et = massBalanceFcn(u8w,u8e,C_gs_dp,Tbed,alpha,[ub,us],db,Global,id_1,id_2,'Ni' );
u9et = massBalanceFcn(u9w,u9e,C_gs_dp,Tbed,alpha,[ub,us],db,Global,id_1,id_2,'C'  );

% --------------------| Boundary Conditions 2 |----------------------------
% ---------- z = 0 gas - bubble & wake phase ------------------------------
    u1bt(1) = 0; u2bt(1) = 0; u3bt(1) = 0; 
    u4bt(1) = 0; u5bt(1) = 0; u6bt(1) = 0;
% ---------- z = 0 gas - emulsion phase -----------------------------------
    u1et(1) = 0; u2et(1) = 0; u3et(1) = 0; 
    u4et(1) = 0; u5et(1) = 0; u6et(1) = 0;
% ---------- z = 0 solid - wake & emulsion phases -------------------------
    u7wt(1) = u7et(1); 
    u8wt(1) = u8et(1); 
    u9wt(1) = u9et(1);
% ---------- z = Zg solid - wake & emulsion phase -------------------------
    u7et(index1) = u7wt(index1); 
    u8et(index1) = u8wt(index1);
    u9et(index1) = u9wt(index1);
% --------------------| Temporal Variation Vector dudt |-------------------
    ut_dp_mb = [u1bt; u2bt; u3bt; u4bt; u5bt; u6bt; ...
                u1et; u2et; u3et; u4et; u5et; u6et; ...
                u7wt; u8wt; u9wt; u7et; u8et; u9et];
% -------------------------------------------------------------------------
end