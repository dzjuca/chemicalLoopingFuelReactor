function graphs_mf_g_Fcn(t, u_total, Global)
% -------------------------------------------------------------------------
       % graphs_mf_g_Fcn function 
       % ----------------------------| input |-----------------------------
       % ----------------------------| output |----------------------------
       %  
% -------------------------------------------------------------------------
    A   = Global.reactor.rArea1;
    Emf = Global.fDynamics.Emf;
    fw  = Global.fDynamics.fw;
    [ub,db,us,ue,alpha]= ubFcn(Global);
    m   = length(t);
    n1  = Global.n1;
    n2  = Global.n2;
    id1 = (Global.gen*n1 + Global.sen*n1)*2;
    u1  = u_total(:,1:id1);
    u2  = u_total(:,id1+1:end);

% -------------------------------------------------------------------------

    tmin = t/60; 

% -------------------------------------------------------------------------
    z1     = Global.reactor.z1;
    z2     = Global.reactor.z2;
    index1 = Global.n1;  
    index2 = Global.n2;   
% -------------------------------------------------------------------------

    u1b = zeros(m,index1); u2b = zeros(m,index1); 
    u3b = zeros(m,index1); u4b = zeros(m,index1); 
    u5b = zeros(m,index1); u6b = zeros(m,index1);

    u1e = zeros(m,index1); u2e = zeros(m,index1); 
    u3e = zeros(m,index1); u4e = zeros(m,index1); 
    u5e = zeros(m,index1); u6e = zeros(m,index1);
% -------------------------------------------------------------------------
    for j=1:m 
        for i=1:index1, u1b(j,i)=u1(j,i+0*index1);     end
        for i=1:index1, u2b(j,i)=u1(j,i+1*index1);     end
        for i=1:index1, u3b(j,i)=u1(j,i+2*index1);     end
        for i=1:index1, u4b(j,i)=u1(j,i+3*index1);     end
        for i=1:index1, u5b(j,i)=u1(j,i+4*index1);     end 
        for i=1:index1, u6b(j,i)=u1(j,i+5*index1);     end 
        for i=1:index1, u1e(j,i)=u1(j,i+6*index1);     end 
        for i=1:index1, u2e(j,i)=u1(j,i+7*index1);     end 
        for i=1:index1, u3e(j,i)=u1(j,i+8*index1);     end 
        for i=1:index1, u4e(j,i)=u1(j,i+9*index1);     end
        for i=1:index1, u5e(j,i)=u1(j,i+10*index1);    end
        for i=1:index1, u6e(j,i)=u1(j,i+11*index1);    end
    end
% -------------------------------------------------------------------------

    f1_dp = A.*(ub'.*u1b.*(alpha' + alpha'.*fw.*Emf) +        ...
                ue'.*u1e.*(1 - alpha' - alpha'.*fw).*Emf); 
    f2_dp = A.*(ub'.*u2b.*(alpha' + alpha'.*fw.*Emf) +        ...
                ue'.*u2e.*(1 - alpha' - alpha'.*fw).*Emf);
    f3_dp = A.*(ub'.*u3b.*(alpha' + alpha'.*fw.*Emf) +        ...
                ue'.*u3e.*(1 - alpha' - alpha'.*fw).*Emf);
    f4_dp = A.*(ub'.*u4b.*(alpha' + alpha'.*fw.*Emf) +        ...
                ue'.*u4e.*(1 - alpha' - alpha'.*fw).*Emf);
    f5_dp = A.*(ub'.*u5b.*(alpha' + alpha'.*fw.*Emf) +        ...
                ue'.*u5e.*(1 - alpha' - alpha'.*fw).*Emf);
    f6_dp = A.*(ub'.*u6b.*(alpha' + alpha'.*fw.*Emf) +        ...    
                ue'.*u6e.*(1 - alpha' - alpha'.*fw).*Emf);

    ft_dp = f1_dp + f2_dp + f3_dp + f4_dp + f5_dp + f6_dp;

    x1_dp = f1_dp./ft_dp;
    x2_dp = f2_dp./ft_dp;
    x3_dp = f3_dp./ft_dp;
    x4_dp = f4_dp./ft_dp;
    x5_dp = f5_dp./ft_dp;
    x6_dp = f6_dp./ft_dp;
% -------------------------------------------------------------------------

    f1g = zeros(m,index2); f2g = zeros(m,index2); 
    f3g = zeros(m,index2); f4g = zeros(m,index2); 
    f5g = zeros(m,index2); f6g = zeros(m,index2);

% -------------------------------------------------------------------------

    for j=1:m 
        for i=1:index2, f1g(j,i)=u2(j,i+0*index2);     end
        for i=1:index2, f2g(j,i)=u2(j,i+1*index2);     end
        for i=1:index2, f3g(j,i)=u2(j,i+2*index2);     end
        for i=1:index2, f4g(j,i)=u2(j,i+3*index2);     end
        for i=1:index2, f5g(j,i)=u2(j,i+4*index2);     end 
        for i=1:index2, f6g(j,i)=u2(j,i+5*index2);     end 
    end

% -------------------------------------------------------------------------

    ft = f1g + f2g + f3g + f4g + f5g + f6g;

    x1 = f1g./ft;
    x2 = f2g./ft;
    x3 = f3g./ft;
    x4 = f4g./ft;
    x5 = f5g./ft;
    x6 = f6g./ft;

% -------------------------------------------------------------------------

    TAG1 = {'Molar Fraction $(CH_{4}, CO_{2}, H_{2}O)$',
            'Molar Fraction $(CO, H_{2})$',
            'Molar Fraction $x_{i}$'}; 
    TAG3 = {'mf_Time','mf_Space'};
    TAG5 = {'graphs/MolarFraction'};

% -------------------------------------------------------------------------

    FZ1 = 14; MZ1 = 5; XLFZ = 14; YLFZ = 14; LFZ = 5;

% --------------------------| Concentration vs time |----------------------

    id = exist('graphs/MolarFraction','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'MolarFraction','Gas');
    else
        mkdir('graphs/MolarFraction')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'MolarFraction','Gas');
    end

% ---------------------------------------------------------------------

    fig1 = figure;
        set(fig1,'Units','centimeters',              ...
        'PaperPosition',[0 0 15 15],                 ...
        'PaperSize', [15,15]);

    axes('Parent',fig1,'FontSize',FZ1,'XGrid','off', ...
        'YGrid','off','visible','on','Box', 'on',    ...
        'TickLabelInterpreter','latex');

    set(fig1, 'Color', 'w') 

% ---------------------------------------------------------------------

    hold on

        plot(tmin,x1(:,n2)','ko-','MarkerSize',MZ1); % CH4
        plot(tmin,x2(:,n2)','ks-','MarkerSize',MZ1); % CO2
        plot(tmin,x3(:,n2)','kp-','MarkerSize',MZ1); % CO
        plot(tmin,x4(:,n2)','kd-','MarkerSize',MZ1); % H2
        plot(tmin,x5(:,n2)','k*-','MarkerSize',MZ1); % H2O

        ylabel(TAG1{3},'FontSize',YLFZ,'interpreter','Latex')
        ylim([0 0.8])

        xlabel('$time\left( {min} \right)$','FontSize',XLFZ,      ...
        'interpreter','Latex')
        max3 = max(tmin); 
        xlim([0 max3])

        ley1 = {'$C{H_4}$','$C{O_2}$','$CO$','${H_2}$','${H_2}O$'};
        legend(ley1,'Interpreter','Latex','Location','north',   ...
        'Orientation','horizontal','FontSize',LFZ)

    hold off
    print(fig1,'-dpdf','-r500',dir)
    close all
% -------------------------------------------------------------------------
% --------------------------| Concentration vs space |---------------------
    id = exist('graphs/MolarFraction','file');
    if id == 7
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'MolarFraction','Gas');
    else
        mkdir('graphs/MolarFraction')
        dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'MolarFraction','Gas');
    end
    % ---------------------------------------------------------------------
    fig2 = figure;

    set(fig2,'Units','centimeters',                       ...
        'PaperPosition',[0 0 15 15],                      ...
        'PaperSize', [15,15]);

    axes('Parent',fig2,'FontSize',FZ1,'XGrid','off',      ...
        'YGrid','off','visible','on','Box', 'on',         ...
        'TickLabelInterpreter','latex');
    set(fig2, 'Color', 'w') 

    hold on

        plot(z1,x1_dp(m,:)','ko-','MarkerSize',MZ1);
        plot(z1,x2_dp(m,:)','ks-','MarkerSize',MZ1);
        plot(z1,x3_dp(m,:)','kp-','MarkerSize',MZ1);
        plot(z1,x4_dp(m,:)','kd-','MarkerSize',MZ1);
        plot(z1,x5_dp(m,:)','k*-','MarkerSize',MZ1);

        plot(z2,x1(m,:)','ko-','MarkerSize',MZ1);
        plot(z2,x2(m,:)','ks-','MarkerSize',MZ1);
        plot(z2,x3(m,:)','kp-','MarkerSize',MZ1);
        plot(z2,x4(m,:)','kd-','MarkerSize',MZ1);
        plot(z2,x5(m,:)','k*-','MarkerSize',MZ1);

        ley2 = {'$C{H_4}$','$C{O_2}$','$CO$','${H_2}$','${H_2}O$'};

        legend(ley2,'Interpreter','Latex',               ...
            'Location','north',                          ...
            'Orientation','horizontal',                  ...
            'FontSize',LFZ)

        xlabel('$z\left( {cm} \right)$',                 ...
        'FontSize',XLFZ,'interpreter','Latex')

        ylabel(TAG1{3},'FontSize',YLFZ,'interpreter','Latex') 

        ylim([0 0.8])

        max2 = max(z2); 
        xlim([0 max2])

    hold off
    print(fig2,'-dpdf','-r500',dir)
    close all
% -------------------------------------------------------------------------
end