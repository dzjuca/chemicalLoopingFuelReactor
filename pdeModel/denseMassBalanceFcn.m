function denseMassBalanceFcn(Global)
% -------------------------------------------------------------------------
    % pdeFcn function define the EDOs for the numerical solution with 
    % the method of lines
    % ----------------------------| input |--------------------------------
    %       t = interval of integration, specified as a vector
    %       u = time-dependent terms, specified as a vector
    %  Global = constant values structure 
    % ----------------------------| output |-------------------------------
    %      ut =  time-dependent terms variation, specified as a vector
% -------------------------------------------------------------------------
% ---------- bubble - ubFcn.m ---------------------------------------------
    [ub,db,us,ue,alpha] = ubFcn(Global);   
% -------------------------------------------------------------------------

% --------------------| Mass Balance - Gas - Bubble & Wake Phase | --------
id_1 = 'FGBurbuja'; id_2 = 'FGas';
u1bt = massBalanceFcn(u1b,u1e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'CH4');
u2bt = massBalanceFcn(u2b,u2e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'CO2');
u3bt = massBalanceFcn(u3b,u3e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'CO' );
u4bt = massBalanceFcn(u4b,u4e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'H2' );
u5bt = massBalanceFcn(u5b,u5e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'H2O');
u6bt = massBalanceFcn(u6b,u6e,C_gs_dp,Tbed,alpha,ub,db,Global,id_1,id_2,'N2' );
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
end