function [emulsion, C_g_e] = bc_dp_ge_Fcn(u1e, u2e, u3e, ... 
                                                u4e, u5e, u6e, Global)
% ---------- z = 0 gas - emulsion phase -----------------------------------

    u1e(1) = Global.CH4in; u2e(1) = 0.000; u3e(1) = 0.000;
    u4e(1) = 0.000;        u5e(1) = 0.000; u6e(1) = Global.N2in;

    emulsion.u1e = u1e; emulsion.u2e = u2e; emulsion.u3e = u3e;
    emulsion.u4e = u4e; emulsion.u5e = u5e; emulsion.u6e = u6e;

    C_g_e = [u1e, u2e, u3e, u4e, u5e, u6e];

end