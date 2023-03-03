function Global = globalDataFcn()
% -------------------------------------------------------------------------
      % globalData-function return a structure 'Global' with data constants
% -------------------------------------------------------------------------
% -------------------- | General Data |------------------------------------
      Global.R = 8.314472e-3;         % Universal Gas Constant    [kJ/molK]    
      Global.P = 1.01325;             % Pressure                      [bar]   
      Global.Tbed    = (623 + 273.15);% Temperature                     [K]
      Global.g       = 981.0;         % Gravity                     [cm/s2]
      Global.Num_esp = 18;            % number of species               [#]
      Global.gen     = 6;             % gas species number              [#]
      Global.sen     = 3;             % solid species number            [#]
      Global.iterations = Iterations.getInstance();% number of iterations
      Global.n       = 50;            % mesh points number              [#] 
% ----------| Flow rate and concentration of species |---------------------
% ----- total feed flow in the reactor's bottom ---------------------------
      %  Global.QT_in = 1200;           %  condicion_1         [STP ml/min]
      %  Global.QT_in = (pi*(4.6/2)^2)*4*60; % condicion_2     [STP ml/min]
      %  Global.QT_in = (pi*(4.6/2)^2)*3.4*60; % condicion_3   [STP ml/min]
         Global.QT_in = (pi*(4.6/2)^2)*3.3*60; % condicion_4   [STP ml/min]
% ----- flow feed ratio for each specie -----------------------------------
      CH4in_rat = 50.0;               % CH4                             [%]
      N2in_rat  = 50.0;               % N2                              [%]
% ----- flow feed for each specie -----------------------------------------
      FCH4in = (CH4in_rat/100)*Global.QT_in/(22.4*1000*60); %       [mol/s]
      FN2in  = ( N2in_rat/100)*Global.QT_in/(22.4*1000*60); %       [mol/s]
% ----- feed concentration for each specie --------------------------------
      Global.CH4in = (FCH4in*60/Global.QT_in); %                  [mol/cm3]
      Global.N2in  = ( FN2in*60/Global.QT_in); %                  [mol/cm3]

      if (Global.QT_in == 0) 
            Global.CH4in = 0;  Global.N2in = 0;  
      end
% -------------------------------------------------------------------------  
% ---------- reactor constant data  ---------------------------------------
      Global.reactor.rID     = 4.6;% internal diameter of the reactor  [cm]
      Global.reactor.bHeight = 23; % bed height                        [cm]
      Global.reactor.rHeight = 94; % reactor height                    [cm]
      Global.reactor.rArea   = pi*(Global.reactor.rID/2)^2; % area    [cm2]
      Global.reactor.zg      = linspace(0,                      ...
                                    Global.reactor.bHeight,      ...
                                    Global.n)'; % mesh                 [cm]
% ---------- fluid Dynamics -----------------------------------------------
      Global.fDynamics.usg0 = Global.QT_in./...
                              (Global.reactor.rArea*60.0); 
                                     % In-Flow rate                  [cm/s]
      Global.fDynamics.usg0_umf = 5; % ratio usg0/umf                    []
      Global.fDynamics.umf  = Global.fDynamics.usg0/... 
                              Global.fDynamics.usg0_umf;
                              % minimum fluidization velocity        [cm/s] 
      Global.fDynamics.fw   = 0.15;% fraction of wake in bubbles         []
      Global.fDynamics.Emf  = 0.45;% minimum fluidization porosity       []
% ---------- Carrier Data -------------------------------------------------
      Global.carrier.R       = 8.314472;  % Universal Gas Constant [J/molK] 
      Global.carrier.a0      = 1020000;   % specific surface area   [cm2/g]
      Global.carrier.C_NiO_o = 0.05;      % NiO concentration    [gNiO/g-c]
      Global.carrier.load    = 300;   % catalyst weight                 [g]
      Global.carrier.dp          = 0.014; % particle diameter          [cm]
      Global.carrier.bulkDensity = 1.1;   % particle density        [g/cm3]
      Global.carrier.density     = 0.785; % particle density        [g/cm3]
      Global.carrier.sphericity  = 0.95;  % particle sphericity          []
      Global.carrier.conversion  = 0.36;  % NiO conversion           []
% ---------- molar mass for each specie -----------------------------------
      Global.MMASS(1) = 16.0426;      % - CH4                       [g/mol]
      Global.MMASS(2) = 44.0090;      % - CO2                       [g/mol]
      Global.MMASS(3) = 28.0100;      % - CO                        [g/mol]
      Global.MMASS(4) = 2.01580;      % - H2                        [g/mol]
      Global.MMASS(5) = 18.0148;      % - H2O                       [g/mol]
      Global.MMASS(6) = 28.0140;      % - N2                        [g/mol] 
% ---------- Potentials for each compound - LENNARD-JONES -----------------
      Global.SIGMA(1) = 3.758;        % - CH4                           [A]
      Global.SIGMA(2) = 3.941;        % - CO2                           [A]
      Global.SIGMA(3) = 3.690;        % - CO                            [A]
      Global.SIGMA(4) = 2.827;        % - H2                            [A]
      Global.SIGMA(5) = 2.641;        % - H2O                           [A]
      Global.SIGMA(6) = 3.798;        % - N2                            [A]
      Global.EK(1)    = 148.6;        % - CH4                           [K]
      Global.EK(2)    = 195.2;        % - CO2                           [K]
      Global.EK(3)    = 91.70;        % - CO                            [K]
      Global.EK(4)    = 59.70;        % - H2                            [K]
      Global.EK(5)    = 809.1;        % - H2O                           [K]
      Global.EK(6)    = 71.40;        % - N2                            [K]
% -------------------------------------------------------------------------
end