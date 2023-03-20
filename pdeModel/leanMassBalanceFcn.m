function ut_lp_mb = leanMassBalanceFcn()


% ---------- gas freeboard phase ------------------------------------------
%    [f1g, f2g, f3g, f4g, f5g, f6g] = assignValuesFcn(u, Global, id_g_f);
% ---------- solid freeboard phase ----------------------------------------
%                   [f1s, f2s, f3s] = assignValuesFcn(u, Global, id_s_f);

% --------------------| Boundary Conditions Lean Phase |-------------------
%    [f1g, f2g, f3g, f4g, f5g, f6g] = ... 
%                bc_lp_g_Fcn(f1g, f2g, f3g, f4g, f5g, f6g, C_gs_dp, Global);
%    [f1s, f2s, f3s] = bc_lp_s_Fcn(f1s, f2s, f3s, C_gs_dp, Global);
% ---------- concentrations Lean phase vector -----------------------------
%    C_gs_lp.C_g = [f1g,f2g,f3g,f4g,f5g,f6g];
%    C_gs_lp.C_s = [f1s,f2s,f3s];

    ut_lp_mb = [];

end