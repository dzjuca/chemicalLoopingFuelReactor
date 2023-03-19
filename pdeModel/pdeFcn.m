function ut = pdeFcn(t,u,Global)
% -------------------------------------------------------------------------
    % pdeFcn function define the EDOs for the numerical solution with 
    % the method of lines
    % ----------------------------| input |--------------------------------
    %       t = interval of integration, specified as a vector
    %       u = time-dependent terms, specified as a vector
    %  Global = constant values structure 
    % ----------------------------| output |-------------------------------
    %      ut =  time-dependent terms variation, specified as a vector
    % ---------------------------------------------------------------------
% --------------------| constants values |---------------------------------

    ncall   = Global.iterations;
    Tbed  (1:Global.n1,1) = Global.Tbed;
    Tbed_2(1:Global.n2,1) = Global.Tbed;
    index1  = Global.n1;
    id_g_b  = 'gas_bubble';    id_g_e  = 'gas_emulsion';
    id_s_w  = 'solid_wake';    id_s_e  = 'solid_emulsion';
    id_g_f  = 'gas_freeboard'; id_s_f  = 'solid_freeboard';
% --------------------| Variables Initial Configuration |------------------
% ---------- non-negative values check ------------------------------------
    u(u < 0) = 0;
% ---------- gas - bubble & wake phases------------------------------------
    [u1b, u2b, u3b, u4b, u5b, u6b] = assignValuesFcn(u, Global, id_g_b);
% ---------- gas - emulsion phase -----------------------------------------
    [u1e, u2e, u3e, u4e, u5e, u6e] = assignValuesFcn(u, Global, id_g_e);
% ---------- solid - wake phase -------------------------------------------
                   [u7w, u8w, u9w] = assignValuesFcn(u, Global, id_s_w);
% ---------- solid - emulsion phase ---------------------------------------
                   [u7e, u8e, u9e] = assignValuesFcn(u, Global, id_s_e);
% ---------- gas freeboard phase ------------------------------------------
%    [f1g, f2g, f3g, f4g, f5g, f6g] = assignValuesFcn(u, Global, id_g_f);
% ---------- solid freeboard phase ----------------------------------------
%                   [f1s, f2s, f3s] = assignValuesFcn(u, Global, id_s_f);
% --------------------| Fluidized Bed |------------------------------------ 
% --------------------| Boundary Conditions Dense Phase |------------------
    [gas.bubble, C_g_b]   = bc_dp_gb_Fcn(u1b,u2b,u3b,u4b,u5b,u6b,Global); 
    [gas.emulsion, C_g_e] = bc_dp_ge_Fcn(u1e,u2e,u3e,u4e,u5e,u6e,Global); 
    [solid, C_s_w, C_s_e] = bc_dp_swe_Fcn(u7w,u8w,u9w,u7e,u8e,u9e,Global); 
% ---------- concentrations dense phase vector ----------------------------
    C_gs_dp.C_g_b = C_g_b; C_gs_dp.C_g_e = C_g_e;
    C_gs_dp.C_s_w = C_s_w; C_gs_dp.C_s_e = C_s_e;
% --------------------| Boundary Conditions Lean Phase |-------------------
%    [f1g, f2g, f3g, f4g, f5g, f6g] = ... 
%                bc_lp_g_Fcn(f1g, f2g, f3g, f4g, f5g, f6g, C_gs_dp, Global);
%    [f1s, f2s, f3s] = bc_lp_s_Fcn(f1s, f2s, f3s, C_gs_dp, Global);
% ---------- concentrations Lean phase vector -----------------------------
%    C_gs_lp.C_g = [f1g,f2g,f3g,f4g,f5g,f6g];
%    C_gs_lp.C_s = [f1s,f2s,f3s];
% -----
    denseMassBalanceFcn(Global)
% ------ 
% --------------------| Mass Balance - Gas   - Freeboard Phase |-----------
% --------------------| Mass Balance - Solid - Freeboard Phase |-----------
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
    ut = [u1bt; u2bt; u3bt; u4bt; u5bt; u6bt; ...
          u1et; u2et; u3et; u4et; u5et; u6et; ...
          u7wt; u8wt; u9wt; u7et; u8et; u9et];
% --------------------| Number Calls To pdeFcn |---------------------------
    disp([ncall.getNcall, t]);
    ncall.incrementNcall();
% --------------------| pdeFcn - End |-------------------------------------
end 