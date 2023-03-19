function [bubble, C_g_b] = bc_dp_gb_Fcn(u1b, u2b, u3b, ... 
                                                     u4b, u5b, u6b, Global)
% ---------- z = 0 gas - bubble & wake phase ------------------------------

    u1b(1) = Global.CH4in; u2b(1) = 0.000; u3b(1) = 0.000; 
    u4b(1) = 0.000;        u5b(1) = 0.000; u6b(1) = Global.N2in;

    bubble.u1b = u1b; bubble.u2b = u2b; bubble.u3b = u3b;
    bubble.u4b = u4b; bubble.u5b = u5b; bubble.u6b = u6b;
    C_g_b = [u1b,u2b,u3b,u4b,u5b,u6b];

end