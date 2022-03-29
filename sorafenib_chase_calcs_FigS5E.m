%% sorafenib pulse-chase calculations
clear
close all
clc

%get current model parameters
[~,~,~,~,parameters,allNames,~] = plus_sorafenib_new;
parameters(76) = 0.0;

kfpR1r = parameters(128);
parameters(128) = 2.12;

%fit model to Ras-GTP data
params = [21910.6052602647;3.30222950844396;5.40187714674488e+16;1.42933217919049e+15];
my_super_nice_params = params;
timedata =  [0 2.5 5.0 10.0 15.0 30.0 60.0]';
rasdatapcnts = [0 99.46 94.34 61.31 13.59 5.53 5.53]';
rasdatanums = rasdatapcnts.*270;

%define optimization function
objfunc = @(x) sum((plus_sorafenib_new(x,timedata,[],parameters) - rasdatanums).^2);

options = optimset('MaxFunEvals', 500.*length(my_super_nice_params),'MaxIter',500*length(my_super_nice_params));

%get fitted Ras-GTP parameters
fittedparams = fminsearchbnd(objfunc,my_super_nice_params,zeros(length(params),1),[],options);

%% Run pulse-chase simulations and generate plot for Figure S5E
chasetimes = [5; 15; 30; 60];
colors = {'b';'r';[0 0.6 0];[1 0.6 0]};
linewidths = 1.0;
axesfontsize = 16;
tickfontsize = 14;
ticklength = [0.01 0.01];

figure
for i = 1:4
    %EGF pulse
    [~,times1,Yout1,~,~,~,allVals1]= plus_sorafenib_new(fittedparams,[0,chasetimes(i)],[],parameters);

    %sorafenib chase
    parameters(76) = 10.0; %set sorafenib concentration
    parameters(128) = kfpR1r;
    [~,times2,Yout2,~,~,~,allVals2]= plus_sorafenib_new(fittedparams,[chasetimes(i),chasetimes(i)+20],Yout1(end,:),parameters);
    
    plottime = times2 - chasetimes(i);
    
    %concatenate outputs
    times = vertcat(times1,times2);
    Yout = vertcat(Yout1,Yout2);
    allVals = vertcat(allVals1,allVals2);

    %store all outputs
    T{:,i} = times;
    Y{:,i} = Yout;
    allValues{i} = allVals;
    plot(plottime, allVals2(:,131).*100.0, 'Color', colors{i}, 'LineWidth',linewidths)
    hold on
    
    %reset sorafenib concentration, kfpR1r
    parameters(76) = 0.0;
    parameters(128) = 2.12;
    clear times Yout allVals
end

xlabel('min Sorafenib')
ylabel('Membrane Raf1 (% of total)')
title('EGF pre-treatment','FontSize',axesfontsize)
set(gca,'FontName','Helvetica')
legend('5 min EGF','15 min EGF','30 min EGF','60 min EGF','location','best')
set(gca,'LineWidth',linewidths)
box off
set(gca,'TickDir','out','LineWidth',linewidths,'TickLength',ticklength)
