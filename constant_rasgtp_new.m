function [T,Y,yinit,param, allNames, allValues] = constant_rasgtp_new(argTimeSpan,argYinit,argParam)
% [T,Y,yinit,param] = constant_rasgtp_new1(argTimeSpan,argYinit,argParam)
%
% input:
%     argTimeSpan is a vector of start and stop times (e.g. timeSpan = [0 10.0])
%     argYinit is a vector of initial conditions for the state variables (optional)
%     argParam is a vector of values for the parameters (optional)
%
% output:
%     T is the vector of times
%     Y is the vector of state variables
%     yinit is the initial conditions that were used
%     param is the parameter vector that was used
%     allNames is the output solution variable names
%     allValues is the output solution variable values corresponding to the names
%
%     example of running this file: [T,Y,yinit,param,allNames,allValues] = myMatlabFunc; <-(your main function name)
%

%
% Default time span
%
timeSpan = [0.0 240.0];

% output variable lengh and names
numVars = 140;
allNames = {'Ras_iBRaf';'Ras_Raf1_iBRaf_tetramer';'Ras_BRaf';'Ras_nfpRaf1';'iRaf1';'GTP_Ras';'Ras_pRaf1';'BRaf_iBRaf_dimer';'Ras_pRaf1_iBRaf_tetramer';'Ras_pRaf1_tetramer';'Ras_nfpiRaf1';'nfpiRaf1';'Ras_BRaf_pRaf1_tetramer';'Ras_pRaf1_Raf1_tetramer';'nfpRaf1';'Ras_nfpBRaf';'iBRaf';'pMEK';'pRaf1';'Ras_iRaf1';'Ras_nfpiBRaf';'Ras_Raf1';'nfpiBRaf';'nfpBRaf';'iBRaf_dimer';'Ras_BRaf_Raf1_tetramer';'BRaf_dimer';'pERK';'Ras_iRaf1_iBRaf1_tetramer';'Kf_iRaf_iBRaf_dim';'UnitFactor_uM_um3_molecules_neg_1';'K_Raf1_total';'Raf1';'Raf1_cyt_param';'K_BRaf_total';'BRaf';'Kf_nfpBRaf_dp';'J_nfpBRaf_dp';'Kf_Ras_iRaf_nfp';'J_Ras_iRaf_nfp';'Kf_Ras_Raf1_nfp';'Kf_nfpiBRaf_dp';'Kf_Ras_iBRaf_nfp';'Kf_nfpiRaf_dp';'J_nfpiRaf_dp';'K_sorafenib_total';'sorafenib';'Kf_nfpRaf1_ub';'J_nfpRaf1_ub';'K_Ras_Braf_iRaf1_tetramer_total';'Kr_Ras_Raf1_bind';'K_ERK_total';'ERK';'Kr_Ras_BRaf_bind';'Kf_iBRaf_dim';'K_MEK_total';'MEK';'Kf_MEK_dp';'J_MEK_dp';'Kf_iBRaf_Raf1_bind';'Kf_Ras_iBRaf_b';'Kr_Ras_iBRaf_b';'J_Ras_iBRaf_b';'Kf_ERK_p';'J_ERK_p';'Kf_nfpiBRaf_ub';'J_nfpiBRaf_ub';'Kf_BRaf_nfp';'J_BRaf_nfp';'Kr_iBRaf_Raf1_bind';'Kf_pRaf1_Raf1_bind';'Kf_pRaf1_dephosph';'J_pRaf1_dephosph';'Kf_nfpBRaf_ub';'Kf_Ras_Raf1_bind';'J_Ras_Raf1_bind';'Kf_pRaf1_Raf1_phosph';'J_pRaf1_Raf1_phosph';'Kf_Ras_BRaf_bind';'J_Ras_BRaf_bind';'Kr_BRaf_iBRaf_dim';'Kf_BRaf_iBRaf_dim';'Kf_sorafenib_Raf1_bind_cyt';'Kf_Raf1_iBRaf_p';'J_Raf1_iBRaf_p';'Kr_BRaf_dim';'Kf_Ras_pRaf1_dp';'Kr_iRaf_iBRaf_dim';'KFlux_pm_cytoplasm';'J_nfpBRaf_ub';'Kf_BRaf_Raf1_phosph';'J_BRaf_Raf1_phosph';'Kf_ERK_dp';'J_ERK_dp';'Kr_BRaf_Raf1_bind';'Kf_BRaf_Raf1_bind';'Kf_pRaf1_pRaf1_unbind';'Kr_pRaf1_pRaf1_unbind';'J_pRaf1_pRaf1_unbind';'active_Raf';'Kf_BRaf_pRaf1_unbind';'Kr_BRaf_pRaf1_unbind';'J_BRaf_pRaf1_unbind';'K_Ras_iRaf1_tetramer_total';'Kf_sorafenib_BRaf_bind_cyt';'J_iBRaf_Raf1_bind';'Kf_MEK_p';'J_MEK_p';'Kr_pRaf1_Raf1_bind';'Kr_pRaf1_iBRaf_ub';'Kf_pRaf1_iBRaf_ub';'J_pRaf1_iBRaf_ub';'J_Ras_Raf1_nfp';'Kf_BRaf_dim';'J_BRaf_dim';'Kf_nfpRaf1_dp';'Kr_sorafenib_Raf1_bind_cyt';'J_sorafenib_Raf1_bind_cyt';'Ras_Braf_iRaf1_tetramer';'Ras_iRaf1_tetramer';'Raf1_pm_param';'boundRaf_frac_parameter';'J_Ras_iBRaf_nfp';'J_nfpRaf1_dp';'J_BRaf_iBRaf_dim';'Kf_nfpiRaf1_ub';'Kr_Ras_pRaf1_unbind';'J_iRaf_iBRaf_dim';'J_Ras_pRaf1_dp';'Kr_iBRaf_dim';'J_nfpiBRaf_dp';'Kf_Ras_pRaf1_unbind';'J_Ras_pRaf1_unbind';'J_nfpiRaf1_ub';'Kr_sorafenib_BRaf_bind_cyt';'J_sorafenib_BRaf_bind_cyt';'J_pRaf1_Raf1_bind';'RasGTP_parameter';'J_BRaf_Raf1_bind';'J_iBRaf_dim';};

if nargin >= 1
	if length(argTimeSpan) > 0
		%
		% TimeSpan overridden by function arguments
		%
		timeSpan = argTimeSpan;
	end
end
%
% Default Initial Conditions
%
yinit = [
	0.0;		% yinit(1) is the initial condition for 'Ras_iBRaf'
	0.0;		% yinit(2) is the initial condition for 'Ras_Raf1_iBRaf_tetramer'
	0.0;		% yinit(3) is the initial condition for 'Ras_BRaf'
	0.0;		% yinit(4) is the initial condition for 'Ras_nfpRaf1'
	0.0;		% yinit(5) is the initial condition for 'iRaf1'
	27000.0;		% yinit(6) is the initial condition for 'GTP_Ras'
	0.0;		% yinit(7) is the initial condition for 'Ras_pRaf1'
	0.0;		% yinit(8) is the initial condition for 'BRaf_iBRaf_dimer'
	0.0;		% yinit(9) is the initial condition for 'Ras_pRaf1_iBRaf_tetramer'
	0.0;		% yinit(10) is the initial condition for 'Ras_pRaf1_tetramer'
	0.0;		% yinit(11) is the initial condition for 'Ras_nfpiRaf1'
	0.0;		% yinit(12) is the initial condition for 'nfpiRaf1'
	0.0;		% yinit(13) is the initial condition for 'Ras_BRaf_pRaf1_tetramer'
	0.0;		% yinit(14) is the initial condition for 'Ras_pRaf1_Raf1_tetramer'
	0.0;		% yinit(15) is the initial condition for 'nfpRaf1'
	0.0;		% yinit(16) is the initial condition for 'Ras_nfpBRaf'
	0.0;		% yinit(17) is the initial condition for 'iBRaf'
	0.0;		% yinit(18) is the initial condition for 'pMEK'
	0.0;		% yinit(19) is the initial condition for 'pRaf1'
	0.0;		% yinit(20) is the initial condition for 'Ras_iRaf1'
	0.0;		% yinit(21) is the initial condition for 'Ras_nfpiBRaf'
	0.0;		% yinit(22) is the initial condition for 'Ras_Raf1'
	0.0;		% yinit(23) is the initial condition for 'nfpiBRaf'
	0.0;		% yinit(24) is the initial condition for 'nfpBRaf'
	0.0;		% yinit(25) is the initial condition for 'iBRaf_dimer'
	0.0;		% yinit(26) is the initial condition for 'Ras_BRaf_Raf1_tetramer'
	0.0;		% yinit(27) is the initial condition for 'BRaf_dimer'
	0.0;		% yinit(28) is the initial condition for 'pERK'
	0.0;		% yinit(29) is the initial condition for 'Ras_iRaf1_iBRaf1_tetramer'
];
if nargin >= 2
	if length(argYinit) > 0
		%
		% initial conditions overridden by function arguments
		%
		yinit = argYinit;
	end
end
%
% Default Parameters
%   constants are only those "Constants" from the Math Description that are just floating point numbers (no identifiers)
%   note: constants of the form "A_init" are really initial conditions and are treated in "yinit"
%
param = [
	0.0;		% param(1) is 'Ras_iRaf1_tetramer_init_molecules_um_2'
	1.0;		% param(2) is 'netValence_Raf1_iBRaf_p'
	96480.0;		% param(3) is 'mlabfix_F_'
	0.0;		% param(4) is 'Ras_pRaf1_Raf1_tetramer_init_molecules_um_2'
	0.0;		% param(5) is 'Kr_ERK_p'
	1.0;		% param(6) is 'netValence_pRaf1_Raf1_bind'
	1.0;		% param(7) is 'netValence_iBRaf_dim'
	1.42262832362309E15;		% param(8) is 'Ds'
	0.0;		% param(9) is 'iRaf1_init_uM'
	0.0;		% param(10) is 'Kr_nfpBRaf_dp'
	0.0367;		% param(11) is 'kBr'
	0.0;		% param(12) is 'Kr_Ras_iRaf_nfp'
	2.47E-7;		% param(13) is 'kBf'
	0.0;		% param(14) is 'Kr_nfpiRaf_dp'
	27000.0;		% param(15) is 'GTP_Ras_init_molecules_um_2'
	5.37755813880742E16;		% param(16) is 'Cs'
	[8.40219666604696];		% param(17) is 'kR1r'
	1000.0;		% param(18) is 'BRaf_init_uM'
	0.0;		% param(19) is 'Kr_nfpRaf1_ub'
	0.0;		% param(20) is 'nfpBRaf_init_uM'
	[2.48732387708918e-05];		% param(21) is 'kR1f'
	3.30082007598438;		% param(22) is 'Bs'
	1.0;		% param(23) is 'netValence_BRaf_dim'
	1.0;		% param(24) is 'netValence_Ras_iBRaf_nfp'
	0.6;		% param(25) is 'kERKdp'
	21930.665775907;		% param(26) is 'As'
	6.0E-6;		% param(27) is 'kMEKp'
	1.0;		% param(28) is 'netValence_pRaf1_Raf1_phosph'
	0.0;		% param(29) is 'Kr_Ras_iBRaf_nfp'
	0.0;		% param(30) is 'Ras_BRaf_init_molecules_um_2'
	0.0;		% param(31) is 'Ras_iRaf1_iBRaf1_tetramer_init_molecules_um_2'
	1.0;		% param(32) is 'netValence_nfpBRaf_ub'
	0.0;		% param(33) is 'Ras_pRaf1_tetramer_init_molecules_um_2'
	0.0;		% param(34) is 'nfpiRaf1_init_uM'
	1000.0;		% param(35) is 'K_millivolts_per_volt'
	1.0E-9;		% param(36) is 'mlabfix_K_GHK_'
	6.0E-7;		% param(37) is 'knfpBR1'
	0.0;		% param(38) is 'Ras_BRaf_pRaf1_tetramer_init_molecules_um_2'
	1.0;		% param(39) is 'netValence_pRaf1_pRaf1_unbind'
	186.0;		% param(40) is 'kpR1'
	0.0;		% param(41) is 'pMEK_init_uM'
	0.0;		% param(42) is 'Ras_nfpRaf1_init_molecules_um_2'
	0.0;		% param(43) is 'Kr_BRaf_Raf1_phosph'
	0.0;		% param(44) is 'Ras_iBRaf_init_molecules_um_2'
	9.648E-5;		% param(45) is 'mlabfix_F_nmol_'
	0.0;		% param(46) is 'Kr_Raf1_iBRaf_p'
	100000.0;		% param(47) is 'kSon'
	0.0;		% param(48) is 'Kr_pRaf1_Raf1_phosph'
	0.0;		% param(49) is 'Kr_pRaf1_dephosph'
	0.212;		% param(50) is 'kiR1r'
	0.0;		% param(51) is 'Kr_nfpBRaf_ub'
	0.0;		% param(52) is 'Kr_MEK_p'
	300.0;		% param(53) is 'mlabfix_T_'
	1.0;		% param(54) is 'netValence_Ras_pRaf1_unbind'
	1.84E-7;		% param(55) is 'kiR1f'
	0.0;		% param(56) is 'Kr_MEK_dp'
	1.0;		% param(57) is 'Size_cytoplasm'
	420.0;		% param(58) is 'kSoff'
	1.0;		% param(59) is 'netValence_pRaf1_iBRaf_ub'
	1.0;		% param(60) is 'netValence_BRaf_pRaf1_unbind'
	0.0;		% param(61) is 'Kr_nfpiBRaf_dp'
	8314.0;		% param(62) is 'mlabfix_R_'
	0.0;		% param(63) is 'iBRaf_dimer_init_molecules_um_2'
	0.0;		% param(64) is 'Ras_Braf_iRaf1_tetramer_init_molecules_um_2'
	1.0;		% param(65) is 'netValence_Ras_pRaf1_dp'
	0.0;		% param(66) is 'Kr_nfpiRaf1_ub'
	0.0;		% param(67) is 'Ras_pRaf1_iBRaf_tetramer_init_molecules_um_2'
	0.0;		% param(68) is 'Voltage_pm'
	0.0;		% param(69) is 'pRaf1_init_uM'
	1.0;		% param(70) is 'netValence_nfpiRaf1_ub'
	0.6;		% param(71) is 'kMEKdp'
	1.0;		% param(72) is 'netValence_Ras_Raf1_nfp'
	111.0;		% param(73) is 'kdR1r'
	0.0367;		% param(74) is 'kiBr'
	0.0191;		% param(75) is 'kdR1f'
	0.0;		% param(76) is 'sorafenib_init_uM'
	2.47E-7;		% param(77) is 'kiBf'
	6.0E-5;		% param(78) is 'kERKp'
	0.0;		% param(79) is 'Ras_nfpBRaf_init_molecules_um_2'
	0.367;		% param(80) is 'kfpBr'
	1.0;		% param(81) is 'netValence_BRaf_iBRaf_dim'
	0.0;		% param(82) is 'pERK_init_uM'
	0.0;		% param(83) is 'Kr_ERK_dp'
	1.0;		% param(84) is 'netValence_iRaf_iBRaf_dim'
	1.0;		% param(85) is 'netValence_iBRaf_Raf1_bind'
	0.0;		% param(86) is 'iBRaf_init_uM'
	1.0;		% param(87) is 'netValence_Ras_iRaf_nfp'
	1.0;		% param(88) is 'netValence_Ras_Raf1_bind'
	1.0;		% param(89) is 'netValence_BRaf_nfp'
	500000.0;		% param(90) is 'MEK_init_uM'
	1256.6370614359173;		% param(91) is 'pm_sa'
	1.0;		% param(92) is 'netValence_Ras_BRaf_bind'
	3.141592653589793;		% param(93) is 'mlabfix_PI_'
	0.06;		% param(94) is 'kdpR1'
	12000.0;		% param(95) is 'Raf1_init_uM'
	0.0;		% param(96) is 'nfpRaf1_init_uM'
	0.0;		% param(97) is 'BRaf_dimer_init_molecules_um_2'
	0.0;		% param(98) is 'Kr_nfpRaf1_dp'
	0.0;		% param(99) is 'Kr_nfpiBRaf_ub'
	1.0;		% param(100) is 'netValence_BRaf_Raf1_bind'
	1.0;		% param(101) is 'netValence_Ras_iBRaf_b'
	0.0;		% param(102) is 'Ras_Raf1_iBRaf_tetramer_init_molecules_um_2'
	0.0;		% param(103) is 'BRaf_iBRaf_dimer_init_molecules_um_2'
	600000.0;		% param(104) is 'ERK_init_uM'
	1.0;		% param(105) is 'netValence_nfpiBRaf_ub'
	0.0;		% param(106) is 'Kr_BRaf_nfp'
	6.02E11;		% param(107) is 'mlabfix_N_pmol_'
	0.0;		% param(108) is 'Ras_pRaf1_init_molecules_um_2'
	0.0;		% param(109) is 'Ras_nfpiRaf1_init_molecules_um_2'
	1.1735E15;		% param(110) is 'D'
	6.7089E16;		% param(111) is 'C'
	3.6724;		% param(112) is 'B'
	20671.0;		% param(113) is 'A'
	0.0;		% param(114) is 'Ras_Raf1_init_molecules_um_2'
	0.0;		% param(115) is 'Kr_Ras_pRaf1_dp'
	(1.0 ./ 602.0);		% param(116) is 'KMOLE'
	0.0;		% param(117) is 'nfpiBRaf_init_uM'
	0.0;		% param(118) is 'Ras_nfpiBRaf_init_molecules_um_2'
	1.0;		% param(119) is 'Size_pm'
	1.0;		% param(120) is 'netValence_BRaf_Raf1_phosph'
	0.0;		% param(121) is 'Ras_BRaf_Raf1_tetramer_init_molecules_um_2'
	0.0;		% param(122) is 'Kr_Ras_Raf1_nfp'
	0.0;		% param(123) is 'Ras_iRaf1_init_molecules_um_2'
	2.12;		% param(124) is 'kfpR1r'
	1.0;		% param(125) is 'netValence_nfpRaf1_ub'
];
if nargin >= 3
	if length(argParam) > 0
		%
		% parameter values overridden by function arguments
		%
		param = argParam;
	end
end
%
% invoke the integrator
%
[T,Y] = ode15s(@f,timeSpan,yinit,odeset,param,yinit);

% get the solution
all = zeros(length(T), numVars);
for i = 1:length(T)
	all(i,:) = getRow(T(i), Y(i,:), yinit, param);
end

allValues = all;
end

% -------------------------------------------------------
% get row data
function rowValue = getRow(t,y,y0,p)
	% State Variables
	Ras_iBRaf = y(1);
	Ras_Raf1_iBRaf_tetramer = y(2);
	Ras_BRaf = y(3);
	Ras_nfpRaf1 = y(4);
	iRaf1 = y(5);
	GTP_Ras = y(6);
	Ras_pRaf1 = y(7);
	BRaf_iBRaf_dimer = y(8);
	Ras_pRaf1_iBRaf_tetramer = y(9);
	Ras_pRaf1_tetramer = y(10);
	Ras_nfpiRaf1 = y(11);
	nfpiRaf1 = y(12);
	Ras_BRaf_pRaf1_tetramer = y(13);
	Ras_pRaf1_Raf1_tetramer = y(14);
	nfpRaf1 = y(15);
	Ras_nfpBRaf = y(16);
	iBRaf = y(17);
	pMEK = y(18);
	pRaf1 = y(19);
	Ras_iRaf1 = y(20);
	Ras_nfpiBRaf = y(21);
	Ras_Raf1 = y(22);
	nfpiBRaf = y(23);
	nfpBRaf = y(24);
	iBRaf_dimer = y(25);
	Ras_BRaf_Raf1_tetramer = y(26);
	BRaf_dimer = y(27);
	pERK = y(28);
	Ras_iRaf1_iBRaf1_tetramer = y(29);
	% Constants
	Ras_iRaf1_tetramer_init_molecules_um_2 = p(1);
	netValence_Raf1_iBRaf_p = p(2);
	mlabfix_F_ = p(3);
	Ras_pRaf1_Raf1_tetramer_init_molecules_um_2 = p(4);
	Kr_ERK_p = p(5);
	netValence_pRaf1_Raf1_bind = p(6);
	netValence_iBRaf_dim = p(7);
	Ds = p(8);
	iRaf1_init_uM = p(9);
	Kr_nfpBRaf_dp = p(10);
	kBr = p(11);
	Kr_Ras_iRaf_nfp = p(12);
	kBf = p(13);
	Kr_nfpiRaf_dp = p(14);
	GTP_Ras_init_molecules_um_2 = p(15);
	Cs = p(16);
	kR1r = p(17);
	BRaf_init_uM = p(18);
	Kr_nfpRaf1_ub = p(19);
	nfpBRaf_init_uM = p(20);
	kR1f = p(21);
	Bs = p(22);
	netValence_BRaf_dim = p(23);
	netValence_Ras_iBRaf_nfp = p(24);
	kERKdp = p(25);
	As = p(26);
	kMEKp = p(27);
	netValence_pRaf1_Raf1_phosph = p(28);
	Kr_Ras_iBRaf_nfp = p(29);
	Ras_BRaf_init_molecules_um_2 = p(30);
	Ras_iRaf1_iBRaf1_tetramer_init_molecules_um_2 = p(31);
	netValence_nfpBRaf_ub = p(32);
	Ras_pRaf1_tetramer_init_molecules_um_2 = p(33);
	nfpiRaf1_init_uM = p(34);
	K_millivolts_per_volt = p(35);
	mlabfix_K_GHK_ = p(36);
	knfpBR1 = p(37);
	Ras_BRaf_pRaf1_tetramer_init_molecules_um_2 = p(38);
	netValence_pRaf1_pRaf1_unbind = p(39);
	kpR1 = p(40);
	pMEK_init_uM = p(41);
	Ras_nfpRaf1_init_molecules_um_2 = p(42);
	Kr_BRaf_Raf1_phosph = p(43);
	Ras_iBRaf_init_molecules_um_2 = p(44);
	mlabfix_F_nmol_ = p(45);
	Kr_Raf1_iBRaf_p = p(46);
	kSon = p(47);
	Kr_pRaf1_Raf1_phosph = p(48);
	Kr_pRaf1_dephosph = p(49);
	kiR1r = p(50);
	Kr_nfpBRaf_ub = p(51);
	Kr_MEK_p = p(52);
	mlabfix_T_ = p(53);
	netValence_Ras_pRaf1_unbind = p(54);
	kiR1f = p(55);
	Kr_MEK_dp = p(56);
	Size_cytoplasm = p(57);
	kSoff = p(58);
	netValence_pRaf1_iBRaf_ub = p(59);
	netValence_BRaf_pRaf1_unbind = p(60);
	Kr_nfpiBRaf_dp = p(61);
	mlabfix_R_ = p(62);
	iBRaf_dimer_init_molecules_um_2 = p(63);
	Ras_Braf_iRaf1_tetramer_init_molecules_um_2 = p(64);
	netValence_Ras_pRaf1_dp = p(65);
	Kr_nfpiRaf1_ub = p(66);
	Ras_pRaf1_iBRaf_tetramer_init_molecules_um_2 = p(67);
	Voltage_pm = p(68);
	pRaf1_init_uM = p(69);
	netValence_nfpiRaf1_ub = p(70);
	kMEKdp = p(71);
	netValence_Ras_Raf1_nfp = p(72);
	kdR1r = p(73);
	kiBr = p(74);
	kdR1f = p(75);
	sorafenib_init_uM = p(76);
	kiBf = p(77);
	kERKp = p(78);
	Ras_nfpBRaf_init_molecules_um_2 = p(79);
	kfpBr = p(80);
	netValence_BRaf_iBRaf_dim = p(81);
	pERK_init_uM = p(82);
	Kr_ERK_dp = p(83);
	netValence_iRaf_iBRaf_dim = p(84);
	netValence_iBRaf_Raf1_bind = p(85);
	iBRaf_init_uM = p(86);
	netValence_Ras_iRaf_nfp = p(87);
	netValence_Ras_Raf1_bind = p(88);
	netValence_BRaf_nfp = p(89);
	MEK_init_uM = p(90);
	pm_sa = p(91);
	netValence_Ras_BRaf_bind = p(92);
	mlabfix_PI_ = p(93);
	kdpR1 = p(94);
	Raf1_init_uM = p(95);
	nfpRaf1_init_uM = p(96);
	BRaf_dimer_init_molecules_um_2 = p(97);
	Kr_nfpRaf1_dp = p(98);
	Kr_nfpiBRaf_ub = p(99);
	netValence_BRaf_Raf1_bind = p(100);
	netValence_Ras_iBRaf_b = p(101);
	Ras_Raf1_iBRaf_tetramer_init_molecules_um_2 = p(102);
	BRaf_iBRaf_dimer_init_molecules_um_2 = p(103);
	ERK_init_uM = p(104);
	netValence_nfpiBRaf_ub = p(105);
	Kr_BRaf_nfp = p(106);
	mlabfix_N_pmol_ = p(107);
	Ras_pRaf1_init_molecules_um_2 = p(108);
	Ras_nfpiRaf1_init_molecules_um_2 = p(109);
	D = p(110);
	C = p(111);
	B = p(112);
	A = p(113);
	Ras_Raf1_init_molecules_um_2 = p(114);
	Kr_Ras_pRaf1_dp = p(115);
	KMOLE = p(116);
	nfpiBRaf_init_uM = p(117);
	Ras_nfpiBRaf_init_molecules_um_2 = p(118);
	Size_pm = p(119);
	netValence_BRaf_Raf1_phosph = p(120);
	Ras_BRaf_Raf1_tetramer_init_molecules_um_2 = p(121);
	Kr_Ras_Raf1_nfp = p(122);
	Ras_iRaf1_init_molecules_um_2 = p(123);
	kfpR1r = p(124);
	netValence_nfpRaf1_ub = p(125);
	% Functions
	Kf_iRaf_iBRaf_dim = kdR1f;
	UnitFactor_uM_um3_molecules_neg_1 = (1.0 ./ 1.0);
	K_Raf1_total = ((Size_cytoplasm .* Raf1_init_uM) + (Size_cytoplasm .* pRaf1_init_uM) + (Size_cytoplasm .* iRaf1_init_uM) + (Size_cytoplasm .* nfpRaf1_init_uM) + (Size_cytoplasm .* nfpiRaf1_init_uM) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_init_molecules_um_2) + (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_Raf1_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_Raf1_tetramer_init_molecules_um_2) + (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_pRaf1_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpRaf1_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiRaf1_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer_init_molecules_um_2));
	Raf1 = ((K_Raf1_total - (Size_cytoplasm .* pRaf1) - (Size_cytoplasm .* iRaf1) - (Size_cytoplasm .* nfpRaf1) - (Size_cytoplasm .* nfpiRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1) - (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_Raf1_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_Raf1_tetramer) - (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_pRaf1_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer)) ./ Size_cytoplasm);
	Raf1_cyt_param = (Raf1 + pRaf1 + iRaf1 + nfpRaf1 + nfpiRaf1);
	K_BRaf_total = ((Size_cytoplasm .* BRaf_init_uM) + (Size_cytoplasm .* iBRaf_init_uM) + (Size_cytoplasm .* nfpBRaf_init_uM) + (Size_cytoplasm .* nfpiBRaf_init_uM) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_Raf1_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_pRaf1_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* iBRaf_dimer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_dimer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iBRaf_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpBRaf_init_molecules_um_2) + (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_iBRaf_dimer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiBRaf_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer_init_molecules_um_2));
	BRaf = ((K_BRaf_total - (Size_cytoplasm .* iBRaf) - (Size_cytoplasm .* nfpBRaf) - (Size_cytoplasm .* nfpiBRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_Raf1_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_pRaf1_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* iBRaf_dimer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_dimer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iBRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpBRaf) - (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_iBRaf_dimer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiBRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer)) ./ Size_cytoplasm);
	Kf_nfpBRaf_dp = kdpR1;
	J_nfpBRaf_dp = ((Kf_nfpBRaf_dp .* nfpBRaf) - (Kr_nfpBRaf_dp .* BRaf));
	Kf_Ras_iRaf_nfp = (kpR1 .* pERK);
	J_Ras_iRaf_nfp = ((Kf_Ras_iRaf_nfp .* Ras_iRaf1) - (Kr_Ras_iRaf_nfp .* Ras_nfpiRaf1));
	Kf_Ras_Raf1_nfp = (knfpBR1 .* pERK);
	Kf_nfpiBRaf_dp = kdpR1;
	Kf_Ras_iBRaf_nfp = (knfpBR1 .* pERK);
	Kf_nfpiRaf_dp = kdpR1;
	J_nfpiRaf_dp = ((Kf_nfpiRaf_dp .* nfpiRaf1) - (Kr_nfpiRaf_dp .* iRaf1));
	K_sorafenib_total = ((Size_cytoplasm .* sorafenib_init_uM) + (Size_cytoplasm .* iRaf1_init_uM) + (Size_cytoplasm .* iBRaf_init_uM) + (Size_cytoplasm .* nfpiBRaf_init_uM) + (Size_cytoplasm .* nfpiRaf1_init_uM) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* iBRaf_dimer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iBRaf_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_iBRaf_dimer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiBRaf_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiRaf1_init_molecules_um_2) + (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer_init_molecules_um_2));
	sorafenib = ((K_sorafenib_total - (Size_cytoplasm .* iRaf1) - (Size_cytoplasm .* iBRaf) - (Size_cytoplasm .* nfpiBRaf) - (Size_cytoplasm .* nfpiRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* iBRaf_dimer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iBRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_iBRaf_dimer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiBRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiRaf1) - (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer)) ./ Size_cytoplasm);
	Kf_nfpRaf1_ub = kfpR1r;
	J_nfpRaf1_ub = ((Kf_nfpRaf1_ub .* Ras_nfpRaf1) - ((Kr_nfpRaf1_ub .* GTP_Ras) .* nfpRaf1));
	K_Ras_Braf_iRaf1_tetramer_total = (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Braf_iRaf1_tetramer_init_molecules_um_2);
	Kr_Ras_Raf1_bind = kR1r;
	K_ERK_total = ((Size_cytoplasm .* ERK_init_uM) + (Size_cytoplasm .* pERK_init_uM));
	ERK = ((K_ERK_total - (Size_cytoplasm .* pERK)) ./ Size_cytoplasm);
	Kr_Ras_BRaf_bind = kBr;
	Kf_iBRaf_dim = kdR1f;
	K_MEK_total = ((Size_cytoplasm .* MEK_init_uM) + (Size_cytoplasm .* pMEK_init_uM));
	MEK = ((K_MEK_total - (Size_cytoplasm .* pMEK)) ./ Size_cytoplasm);
	Kf_MEK_dp = kMEKdp;
	J_MEK_dp = ((Kf_MEK_dp .* pMEK) - (Kr_MEK_dp .* MEK));
	Kf_iBRaf_Raf1_bind = kdR1f;
	Kf_Ras_iBRaf_b = kiBf;
	Kr_Ras_iBRaf_b = kiBr;
	J_Ras_iBRaf_b = ((Kf_Ras_iBRaf_b .* iBRaf) - (Kr_Ras_iBRaf_b .* Ras_iBRaf));
	Kf_ERK_p = (kERKp .* pMEK);
	J_ERK_p = ((Kf_ERK_p .* ERK) - (Kr_ERK_p .* pERK));
	Kf_nfpiBRaf_ub = kfpBr;
	J_nfpiBRaf_ub = ((Kf_nfpiBRaf_ub .* Ras_nfpiBRaf) - ((Kr_nfpiBRaf_ub .* nfpiBRaf) .* GTP_Ras));
	Kf_BRaf_nfp = (knfpBR1 .* pERK);
	J_BRaf_nfp = ((Kf_BRaf_nfp .* Ras_BRaf) - (Kr_BRaf_nfp .* Ras_nfpBRaf));
	Kr_iBRaf_Raf1_bind = kdR1r;
	Kf_pRaf1_Raf1_bind = kdR1f;
	Kf_pRaf1_dephosph = kdpR1;
	J_pRaf1_dephosph = ((Kf_pRaf1_dephosph .* pRaf1) - (Kr_pRaf1_dephosph .* Raf1));
	Kf_nfpBRaf_ub = kfpBr;
	Kf_Ras_Raf1_bind = kR1f;
	J_Ras_Raf1_bind = (((Kf_Ras_Raf1_bind .* GTP_Ras) .* Raf1) - (Kr_Ras_Raf1_bind .* Ras_Raf1));
	Kf_pRaf1_Raf1_phosph = kpR1;
	J_pRaf1_Raf1_phosph = ((Kf_pRaf1_Raf1_phosph .* Ras_pRaf1_Raf1_tetramer) - (Kr_pRaf1_Raf1_phosph .* Ras_pRaf1_tetramer));
	Kf_Ras_BRaf_bind = kBf;
	J_Ras_BRaf_bind = (((Kf_Ras_BRaf_bind .* BRaf) .* GTP_Ras) - (Kr_Ras_BRaf_bind .* Ras_BRaf));
	Kr_BRaf_iBRaf_dim = kdR1r;
	Kf_BRaf_iBRaf_dim = kdR1f;
	Kf_sorafenib_Raf1_bind_cyt = kSon;
	Kf_Raf1_iBRaf_p = kpR1;
	J_Raf1_iBRaf_p = ((Kf_Raf1_iBRaf_p .* Ras_Raf1_iBRaf_tetramer) - (Kr_Raf1_iBRaf_p .* Ras_pRaf1_iBRaf_tetramer));
	Kr_BRaf_dim = kdR1r;
	Kf_Ras_pRaf1_dp = kdpR1;
	Kr_iRaf_iBRaf_dim = kdR1r;
	KFlux_pm_cytoplasm = (Size_pm ./ Size_cytoplasm);
	J_nfpBRaf_ub = ((Kf_nfpBRaf_ub .* Ras_nfpBRaf) - ((Kr_nfpBRaf_ub .* nfpBRaf) .* GTP_Ras));
	Kf_BRaf_Raf1_phosph = kpR1;
	J_BRaf_Raf1_phosph = ((Kf_BRaf_Raf1_phosph .* Ras_BRaf_Raf1_tetramer) - (Kr_BRaf_Raf1_phosph .* Ras_BRaf_pRaf1_tetramer));
	Kf_ERK_dp = kERKdp;
	J_ERK_dp = ((Kf_ERK_dp .* pERK) - (Kr_ERK_dp .* ERK));
	Kr_BRaf_Raf1_bind = kdR1r;
	Kf_BRaf_Raf1_bind = kdR1f;
	Kf_pRaf1_pRaf1_unbind = kdR1r;
	Kr_pRaf1_pRaf1_unbind = kdR1f;
	J_pRaf1_pRaf1_unbind = ((Kf_pRaf1_pRaf1_unbind .* Ras_pRaf1_tetramer) - (Kr_pRaf1_pRaf1_unbind .* (Ras_pRaf1 ^ 2.0)));
	active_Raf = ((2.0 .* BRaf_dimer) + Ras_BRaf_Raf1_tetramer + (2.0 .* Ras_BRaf_pRaf1_tetramer) + Ras_pRaf1_iBRaf_tetramer + Ras_pRaf1 + Ras_pRaf1_Raf1_tetramer + (2.0 .* Ras_pRaf1_tetramer) + pRaf1 + BRaf_iBRaf_dimer);
	Kf_BRaf_pRaf1_unbind = kdR1r;
	Kr_BRaf_pRaf1_unbind = kdR1f;
	J_BRaf_pRaf1_unbind = ((Kf_BRaf_pRaf1_unbind .* Ras_BRaf_pRaf1_tetramer) - ((Kr_BRaf_pRaf1_unbind .* Ras_BRaf) .* Ras_pRaf1));
	K_Ras_iRaf1_tetramer_total = (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_tetramer_init_molecules_um_2);
	Kf_sorafenib_BRaf_bind_cyt = kSon;
	J_iBRaf_Raf1_bind = (((Kf_iBRaf_Raf1_bind .* Ras_Raf1) .* Ras_iBRaf) - (Kr_iBRaf_Raf1_bind .* Ras_Raf1_iBRaf_tetramer));
	Kf_MEK_p = (kMEKp .* active_Raf);
	J_MEK_p = ((Kf_MEK_p .* MEK) - (Kr_MEK_p .* pMEK));
	Kr_pRaf1_Raf1_bind = kdR1r;
	Kr_pRaf1_iBRaf_ub = kdR1f;
	Kf_pRaf1_iBRaf_ub = kdR1r;
	J_pRaf1_iBRaf_ub = ((Kf_pRaf1_iBRaf_ub .* Ras_pRaf1_iBRaf_tetramer) - ((Kr_pRaf1_iBRaf_ub .* Ras_iBRaf) .* Ras_pRaf1));
	J_Ras_Raf1_nfp = ((Kf_Ras_Raf1_nfp .* Ras_Raf1) - (Kr_Ras_Raf1_nfp .* Ras_nfpRaf1));
	Kf_BRaf_dim = kdR1f;
	J_BRaf_dim = ((Kf_BRaf_dim .* Ras_BRaf) - (Kr_BRaf_dim .* BRaf_dimer));
	Kf_nfpRaf1_dp = kdpR1;
	Kr_sorafenib_Raf1_bind_cyt = kSoff;
	J_sorafenib_Raf1_bind_cyt = (((Kf_sorafenib_Raf1_bind_cyt .* Raf1) .* sorafenib) - (Kr_sorafenib_Raf1_bind_cyt .* iRaf1));
	Ras_Braf_iRaf1_tetramer = (K_Ras_Braf_iRaf1_tetramer_total ./ (Size_pm .* UnitFactor_uM_um3_molecules_neg_1));
	Ras_iRaf1_tetramer = (K_Ras_iRaf1_tetramer_total ./ (Size_pm .* UnitFactor_uM_um3_molecules_neg_1));
	Raf1_pm_param = (Ras_pRaf1 + (2.0 .* Ras_pRaf1_Raf1_tetramer) + Ras_BRaf_Raf1_tetramer + Ras_iRaf1 + Ras_Raf1 + (2.0 .* Ras_iRaf1_tetramer) + Ras_Braf_iRaf1_tetramer + Ras_BRaf_pRaf1_tetramer + (2.0 .* Ras_pRaf1_tetramer) + Ras_nfpiRaf1 + Ras_nfpRaf1 + Ras_iRaf1_iBRaf1_tetramer + Ras_Raf1_iBRaf_tetramer + Ras_pRaf1_iBRaf_tetramer);
	boundRaf_frac_parameter = (Raf1_pm_param ./ (Raf1_cyt_param + Raf1_pm_param));
	J_Ras_iBRaf_nfp = ((Kf_Ras_iBRaf_nfp .* Ras_iBRaf) - (Kr_Ras_iBRaf_nfp .* Ras_nfpiBRaf));
	J_nfpRaf1_dp = ((Kf_nfpRaf1_dp .* nfpRaf1) - (Kr_nfpRaf1_dp .* Raf1));
	J_BRaf_iBRaf_dim = (((Kf_BRaf_iBRaf_dim .* Ras_BRaf) .* Ras_iBRaf) - (Kr_BRaf_iBRaf_dim .* BRaf_iBRaf_dimer));
	Kf_nfpiRaf1_ub = kfpR1r;
	Kr_Ras_pRaf1_unbind = kR1f;
	J_iRaf_iBRaf_dim = (((Kf_iRaf_iBRaf_dim .* Ras_iRaf1) .* Ras_iBRaf) - (Kr_iRaf_iBRaf_dim .* Ras_iRaf1_iBRaf1_tetramer));
	J_Ras_pRaf1_dp = ((Kf_Ras_pRaf1_dp .* Ras_pRaf1) - (Kr_Ras_pRaf1_dp .* Ras_Raf1));
	Kr_iBRaf_dim = kdR1r;
	J_nfpiBRaf_dp = ((Kf_nfpiBRaf_dp .* nfpiBRaf) - (Kr_nfpiBRaf_dp .* iBRaf));
	Kf_Ras_pRaf1_unbind = kR1r;
	J_Ras_pRaf1_unbind = ((Kf_Ras_pRaf1_unbind .* Ras_pRaf1) - ((Kr_Ras_pRaf1_unbind .* pRaf1) .* GTP_Ras));
	J_nfpiRaf1_ub = ((Kf_nfpiRaf1_ub .* Ras_nfpiRaf1) - ((Kr_nfpiRaf1_ub .* nfpiRaf1) .* GTP_Ras));
	Kr_sorafenib_BRaf_bind_cyt = kSoff;
	J_sorafenib_BRaf_bind_cyt = (((Kf_sorafenib_BRaf_bind_cyt .* sorafenib) .* BRaf) - (Kr_sorafenib_BRaf_bind_cyt .* iBRaf));
	J_pRaf1_Raf1_bind = (((Kf_pRaf1_Raf1_bind .* Ras_pRaf1) .* Ras_Raf1) - (Kr_pRaf1_Raf1_bind .* Ras_pRaf1_Raf1_tetramer));
	RasGTP_parameter = (GTP_Ras + (2.0 .* (Ras_iRaf1_tetramer + Ras_Braf_iRaf1_tetramer + Ras_BRaf_Raf1_tetramer + Ras_pRaf1_Raf1_tetramer + Ras_BRaf_pRaf1_tetramer + Ras_pRaf1_tetramer + BRaf_dimer + BRaf_iBRaf_dimer + iBRaf_dimer + Ras_iRaf1_iBRaf1_tetramer + Ras_Raf1_iBRaf_tetramer + Ras_pRaf1_iBRaf_tetramer)) + Ras_BRaf + Ras_iRaf1 + Ras_pRaf1 + Ras_Raf1 + Ras_nfpRaf1 + Ras_nfpiRaf1 + Ras_iBRaf + Ras_nfpiBRaf + Ras_nfpBRaf);
	J_BRaf_Raf1_bind = (((Kf_BRaf_Raf1_bind .* Ras_BRaf) .* Ras_Raf1) - (Kr_BRaf_Raf1_bind .* Ras_BRaf_Raf1_tetramer));
	J_iBRaf_dim = ((Kf_iBRaf_dim .* Ras_iBRaf) - (Kr_iBRaf_dim .* iBRaf_dimer));

	rowValue = [Ras_iBRaf Ras_Raf1_iBRaf_tetramer Ras_BRaf Ras_nfpRaf1 iRaf1 GTP_Ras Ras_pRaf1 BRaf_iBRaf_dimer Ras_pRaf1_iBRaf_tetramer Ras_pRaf1_tetramer Ras_nfpiRaf1 nfpiRaf1 Ras_BRaf_pRaf1_tetramer Ras_pRaf1_Raf1_tetramer nfpRaf1 Ras_nfpBRaf iBRaf pMEK pRaf1 Ras_iRaf1 Ras_nfpiBRaf Ras_Raf1 nfpiBRaf nfpBRaf iBRaf_dimer Ras_BRaf_Raf1_tetramer BRaf_dimer pERK Ras_iRaf1_iBRaf1_tetramer Kf_iRaf_iBRaf_dim UnitFactor_uM_um3_molecules_neg_1 K_Raf1_total Raf1 Raf1_cyt_param K_BRaf_total BRaf Kf_nfpBRaf_dp J_nfpBRaf_dp Kf_Ras_iRaf_nfp J_Ras_iRaf_nfp Kf_Ras_Raf1_nfp Kf_nfpiBRaf_dp Kf_Ras_iBRaf_nfp Kf_nfpiRaf_dp J_nfpiRaf_dp K_sorafenib_total sorafenib Kf_nfpRaf1_ub J_nfpRaf1_ub K_Ras_Braf_iRaf1_tetramer_total Kr_Ras_Raf1_bind K_ERK_total ERK Kr_Ras_BRaf_bind Kf_iBRaf_dim K_MEK_total MEK Kf_MEK_dp J_MEK_dp Kf_iBRaf_Raf1_bind Kf_Ras_iBRaf_b Kr_Ras_iBRaf_b J_Ras_iBRaf_b Kf_ERK_p J_ERK_p Kf_nfpiBRaf_ub J_nfpiBRaf_ub Kf_BRaf_nfp J_BRaf_nfp Kr_iBRaf_Raf1_bind Kf_pRaf1_Raf1_bind Kf_pRaf1_dephosph J_pRaf1_dephosph Kf_nfpBRaf_ub Kf_Ras_Raf1_bind J_Ras_Raf1_bind Kf_pRaf1_Raf1_phosph J_pRaf1_Raf1_phosph Kf_Ras_BRaf_bind J_Ras_BRaf_bind Kr_BRaf_iBRaf_dim Kf_BRaf_iBRaf_dim Kf_sorafenib_Raf1_bind_cyt Kf_Raf1_iBRaf_p J_Raf1_iBRaf_p Kr_BRaf_dim Kf_Ras_pRaf1_dp Kr_iRaf_iBRaf_dim KFlux_pm_cytoplasm J_nfpBRaf_ub Kf_BRaf_Raf1_phosph J_BRaf_Raf1_phosph Kf_ERK_dp J_ERK_dp Kr_BRaf_Raf1_bind Kf_BRaf_Raf1_bind Kf_pRaf1_pRaf1_unbind Kr_pRaf1_pRaf1_unbind J_pRaf1_pRaf1_unbind active_Raf Kf_BRaf_pRaf1_unbind Kr_BRaf_pRaf1_unbind J_BRaf_pRaf1_unbind K_Ras_iRaf1_tetramer_total Kf_sorafenib_BRaf_bind_cyt J_iBRaf_Raf1_bind Kf_MEK_p J_MEK_p Kr_pRaf1_Raf1_bind Kr_pRaf1_iBRaf_ub Kf_pRaf1_iBRaf_ub J_pRaf1_iBRaf_ub J_Ras_Raf1_nfp Kf_BRaf_dim J_BRaf_dim Kf_nfpRaf1_dp Kr_sorafenib_Raf1_bind_cyt J_sorafenib_Raf1_bind_cyt Ras_Braf_iRaf1_tetramer Ras_iRaf1_tetramer Raf1_pm_param boundRaf_frac_parameter J_Ras_iBRaf_nfp J_nfpRaf1_dp J_BRaf_iBRaf_dim Kf_nfpiRaf1_ub Kr_Ras_pRaf1_unbind J_iRaf_iBRaf_dim J_Ras_pRaf1_dp Kr_iBRaf_dim J_nfpiBRaf_dp Kf_Ras_pRaf1_unbind J_Ras_pRaf1_unbind J_nfpiRaf1_ub Kr_sorafenib_BRaf_bind_cyt J_sorafenib_BRaf_bind_cyt J_pRaf1_Raf1_bind RasGTP_parameter J_BRaf_Raf1_bind J_iBRaf_dim ];
end

% -------------------------------------------------------
% ode rate
function dydt = f(t,y,p,y0)
	% State Variables
	Ras_iBRaf = y(1);
	Ras_Raf1_iBRaf_tetramer = y(2);
	Ras_BRaf = y(3);
	Ras_nfpRaf1 = y(4);
	iRaf1 = y(5);
	GTP_Ras = y(6);
	Ras_pRaf1 = y(7);
	BRaf_iBRaf_dimer = y(8);
	Ras_pRaf1_iBRaf_tetramer = y(9);
	Ras_pRaf1_tetramer = y(10);
	Ras_nfpiRaf1 = y(11);
	nfpiRaf1 = y(12);
	Ras_BRaf_pRaf1_tetramer = y(13);
	Ras_pRaf1_Raf1_tetramer = y(14);
	nfpRaf1 = y(15);
	Ras_nfpBRaf = y(16);
	iBRaf = y(17);
	pMEK = y(18);
	pRaf1 = y(19);
	Ras_iRaf1 = y(20);
	Ras_nfpiBRaf = y(21);
	Ras_Raf1 = y(22);
	nfpiBRaf = y(23);
	nfpBRaf = y(24);
	iBRaf_dimer = y(25);
	Ras_BRaf_Raf1_tetramer = y(26);
	BRaf_dimer = y(27);
	pERK = y(28);
	Ras_iRaf1_iBRaf1_tetramer = y(29);
	% Constants
	Ras_iRaf1_tetramer_init_molecules_um_2 = p(1);
	netValence_Raf1_iBRaf_p = p(2);
	mlabfix_F_ = p(3);
	Ras_pRaf1_Raf1_tetramer_init_molecules_um_2 = p(4);
	Kr_ERK_p = p(5);
	netValence_pRaf1_Raf1_bind = p(6);
	netValence_iBRaf_dim = p(7);
	Ds = p(8);
	iRaf1_init_uM = p(9);
	Kr_nfpBRaf_dp = p(10);
	kBr = p(11);
	Kr_Ras_iRaf_nfp = p(12);
	kBf = p(13);
	Kr_nfpiRaf_dp = p(14);
	GTP_Ras_init_molecules_um_2 = p(15);
	Cs = p(16);
	kR1r = p(17);
	BRaf_init_uM = p(18);
	Kr_nfpRaf1_ub = p(19);
	nfpBRaf_init_uM = p(20);
	kR1f = p(21);
	Bs = p(22);
	netValence_BRaf_dim = p(23);
	netValence_Ras_iBRaf_nfp = p(24);
	kERKdp = p(25);
	As = p(26);
	kMEKp = p(27);
	netValence_pRaf1_Raf1_phosph = p(28);
	Kr_Ras_iBRaf_nfp = p(29);
	Ras_BRaf_init_molecules_um_2 = p(30);
	Ras_iRaf1_iBRaf1_tetramer_init_molecules_um_2 = p(31);
	netValence_nfpBRaf_ub = p(32);
	Ras_pRaf1_tetramer_init_molecules_um_2 = p(33);
	nfpiRaf1_init_uM = p(34);
	K_millivolts_per_volt = p(35);
	mlabfix_K_GHK_ = p(36);
	knfpBR1 = p(37);
	Ras_BRaf_pRaf1_tetramer_init_molecules_um_2 = p(38);
	netValence_pRaf1_pRaf1_unbind = p(39);
	kpR1 = p(40);
	pMEK_init_uM = p(41);
	Ras_nfpRaf1_init_molecules_um_2 = p(42);
	Kr_BRaf_Raf1_phosph = p(43);
	Ras_iBRaf_init_molecules_um_2 = p(44);
	mlabfix_F_nmol_ = p(45);
	Kr_Raf1_iBRaf_p = p(46);
	kSon = p(47);
	Kr_pRaf1_Raf1_phosph = p(48);
	Kr_pRaf1_dephosph = p(49);
	kiR1r = p(50);
	Kr_nfpBRaf_ub = p(51);
	Kr_MEK_p = p(52);
	mlabfix_T_ = p(53);
	netValence_Ras_pRaf1_unbind = p(54);
	kiR1f = p(55);
	Kr_MEK_dp = p(56);
	Size_cytoplasm = p(57);
	kSoff = p(58);
	netValence_pRaf1_iBRaf_ub = p(59);
	netValence_BRaf_pRaf1_unbind = p(60);
	Kr_nfpiBRaf_dp = p(61);
	mlabfix_R_ = p(62);
	iBRaf_dimer_init_molecules_um_2 = p(63);
	Ras_Braf_iRaf1_tetramer_init_molecules_um_2 = p(64);
	netValence_Ras_pRaf1_dp = p(65);
	Kr_nfpiRaf1_ub = p(66);
	Ras_pRaf1_iBRaf_tetramer_init_molecules_um_2 = p(67);
	Voltage_pm = p(68);
	pRaf1_init_uM = p(69);
	netValence_nfpiRaf1_ub = p(70);
	kMEKdp = p(71);
	netValence_Ras_Raf1_nfp = p(72);
	kdR1r = p(73);
	kiBr = p(74);
	kdR1f = p(75);
	sorafenib_init_uM = p(76);
	kiBf = p(77);
	kERKp = p(78);
	Ras_nfpBRaf_init_molecules_um_2 = p(79);
	kfpBr = p(80);
	netValence_BRaf_iBRaf_dim = p(81);
	pERK_init_uM = p(82);
	Kr_ERK_dp = p(83);
	netValence_iRaf_iBRaf_dim = p(84);
	netValence_iBRaf_Raf1_bind = p(85);
	iBRaf_init_uM = p(86);
	netValence_Ras_iRaf_nfp = p(87);
	netValence_Ras_Raf1_bind = p(88);
	netValence_BRaf_nfp = p(89);
	MEK_init_uM = p(90);
	pm_sa = p(91);
	netValence_Ras_BRaf_bind = p(92);
	mlabfix_PI_ = p(93);
	kdpR1 = p(94);
	Raf1_init_uM = p(95);
	nfpRaf1_init_uM = p(96);
	BRaf_dimer_init_molecules_um_2 = p(97);
	Kr_nfpRaf1_dp = p(98);
	Kr_nfpiBRaf_ub = p(99);
	netValence_BRaf_Raf1_bind = p(100);
	netValence_Ras_iBRaf_b = p(101);
	Ras_Raf1_iBRaf_tetramer_init_molecules_um_2 = p(102);
	BRaf_iBRaf_dimer_init_molecules_um_2 = p(103);
	ERK_init_uM = p(104);
	netValence_nfpiBRaf_ub = p(105);
	Kr_BRaf_nfp = p(106);
	mlabfix_N_pmol_ = p(107);
	Ras_pRaf1_init_molecules_um_2 = p(108);
	Ras_nfpiRaf1_init_molecules_um_2 = p(109);
	D = p(110);
	C = p(111);
	B = p(112);
	A = p(113);
	Ras_Raf1_init_molecules_um_2 = p(114);
	Kr_Ras_pRaf1_dp = p(115);
	KMOLE = p(116);
	nfpiBRaf_init_uM = p(117);
	Ras_nfpiBRaf_init_molecules_um_2 = p(118);
	Size_pm = p(119);
	netValence_BRaf_Raf1_phosph = p(120);
	Ras_BRaf_Raf1_tetramer_init_molecules_um_2 = p(121);
	Kr_Ras_Raf1_nfp = p(122);
	Ras_iRaf1_init_molecules_um_2 = p(123);
	kfpR1r = p(124);
	netValence_nfpRaf1_ub = p(125);
	% Functions
	Kf_iRaf_iBRaf_dim = kdR1f;
	UnitFactor_uM_um3_molecules_neg_1 = (1.0 ./ 1.0);
	K_Raf1_total = ((Size_cytoplasm .* Raf1_init_uM) + (Size_cytoplasm .* pRaf1_init_uM) + (Size_cytoplasm .* iRaf1_init_uM) + (Size_cytoplasm .* nfpRaf1_init_uM) + (Size_cytoplasm .* nfpiRaf1_init_uM) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_init_molecules_um_2) + (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_Raf1_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_Raf1_tetramer_init_molecules_um_2) + (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_pRaf1_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpRaf1_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiRaf1_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer_init_molecules_um_2));
	Raf1 = ((K_Raf1_total - (Size_cytoplasm .* pRaf1) - (Size_cytoplasm .* iRaf1) - (Size_cytoplasm .* nfpRaf1) - (Size_cytoplasm .* nfpiRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1) - (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_Raf1_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_Raf1_tetramer) - (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_pRaf1_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer)) ./ Size_cytoplasm);
	Raf1_cyt_param = (Raf1 + pRaf1 + iRaf1 + nfpRaf1 + nfpiRaf1);
	K_BRaf_total = ((Size_cytoplasm .* BRaf_init_uM) + (Size_cytoplasm .* iBRaf_init_uM) + (Size_cytoplasm .* nfpBRaf_init_uM) + (Size_cytoplasm .* nfpiBRaf_init_uM) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_Raf1_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_pRaf1_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* iBRaf_dimer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_dimer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iBRaf_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpBRaf_init_molecules_um_2) + (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_iBRaf_dimer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiBRaf_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer_init_molecules_um_2));
	BRaf = ((K_BRaf_total - (Size_cytoplasm .* iBRaf) - (Size_cytoplasm .* nfpBRaf) - (Size_cytoplasm .* nfpiBRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_Raf1_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_BRaf_pRaf1_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* iBRaf_dimer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_dimer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iBRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpBRaf) - (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_iBRaf_dimer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiBRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer)) ./ Size_cytoplasm);
	Kf_nfpBRaf_dp = kdpR1;
	J_nfpBRaf_dp = ((Kf_nfpBRaf_dp .* nfpBRaf) - (Kr_nfpBRaf_dp .* BRaf));
	Kf_Ras_iRaf_nfp = (kpR1 .* pERK);
	J_Ras_iRaf_nfp = ((Kf_Ras_iRaf_nfp .* Ras_iRaf1) - (Kr_Ras_iRaf_nfp .* Ras_nfpiRaf1));
	Kf_Ras_Raf1_nfp = (knfpBR1 .* pERK);
	Kf_nfpiBRaf_dp = kdpR1;
	Kf_Ras_iBRaf_nfp = (knfpBR1 .* pERK);
	Kf_nfpiRaf_dp = kdpR1;
	J_nfpiRaf_dp = ((Kf_nfpiRaf_dp .* nfpiRaf1) - (Kr_nfpiRaf_dp .* iRaf1));
	K_sorafenib_total = ((Size_cytoplasm .* sorafenib_init_uM) + (Size_cytoplasm .* iRaf1_init_uM) + (Size_cytoplasm .* iBRaf_init_uM) + (Size_cytoplasm .* nfpiBRaf_init_uM) + (Size_cytoplasm .* nfpiRaf1_init_uM) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* iBRaf_dimer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iBRaf_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_iBRaf_dimer_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiBRaf_init_molecules_um_2) + (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiRaf1_init_molecules_um_2) + (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer_init_molecules_um_2));
	sorafenib = ((K_sorafenib_total - (Size_cytoplasm .* iRaf1) - (Size_cytoplasm .* iBRaf) - (Size_cytoplasm .* nfpiBRaf) - (Size_cytoplasm .* nfpiRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Raf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_pRaf1_iBRaf_tetramer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* iBRaf_dimer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iBRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* BRaf_iBRaf_dimer) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiBRaf) - (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_nfpiRaf1) - (2.0 .* Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_iBRaf1_tetramer)) ./ Size_cytoplasm);
	Kf_nfpRaf1_ub = kfpR1r;
	J_nfpRaf1_ub = ((Kf_nfpRaf1_ub .* Ras_nfpRaf1) - ((Kr_nfpRaf1_ub .* GTP_Ras) .* nfpRaf1));
	K_Ras_Braf_iRaf1_tetramer_total = (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_Braf_iRaf1_tetramer_init_molecules_um_2);
	Kr_Ras_Raf1_bind = kR1r;
	K_ERK_total = ((Size_cytoplasm .* ERK_init_uM) + (Size_cytoplasm .* pERK_init_uM));
	ERK = ((K_ERK_total - (Size_cytoplasm .* pERK)) ./ Size_cytoplasm);
	Kr_Ras_BRaf_bind = kBr;
	Kf_iBRaf_dim = kdR1f;
	K_MEK_total = ((Size_cytoplasm .* MEK_init_uM) + (Size_cytoplasm .* pMEK_init_uM));
	MEK = ((K_MEK_total - (Size_cytoplasm .* pMEK)) ./ Size_cytoplasm);
	Kf_MEK_dp = kMEKdp;
	J_MEK_dp = ((Kf_MEK_dp .* pMEK) - (Kr_MEK_dp .* MEK));
	Kf_iBRaf_Raf1_bind = kdR1f;
	Kf_Ras_iBRaf_b = kiBf;
	Kr_Ras_iBRaf_b = kiBr;
	J_Ras_iBRaf_b = ((Kf_Ras_iBRaf_b .* iBRaf) - (Kr_Ras_iBRaf_b .* Ras_iBRaf));
	Kf_ERK_p = (kERKp .* pMEK);
	J_ERK_p = ((Kf_ERK_p .* ERK) - (Kr_ERK_p .* pERK));
	Kf_nfpiBRaf_ub = kfpBr;
	J_nfpiBRaf_ub = ((Kf_nfpiBRaf_ub .* Ras_nfpiBRaf) - ((Kr_nfpiBRaf_ub .* nfpiBRaf) .* GTP_Ras));
	Kf_BRaf_nfp = (knfpBR1 .* pERK);
	J_BRaf_nfp = ((Kf_BRaf_nfp .* Ras_BRaf) - (Kr_BRaf_nfp .* Ras_nfpBRaf));
	Kr_iBRaf_Raf1_bind = kdR1r;
	Kf_pRaf1_Raf1_bind = kdR1f;
	Kf_pRaf1_dephosph = kdpR1;
	J_pRaf1_dephosph = ((Kf_pRaf1_dephosph .* pRaf1) - (Kr_pRaf1_dephosph .* Raf1));
	Kf_nfpBRaf_ub = kfpBr;
	Kf_Ras_Raf1_bind = kR1f;
	J_Ras_Raf1_bind = (((Kf_Ras_Raf1_bind .* GTP_Ras) .* Raf1) - (Kr_Ras_Raf1_bind .* Ras_Raf1));
	Kf_pRaf1_Raf1_phosph = kpR1;
	J_pRaf1_Raf1_phosph = ((Kf_pRaf1_Raf1_phosph .* Ras_pRaf1_Raf1_tetramer) - (Kr_pRaf1_Raf1_phosph .* Ras_pRaf1_tetramer));
	Kf_Ras_BRaf_bind = kBf;
	J_Ras_BRaf_bind = (((Kf_Ras_BRaf_bind .* BRaf) .* GTP_Ras) - (Kr_Ras_BRaf_bind .* Ras_BRaf));
	Kr_BRaf_iBRaf_dim = kdR1r;
	Kf_BRaf_iBRaf_dim = kdR1f;
	Kf_sorafenib_Raf1_bind_cyt = kSon;
	Kf_Raf1_iBRaf_p = kpR1;
	J_Raf1_iBRaf_p = ((Kf_Raf1_iBRaf_p .* Ras_Raf1_iBRaf_tetramer) - (Kr_Raf1_iBRaf_p .* Ras_pRaf1_iBRaf_tetramer));
	Kr_BRaf_dim = kdR1r;
	Kf_Ras_pRaf1_dp = kdpR1;
	Kr_iRaf_iBRaf_dim = kdR1r;
	KFlux_pm_cytoplasm = (Size_pm ./ Size_cytoplasm);
	J_nfpBRaf_ub = ((Kf_nfpBRaf_ub .* Ras_nfpBRaf) - ((Kr_nfpBRaf_ub .* nfpBRaf) .* GTP_Ras));
	Kf_BRaf_Raf1_phosph = kpR1;
	J_BRaf_Raf1_phosph = ((Kf_BRaf_Raf1_phosph .* Ras_BRaf_Raf1_tetramer) - (Kr_BRaf_Raf1_phosph .* Ras_BRaf_pRaf1_tetramer));
	Kf_ERK_dp = kERKdp;
	J_ERK_dp = ((Kf_ERK_dp .* pERK) - (Kr_ERK_dp .* ERK));
	Kr_BRaf_Raf1_bind = kdR1r;
	Kf_BRaf_Raf1_bind = kdR1f;
	Kf_pRaf1_pRaf1_unbind = kdR1r;
	Kr_pRaf1_pRaf1_unbind = kdR1f;
	J_pRaf1_pRaf1_unbind = ((Kf_pRaf1_pRaf1_unbind .* Ras_pRaf1_tetramer) - (Kr_pRaf1_pRaf1_unbind .* (Ras_pRaf1 ^ 2.0)));
	active_Raf = ((2.0 .* BRaf_dimer) + Ras_BRaf_Raf1_tetramer + (2.0 .* Ras_BRaf_pRaf1_tetramer) + Ras_pRaf1_iBRaf_tetramer + Ras_pRaf1 + Ras_pRaf1_Raf1_tetramer + (2.0 .* Ras_pRaf1_tetramer) + pRaf1 + BRaf_iBRaf_dimer);
	Kf_BRaf_pRaf1_unbind = kdR1r;
	Kr_BRaf_pRaf1_unbind = kdR1f;
	J_BRaf_pRaf1_unbind = ((Kf_BRaf_pRaf1_unbind .* Ras_BRaf_pRaf1_tetramer) - ((Kr_BRaf_pRaf1_unbind .* Ras_BRaf) .* Ras_pRaf1));
	K_Ras_iRaf1_tetramer_total = (Size_pm .* UnitFactor_uM_um3_molecules_neg_1 .* Ras_iRaf1_tetramer_init_molecules_um_2);
	Kf_sorafenib_BRaf_bind_cyt = kSon;
	J_iBRaf_Raf1_bind = (((Kf_iBRaf_Raf1_bind .* Ras_Raf1) .* Ras_iBRaf) - (Kr_iBRaf_Raf1_bind .* Ras_Raf1_iBRaf_tetramer));
	Kf_MEK_p = (kMEKp .* active_Raf);
	J_MEK_p = ((Kf_MEK_p .* MEK) - (Kr_MEK_p .* pMEK));
	Kr_pRaf1_Raf1_bind = kdR1r;
	Kr_pRaf1_iBRaf_ub = kdR1f;
	Kf_pRaf1_iBRaf_ub = kdR1r;
	J_pRaf1_iBRaf_ub = ((Kf_pRaf1_iBRaf_ub .* Ras_pRaf1_iBRaf_tetramer) - ((Kr_pRaf1_iBRaf_ub .* Ras_iBRaf) .* Ras_pRaf1));
	J_Ras_Raf1_nfp = ((Kf_Ras_Raf1_nfp .* Ras_Raf1) - (Kr_Ras_Raf1_nfp .* Ras_nfpRaf1));
	Kf_BRaf_dim = kdR1f;
	J_BRaf_dim = ((Kf_BRaf_dim .* Ras_BRaf) - (Kr_BRaf_dim .* BRaf_dimer));
	Kf_nfpRaf1_dp = kdpR1;
	Kr_sorafenib_Raf1_bind_cyt = kSoff;
	J_sorafenib_Raf1_bind_cyt = (((Kf_sorafenib_Raf1_bind_cyt .* Raf1) .* sorafenib) - (Kr_sorafenib_Raf1_bind_cyt .* iRaf1));
	Ras_Braf_iRaf1_tetramer = (K_Ras_Braf_iRaf1_tetramer_total ./ (Size_pm .* UnitFactor_uM_um3_molecules_neg_1));
	Ras_iRaf1_tetramer = (K_Ras_iRaf1_tetramer_total ./ (Size_pm .* UnitFactor_uM_um3_molecules_neg_1));
	Raf1_pm_param = (Ras_pRaf1 + (2.0 .* Ras_pRaf1_Raf1_tetramer) + Ras_BRaf_Raf1_tetramer + Ras_iRaf1 + Ras_Raf1 + (2.0 .* Ras_iRaf1_tetramer) + Ras_Braf_iRaf1_tetramer + Ras_BRaf_pRaf1_tetramer + (2.0 .* Ras_pRaf1_tetramer) + Ras_nfpiRaf1 + Ras_nfpRaf1 + Ras_iRaf1_iBRaf1_tetramer + Ras_Raf1_iBRaf_tetramer + Ras_pRaf1_iBRaf_tetramer);
	boundRaf_frac_parameter = (Raf1_pm_param ./ (Raf1_cyt_param + Raf1_pm_param));
	J_Ras_iBRaf_nfp = ((Kf_Ras_iBRaf_nfp .* Ras_iBRaf) - (Kr_Ras_iBRaf_nfp .* Ras_nfpiBRaf));
	J_nfpRaf1_dp = ((Kf_nfpRaf1_dp .* nfpRaf1) - (Kr_nfpRaf1_dp .* Raf1));
	J_BRaf_iBRaf_dim = (((Kf_BRaf_iBRaf_dim .* Ras_BRaf) .* Ras_iBRaf) - (Kr_BRaf_iBRaf_dim .* BRaf_iBRaf_dimer));
	Kf_nfpiRaf1_ub = kfpR1r;
	Kr_Ras_pRaf1_unbind = kR1f;
	J_iRaf_iBRaf_dim = (((Kf_iRaf_iBRaf_dim .* Ras_iRaf1) .* Ras_iBRaf) - (Kr_iRaf_iBRaf_dim .* Ras_iRaf1_iBRaf1_tetramer));
	J_Ras_pRaf1_dp = ((Kf_Ras_pRaf1_dp .* Ras_pRaf1) - (Kr_Ras_pRaf1_dp .* Ras_Raf1));
	Kr_iBRaf_dim = kdR1r;
	J_nfpiBRaf_dp = ((Kf_nfpiBRaf_dp .* nfpiBRaf) - (Kr_nfpiBRaf_dp .* iBRaf));
	Kf_Ras_pRaf1_unbind = kR1r;
	J_Ras_pRaf1_unbind = ((Kf_Ras_pRaf1_unbind .* Ras_pRaf1) - ((Kr_Ras_pRaf1_unbind .* pRaf1) .* GTP_Ras));
	J_nfpiRaf1_ub = ((Kf_nfpiRaf1_ub .* Ras_nfpiRaf1) - ((Kr_nfpiRaf1_ub .* nfpiRaf1) .* GTP_Ras));
	Kr_sorafenib_BRaf_bind_cyt = kSoff;
	J_sorafenib_BRaf_bind_cyt = (((Kf_sorafenib_BRaf_bind_cyt .* sorafenib) .* BRaf) - (Kr_sorafenib_BRaf_bind_cyt .* iBRaf));
	J_pRaf1_Raf1_bind = (((Kf_pRaf1_Raf1_bind .* Ras_pRaf1) .* Ras_Raf1) - (Kr_pRaf1_Raf1_bind .* Ras_pRaf1_Raf1_tetramer));
	RasGTP_parameter = (GTP_Ras + (2.0 .* (Ras_iRaf1_tetramer + Ras_Braf_iRaf1_tetramer + Ras_BRaf_Raf1_tetramer + Ras_pRaf1_Raf1_tetramer + Ras_BRaf_pRaf1_tetramer + Ras_pRaf1_tetramer + BRaf_dimer + BRaf_iBRaf_dimer + iBRaf_dimer + Ras_iRaf1_iBRaf1_tetramer + Ras_Raf1_iBRaf_tetramer + Ras_pRaf1_iBRaf_tetramer)) + Ras_BRaf + Ras_iRaf1 + Ras_pRaf1 + Ras_Raf1 + Ras_nfpRaf1 + Ras_nfpiRaf1 + Ras_iBRaf + Ras_nfpiBRaf + Ras_nfpBRaf);
	J_BRaf_Raf1_bind = (((Kf_BRaf_Raf1_bind .* Ras_BRaf) .* Ras_Raf1) - (Kr_BRaf_Raf1_bind .* Ras_BRaf_Raf1_tetramer));
	J_iBRaf_dim = ((Kf_iBRaf_dim .* Ras_iBRaf) - (Kr_iBRaf_dim .* iBRaf_dimer));
	% Rates
	dydt = [
		(J_Ras_iBRaf_b - J_iBRaf_dim - J_iBRaf_Raf1_bind + J_pRaf1_iBRaf_ub - J_BRaf_iBRaf_dim - J_Ras_iBRaf_nfp - J_iRaf_iBRaf_dim);    % rate for Ras_iBRaf
		(J_iBRaf_Raf1_bind - J_Raf1_iBRaf_p);    % rate for Ras_Raf1_iBRaf_tetramer
		( - J_BRaf_Raf1_bind + J_Ras_BRaf_bind + J_BRaf_pRaf1_unbind - J_BRaf_dim - J_BRaf_nfp - J_BRaf_iBRaf_dim);    % rate for Ras_BRaf
		(J_Ras_Raf1_nfp - J_nfpRaf1_ub);    % rate for Ras_nfpRaf1
		(J_sorafenib_Raf1_bind_cyt + J_nfpiRaf_dp);    % rate for iRaf1
		( - J_Ras_Raf1_bind + J_Ras_pRaf1_unbind - J_Ras_BRaf_bind + J_nfpRaf1_ub + J_nfpBRaf_ub + J_nfpiRaf1_ub + J_nfpiBRaf_ub);    % rate for GTP_Ras
		( - J_Ras_pRaf1_unbind - J_pRaf1_Raf1_bind + (2.0 .* J_pRaf1_pRaf1_unbind) + J_BRaf_pRaf1_unbind + J_pRaf1_iBRaf_ub - J_Ras_pRaf1_dp);    % rate for Ras_pRaf1
		J_BRaf_iBRaf_dim;    % rate for BRaf_iBRaf_dimer
		(J_Raf1_iBRaf_p - J_pRaf1_iBRaf_ub);    % rate for Ras_pRaf1_iBRaf_tetramer
		(J_pRaf1_Raf1_phosph - J_pRaf1_pRaf1_unbind);    % rate for Ras_pRaf1_tetramer
		(J_Ras_iRaf_nfp - J_nfpiRaf1_ub);    % rate for Ras_nfpiRaf1
		((UnitFactor_uM_um3_molecules_neg_1 .* KFlux_pm_cytoplasm .* J_nfpiRaf1_ub) - J_nfpiRaf_dp);    % rate for nfpiRaf1
		(J_BRaf_Raf1_phosph - J_BRaf_pRaf1_unbind);    % rate for Ras_BRaf_pRaf1_tetramer
		(J_pRaf1_Raf1_bind - J_pRaf1_Raf1_phosph);    % rate for Ras_pRaf1_Raf1_tetramer
		((UnitFactor_uM_um3_molecules_neg_1 .* KFlux_pm_cytoplasm .* J_nfpRaf1_ub) - J_nfpRaf1_dp);    % rate for nfpRaf1
		(J_BRaf_nfp - J_nfpBRaf_ub);    % rate for Ras_nfpBRaf
		(J_sorafenib_BRaf_bind_cyt - (UnitFactor_uM_um3_molecules_neg_1 .* KFlux_pm_cytoplasm .* J_Ras_iBRaf_b) + J_nfpiBRaf_dp);    % rate for iBRaf
		(J_MEK_p - J_MEK_dp);    % rate for pMEK
		((UnitFactor_uM_um3_molecules_neg_1 .* KFlux_pm_cytoplasm .* J_Ras_pRaf1_unbind) - J_pRaf1_dephosph);    % rate for pRaf1
		( - J_Ras_iRaf_nfp - J_iRaf_iBRaf_dim);    % rate for Ras_iRaf1
		(J_Ras_iBRaf_nfp - J_nfpiBRaf_ub);    % rate for Ras_nfpiBRaf
		(J_Ras_Raf1_bind - J_BRaf_Raf1_bind - J_pRaf1_Raf1_bind - J_iBRaf_Raf1_bind + J_Ras_pRaf1_dp - J_Ras_Raf1_nfp);    % rate for Ras_Raf1
		((UnitFactor_uM_um3_molecules_neg_1 .* KFlux_pm_cytoplasm .* J_nfpiBRaf_ub) - J_nfpiBRaf_dp);    % rate for nfpiBRaf
		((UnitFactor_uM_um3_molecules_neg_1 .* KFlux_pm_cytoplasm .* J_nfpBRaf_ub) - J_nfpBRaf_dp);    % rate for nfpBRaf
		J_iBRaf_dim;    % rate for iBRaf_dimer
		(J_BRaf_Raf1_bind - J_BRaf_Raf1_phosph);    % rate for Ras_BRaf_Raf1_tetramer
		J_BRaf_dim;    % rate for BRaf_dimer
		(J_ERK_p - J_ERK_dp);    % rate for pERK
		J_iRaf_iBRaf_dim;    % rate for Ras_iRaf1_iBRaf1_tetramer
	];
end
