function [solid, C_s_w, C_s_e] = bc_dp_swe_Fcn(u, Global)
    
    index1 = Global.n1;
    id_s_w = 'solid_wake';    
    id_s_e = 'solid_emulsion';

% ---------- solid - wake phase -------------------------------------------
    [u7w, u8w, u9w] = assignValuesFcn(u, Global, id_s_w);
% ---------- solid - emulsion phase ---------------------------------------
    [u7e, u8e, u9e] = assignValuesFcn(u, Global, id_s_e);
% ---------- z = 0 solid - wake & emulsion phases -------------------------
    u7w(1) = u7e(1); 
    u8w(1) = u8e(1); 
    u9w(1) = u9e(1);
% ---------- z = Zg solid - wake & emulsion phases ------------------------
    u7e(index1) = u7w(index1); 
    u8e(index1) = u8w(index1);
    u9e(index1) = u9w(index1);

    wake.u7w = u7w; wake.u8w = u8w; wake.u9w = u9w;
    emulsion.u7e = u7e; emulsion.u8e = u8e; emulsion.u9e = u9e;

    solid.wake = wake; solid.emulsion = emulsion;

    C_s_w = [u7w,u8w,u9w];
    C_s_e = [u7e,u8e,u9e];
% -------------------------------------------------------------------------
end