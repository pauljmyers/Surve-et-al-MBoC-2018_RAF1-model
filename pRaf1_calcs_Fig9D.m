%% pRAF1 calculations
clear
close all
clc

% Ras-GTP data:
params = [21910.6052602647;3.30222950844396;5.40187714674488e+16;1.42933217919049e+15];
my_super_nice_params = params;
timedata =  [0 2.5 5.0 10.0 15.0 30.0 60.0]';
rasdatapcnts = [0 99.46 94.34 61.31 13.59 5.53 14.51]';
rasdatanums = rasdatapcnts.*270;

% Experimental pS338-RAF1 data:
pctmaxpRAF1data = [0; 11; 44; 73.5; 81; 100];
pctmaxerror = [0; 7; 20; 25; 18; 0];
times = [0; 2; 6; 10; 15; 30];
%%
time = [0,30];

% Fit RAS-GTP data first:
options = optimset('MaxFunEvals', 1000.*length(my_super_nice_params),'MaxIter',1000.*length(my_super_nice_params));
objfunc = @(x) sum((minus_sorafenib_new_refitted_rasraf_binding(x,timedata) - rasdatanums).^2); 
fittedparams = fminsearchbnd(objfunc,my_super_nice_params,zeros(length(params),1),[],options);
[~,Torig,~,~,params,~,originalvals] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams,[0 60]);
pRAF1_orig = originalvals(:,5)+originalvals(:,7)+originalvals(:,8)+originalvals(:,11)+originalvals(:,12)+originalvals(:,17);

% Fit pRAF1 data:
guessparams = [186.0; 0.6; 0.0191; 111.0]; 
objfunc = @(x) sum((minus_sorafenib_new_pRAF1fitting(x,times,[],params)-pctmaxpRAF1data).^2)+... %fitting the shape
    (minus_sorafenib_new_pRAF1fitting2(x,time,[],params)-0.5*0.1*12000).^2; %keeping the total number of pRAF1 at a reasonable amount (about 50% of maximal membrane RAF1-mVenus)

pRAF1fittedparams = fminsearchbnd(objfunc,guessparams,0.1.*guessparams,10.*guessparams,options);
[~,~,~,~,parameters] = minus_sorafenib_new_pRAF1fitting(pRAF1fittedparams);

paramnames = {'kpR1','kdpR1','kdR1f','kdR1r'};
fitted_param_table = array2table(pRAF1fittedparams');
fitted_param_table.Properties.VariableNames = paramnames
log10foldchange = log10(pRAF1fittedparams./guessparams);
log10fold_change_table = array2table(log10foldchange');
log10fold_change_table.Properties.VariableNames = paramnames

% Get pRAF1 predictions:
[RasP,T,Y,yinit,param,allnames,allvalues]= minus_sorafenib_new_refitted_rasraf_binding(fittedparams,time,[],parameters);

pRAF1_tot = allvalues(:,5)+allvalues(:,7)+allvalues(:,8)+allvalues(:,11)+allvalues(:,12)+allvalues(:,17);
pRAF1_norm = pRAF1_tot./max(pRAF1_tot).*100;

[sortednames, order] = sort(allnames);
sortedvalues = allvalues(:,order);

%% Plot model predictions: Fig 9D
close all

% Plot pRAF1 predictions and exptl data: Figure 9D ***
figure
p = errorbar(times,pctmaxpRAF1data,pctmaxerror,'.r','MarkerSize',20.0);
axis([0 30 0 120])
set(p,'LineWidth',1)
hold on
p = plot(T,pRAF1_norm,'r',Torig,pRAF1_orig./max(pRAF1_orig).*100,'b');
xlabel('min EGF')
ylabel('pRAF1 (% maximum phosphorylated)')
legend('HeLa/RAF1-mV, pSer338','Model fit to pSer338 data','Reparameterized model','location','best')
box off
set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
set(p,'LineWidth',1)

%% Plots of other model predictions/outputs
plot_other_figs = false;
if plot_other_figs 
    figure%--------------
    pMEK = allvalues(:,16);
    pMEKnorm = allvalues(:,16)./max(allvalues(:,16)).*100; %pMEK
    p = plot(T,pMEKnorm);
    set(p,'LineWidth',1)
    title('pMEK and pERK')
    ylabel('% maximum phosphorylated')
    xlabel('min EGF')
    hold on
    pERK = allvalues(:,26);
    pERKnorm = allvalues(:,26)./max(allvalues(:,26)).*100; %pERK
    p = plot(T,pERKnorm);
    set(p,'LineWidth',1)
    axis([0 30 0 120])
    legend('pMEK','pERK','location','best')
    box off
    set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])

    figure
    p = plot(T,pMEK./5e5);
    title('pMEK and pERK')
    ylabel('Total fraction phosphorylated')
    xlabel('min EGF')
    hold on
    set(p,'LineWidth',1)

    p = plot(T,pERK./6e5);
    legend('pMEK','pERK','location','best')
    box off
    set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
    set(p,'LineWidth',1)

    %--------------
    membranepRAF1 = allvalues(:,5)+allvalues(:,7)+allvalues(:,8)+allvalues(:,11)+allvalues(:,12);

    figure
    p = plot(T,membranepRAF1,T,allvalues(:,17),T,pRAF1_tot);
    title('pRAF1 dynamics')
    xlabel('min EGF')
    ylabel('pRAF1 (molec cell^{-1})')
    legend('Membrane','Cytosol','Total','location','best')
    box off
    set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
    set(p,'LineWidth',1)

    figure
    p = plot(T,membranepRAF1./pRAF1_tot.*100,T,allvalues(:,17)./pRAF1_tot.*100);
    xlabel('min EGF')
    ylabel('% of total pRAF1')
    legend('Membrane','Cytosol','location','best')
    box off
    set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
    set(p,'LineWidth',1)

    Rraf1phos = sortedvalues(:,37)+sortedvalues(:,8)+sortedvalues(:,17);
    figure
    p = plot(T,sortedvalues(:,25));
    title('Rate of RAS-pRAF1 unbinding')
    xlabel('min EGF')
    ylabel('R (molec cell^{-1} min^{-1})')
    box off
    set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
    set(p,'LineWidth',1)

    figure
    p = plot(T,sortedvalues(:,19));
    title('Rate of RAS-RAF1 binding')
    xlabel('min EGF')
    ylabel('R (molec cell^{-1} min^{-1})')
    box off
    set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
    set(p,'LineWidth',1)

    figure
    p = plot(T,Rraf1phos);
    title('Rate of RAF1 phosphorylation')
    xlabel('min EGF')
    ylabel('R (molec cell^{-1} min^{-1})')
    box off
    set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
    set(p,'LineWidth',1)

    figure
    p = plot(T,sortedvalues(:,[24,38]),T,sortedvalues(:,24)+sortedvalues(:,38));
    xlabel('min EGF')
    ylabel('R (molec cell^{-1} min^{-1})')
    title('Rates of pRAF1 dephosphorylation')
    legend('Membrane','Cytosol','Total','location','best')
    box off
    set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
    set(p,'LineWidth',1)

    figure
    p = plot(T,sortedvalues(:,24)+sortedvalues(:,38),T,Rraf1phos);
    xlabel('min EGF')
    ylabel('R (molec cell^{-1} min^{-1})')
    title('Rates of RAF1 phosphorylation and dephosphorylation')
    legend('Dephosphorylation','Phosphorylation','location','best')
    box off
    set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
    set(p,'LineWidth',1)

    figure
    p = semilogy(T,sortedvalues(:,24)+sortedvalues(:,38),T,Rraf1phos);
    set(p,'LineWidth',1)
    xlabel('min EGF')
    ylabel('log_{10}(R) (molec cell^{-1} min^{-1}')
    title('Rates of RAF1 phosphorylation and dephosphorylation')
    legend('Dephosphorylation','Phosphorylation','location','best')
    box off
    set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01, 0.01])
    ylim([1.0e-10, 1.0e5])

    figure
    p = plot(T,sortedvalues(:,24)+sortedvalues(:,38),T,Rraf1phos);
    xlabel('min EGF')
    ylabel('R (molec cell^{-1} min^{-1})')
    title('Rates of RAF1 phosphorylation and dephosphorylation')
    legend('Dephosphorylation','Phosphorylation','location','best')
    box off
    set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01, 0.01])
    xlim([15.0, 30.0])
    set(p,'LineWidth',1)

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
    figure
    p = plot(T,allvalues(:,123),rafdata(:,1),rafdata(:,2),'*');
    xlabel('min EGF')
    ylabel('Membrane RAF1 (fraction of total)')
    title('Confirm membrane RAF1 levels')
    set(p,'LineWidth',1)
end


