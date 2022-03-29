close all
clear
clc
warning('off','all')

%% Ras-GTP fitting
A = 20671.0;
B = 3.6724;	
C = 2000;
D = 2000;

tic
params = [21910.6052602647;3.30222950844396;5.40187714674488e+16;1.42933217919049e+15];
my_super_nice_params = params;
% [correct_total,T] = minus_sorafenib_new(my_super_nice_params,[0 60],yinit,param);
timedata =  [0 2.5 5.0 10.0 15.0 30.0 60.0]';
rasdatapcnts = [0 99.46 94.34 61.31 13.59 5.53 14.51]';
rasdatanums = rasdatapcnts.*270;

objfunc = @(x) sum((minus_sorafenib_new_refitted_rasraf_binding(x,timedata) - rasdatanums).^2);

options = optimset('MaxFunEvals',1000.*length(my_super_nice_params),'MaxIter',1000*length(my_super_nice_params));
%options = optimoptions('particleswarm','SwarmSize',1000);
%particleswarm(objfunc,length(params),zeros(length(params),1),1e17*ones(4,1),options);%

fittedparams = fminsearchbnd(objfunc,my_super_nice_params,zeros(length(params),1),[],options); % fit RAS parameters for -sfnb
toc
[correct_total1,T,~,~,newparams] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams,[0 60]);

% Ras-GTP fitting results: Figure S5A
f1 = figure;
plot(T,correct_total1,timedata,rasdatanums,'.','LineWidth',1.5,'MarkerSize',15.0);
xlabel('Time')
ylabel('RAS-GTP (molec/cell)')
title('RAS-GTP fitting')
legend('Experimental data','Model fit')
set(gca,'TickDir','out','LineWidth',1.5,'TickLength',[0.01 0.01])
box off

% Fitting errors:
f2 = figure;
t = linspace(0,60,1000);
plot(timedata,minus_sorafenib_new_refitted_rasraf_binding(fittedparams,timedata) - rasdatanums, '-o',t,zeros(length(t)),'k')
ylabel('Residual')
xlabel('Time')
set(gca,'TickDir','out','LineWidth',1.5,'TickLength',[0.01 0.01])
box off

%% Original model parameterization (-sorafenib)
objfunc = @(x) sum((minus_sorafenib_new(x,timedata) - rasdatanums).^2);
fittedparams = fminsearchbnd(objfunc,my_super_nice_params,zeros(length(params),1),[],options);

[correct_total,Raf1model_nosrfnb(:,1),Y,yinit,param,allNames,allValues] = minus_sorafenib_new(fittedparams);
[Raf1model_nosrfnb(:,2), ogRaf_pm] = vcell_outputfuncs(allValues);

%% Raf1:Ras binding fitting (-sorafenib)
paramsi = [1e-5; 0.212];
rafdata = [0.5, -0.002002925;
    0.75, 0.05567558;
    1.5, 0.028423289;
    2.25, 0.085464703;
    2.5, 0.101579527;
    3.0, 0.105097131;
    3.5, 0.072414137;
    4.0, 0.14415437;
    5.0, 0.083262325;
    5.5, 0.043840497;
    6.0, 0.147578976;
    7.0, 0.018099992;
    7.5, 0.006378524;
    9.5, -2.29474E-4;
    10.0, 0.028087871;
    10.5, -0.008256816;
    14.0, -0.006646528;
    16.0, -0.007348075;
    17.0, 0.003195765;
    19.0, -0.002786823;
    21.0, 0.00591219;
    23.0, 0.016836838;
    24.0, 0.017740044;
    26.0, 0.01472581;
    29.0, 0.008839351];
timedataraf = rafdata(:,1);
tic

objfunc = @(x) sum((minus_sorafenib_new_fitting(x,timedataraf,[],newparams)-rafdata(:,2)).^2);

options = optimset('MaxFunEvals',1000.*length(paramsi),'MaxIter',1000*length(paramsi));

raffittedparams = fminsearchbnd(objfunc,paramsi,zeros(length(paramsi),1),[],options) % fit RAS:RAF binding params for -sfnb

[~,T1,~,~,~,~,allValuesm] = minus_sorafenib_new_fitting(raffittedparams,[0 30],[],newparams);
toc
%% Ras:Raf1 binding fitting (+sorafenib)
objfunc = @(x) sum((plus_sorafenib_new(x,timedata) - rasdatanums).^2);
tic
options = optimset('MaxFunEvals',10000.*length(my_super_nice_params),'MaxIter',500*length(my_super_nice_params));

fittedparams2 = fminsearchbnd(objfunc,my_super_nice_params,zeros(length(params),1),[],options); % fit RAS parameters for +sfnb

[~,~,~,~,newparams2] = plus_sorafenib_new(fittedparams2,[0 60]);

paramsi = [1e-5;1e-2;0.0024568432613784427];
irafdata = [0.5, 0.029691661;
    2.0, 0.040580582;
    4.0, 0.022488663;
    6.0, 0.184556834;
    7.0, 0.15886291;
    9.0, 0.2837471;
    9.5, 0.128984;
    12.0, 0.205516777;
    15.0, 0.171037433;
    15.5, 0.244895111;
    17.0, 0.292388651;
    19.0, 0.144313801;
    20.0, 0.299462497;
    21.5, 0.184914742;
    24.0, 0.171747801;
    28.0, 0.188181496;
    28.5, 0.153835813];

timedatairaf = irafdata(:,1);

objfunc = @(x) sum((plus_sorafenib_new_fitting(x,timedatairaf,[],newparams2)-irafdata(:,2)).^2);

options = optimset('MaxFunEvals',1000.*length(paramsi),'MaxIter',500*length(paramsi));

iraffittedparams = fminsearchbnd(objfunc,paramsi,zeros(length(paramsi),1),[],options) % fit RAS:RAF binding params for +sfnb

[a2,T2] = plus_sorafenib_new_fitting(iraffittedparams,[0 30],[],newparams2);
%% Plot for Figure 9A
lw = 1.5;
axesfontsize = 16;
tickfontsize = 14;
ticklength = [0.01 0.01];

% Membrane RAF1 fitting results and predictions: Figure 9A
f3 = figure;
plot(Raf1model_nosrfnb(:,1),Raf1model_nosrfnb(:,2),'b--',... % initial model
    T1,allValuesm(:,123),'b',... % reparameterized model, -sorafenib
    T2,a2,'r',...   % reparameterized model, +sorafenib
    timedatairaf,irafdata(:,2),'r.',... % EGF-Rh, -sorafenib
    timedataraf,rafdata(:,2),'b.',...   % EGF-Rh, +sorafenib
    'LineWidth',lw,'MarkerSize',15.0);
set(gca,'FontSize',tickfontsize)
xlabel('min EGF','FontSize',axesfontsize,'FontWeight','bold')
ylabel('Membrane Raf1 (fraction of total)','FontSize',axesfontsize,...
    'FontWeight','bold')
lgd2 = legend('Initial model',...
    'Reparametrized model',...
    'Reparametrized model, +Sorafenib',...
    'RAF1-mV, EGF-Rh',...
    'RAF1-mV, EGF-Rh+Sorafenib','location','best');
lgd2.FontSize = 10;
lgd2.Location = 'best';
axis([0 30 -0.05 0.4])
box off
set(gca,'TickDir','out','LineWidth',lw,'TickLength',ticklength);