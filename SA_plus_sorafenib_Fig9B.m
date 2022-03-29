%% model sensitivity analysis --> no sorafenib with refitted Ras-Raf binding parameters
clc
close all
clear
tic
warning('off','all')
%%
% Define parameters names, species names, and relevant indeces from outputs
% of model:
paramindex = [17; 96; 116; 91; 106;...
    77; 74; 53; 48;... % NOTE: These are the rate constants for INHIBITED RAF1/BRAF binding to RAS-GTP
    128; 81;...
    75;...
    73; 37; 34; 95;...
    24; 71; 78; 23; 45; 56];
paramnames = {'[BRaf]';'[Raf1]';'[Ras-GTP]';'[MEK]';'[ERK]';...
    'kB,f'; 'kB,r';'kR1,f';'kR1,r';... % NOTE: These are the rate constants for INHIBITED RAF1/BRAF binding to RAS-GTP
    'kfpR1,r';'kfpB,r';...
    'kdR1,f';...
    'kdR1,r';'kpR1';'knfpBR1';'kdpR1';...
    'kpMEK';'kdpMEK';'kpERK';'kdpERK';'kS,on';'kS,off'};

speciesindex = [1:1:32,130]';
speciesindex([5,10,17,26]) = [];
speciesnames = {'Ras:iBRaf';'Raf1:iBRaf dimer';'Ras:BRaf';'Ras:nfpRaf1';...
    'Ras:pRaf1';'BRaf:iBRaf dimer';'pRaf1:iBRaf dimer';...
    'pRaf1 dimer';'Ras:nfpiRaf1';'nfpiRaf1';...
    'BRaf:pRaf1 dimer';'pRaf1:Raf1 dimer';'nfpRaf1';'Ras:nfpBRaf';'pMEK';...
    'pRaf1';'Ras:iRaf1';'Ras:nfpiBRaf';'BRaf:iRaf1 dimer';...
    'Ras:Raf1';'nfpiBraf';'nfpBRaf';'iRaf1 dimer';...
    'iBRaf dimer';'BRaf:Raf1 dimer';'BRaf dimer';...
    'pERK';'iRaf1:iBRaf dimer';'Membrane Raf1'};
[speciesnames,I] = sort(speciesnames);
speciesindex = speciesindex(I);
labels = paramnames';
%% Run sensitivity analysis
% RAS parameters:
A = 16000;
B = 15;
C = 100;
D = 1.6;

params = [A B C D]';
my_super_nice_params = params;
timedata =  [0 2.5 5.0 10.0 15.0 30.0 60.0]';
rasdatapcnts = [0 99.46 94.34 61.31 13.59 5.53 14.51]';
rasdatanums = rasdatapcnts.*270;

options = optimset('MaxFunEvals', 1000.*length(my_super_nice_params),'MaxIter',1000*length(my_super_nice_params));

objfunc = @(x) sum((plus_sorafenib_new(x,timedata) - rasdatanums).^2);
fittedparams = fminsearchbnd(objfunc,my_super_nice_params,zeros(4,1),[],options);

% Baseline model predictions:
[correct_total,T,Y,yinit,param,allNames,allValues] = plus_sorafenib_new(fittedparams);
[boundRaf_frac,ogRaf_pm] = vcell_outputfuncs_sorafenib(allValues);
og_max = max(ogRaf_pm);
og_average = 1./(T(end)-T(1)).*simpsons(ogRaf_pm,T);


baseYave = zeros(length(speciesindex),1);
for i = 1:length(speciesindex)
    baseYave(i) = simpsons(allValues(:,speciesindex(i)),T);
end
baseYave = baseYave./(T(end)-T(1));
baseYmax = max(allValues(:,speciesindex))';


% Initialize sensitivity matrices and calculate sensitivities:
cell_wanted = (num2cell(paramindex));

names_nums = horzcat(cell_wanted, paramnames);
store = zeros(length(T),length(paramindex),2);
inc_param = param;
dec_param = param;

options = optimset('MaxFunEvals', 1000.*length(my_super_nice_params),'MaxIter',1000.*length(my_super_nice_params));
for i = 1:length(paramindex)
    dec_param(paramindex(i)) = 0.1 .* param(paramindex(i));
    inc_param(paramindex(i)) = 10 .* param(paramindex(i));

%DECREASE
    [~,decT,decY,decyinit,dec_param,allNames,allValuesdec] = plus_sorafenib_new(fittedparams,T,yinit,dec_param);
   
%INCREASE
    [~,incT,incY,incyinit,inc_param,allNames,allValuesinc] = plus_sorafenib_new(fittedparams,T,yinit,inc_param);

    
%OUTPUT CALCS
    % Calculate average value of each species over simulation time:
    for j = 1:length(speciesindex)
        decYave(j,1) = simpsons(allValuesdec(:,speciesindex(j)),decT);
        incYave(j,1) = simpsons(allValuesinc(:,speciesindex(j)),incT);
    end
    decYave = decYave./(decT(end)-decT(1));
    incYave = incYave./(incT(end)-incT(1));
    
    decYmax = max(allValuesdec(:,speciesindex))';
    incYmax = max(allValuesinc(:,speciesindex))';
    
    % Calculate order-of-magnitude differences of species averages compared
    % to base model case:
    decYavediff = log10(decYave./baseYave);
    incYavediff = log10(incYave./baseYave);
    
    decYmaxdiff = log10(decYmax./baseYmax);
    incYmaxdiff = log10(incYmax./baseYmax);
    
    % Get unnormalized Y sensitivity values:
    aveYsens(:,i) = abs(decYavediff)+abs(incYavediff);
    maxYsens(:,i) = abs(decYmaxdiff)+abs(incYmaxdiff);
    
    %Reset model parameters
    inc_param = param;
    dec_param = param;
end

% 0.1x Ras sensitivity data:
rasdatanums01 = rasdatapcnts.*27;
objfunc01 = @(x) sum((plus_sorafenib_new(x,timedata) - rasdatanums01).^2);
fittedparams01 = fminsearchbnd(objfunc01,my_super_nice_params,zeros(length(params),1),[],options);
[CT_decRas,decTRas,decYRas,yinitincRas,dec_paramRas,~,allValuesdecRas] = plus_sorafenib_new(fittedparams01.*[1 1 1 1],T,yinit);

% 10x Ras sensitivity data:
rasdatanums10 = rasdatapcnts.*2700;
objfunc10 = @(x) sum((plus_sorafenib_new(x,timedata) - rasdatanums10).^2);
fittedparams10 = fminsearchbnd(objfunc10,my_super_nice_params,zeros(length(params),1),[],options);
[CT_incRas,incTRas,incYRas,yinitdecRas,inc_paramRas,~,allValuesincRas] = plus_sorafenib_new(fittedparams10.*[1 1 1 1],T,yinit);

%% Y SPECIES CALCS
% Get Ras-GTP sensitivities:
for j = 1:length(speciesindex)
    decYRasave(j,1) = simpsons(allValuesdecRas(:,speciesindex(j)),decTRas);
    incYRasave(j,1) = simpsons(allValuesincRas(:,speciesindex(j)),incTRas);
end
decYRasave = decYRasave./(decT(end)-decT(1));
incYRasave = incYRasave./(incT(end)-incT(1));

decYRasmax = max(allValuesdecRas(:,speciesindex))';
incYRasmax = max(allValuesincRas(:,speciesindex))';

% Calculate order-of-magnitude differences of species averages compared
% to base model case:
decYRasavediff = log10(decYRasave./baseYave);
incYRasavediff = log10(incYRasave./baseYave);

decYRasmaxdiff = log10(decYRasmax./baseYmax);
incYRasmaxdiff = log10(incYRasmax./baseYmax);

% Get unnormalized Y sensitivity values to Ras-GTP:
aveYsensRas = abs(decYRasavediff)+abs(incYRasavediff);
maxYsensRas = abs(decYRasmaxdiff)+abs(incYRasmaxdiff);

% Replace temporary Ras-GTP sens with unnormalized sensitivity:
aveYsens(:,3) = aveYsensRas;
maxYsens(:,3) = maxYsensRas;

% Calculate normalized sensitivities (norm. to max for each variable/output):
maxaveYsens = max(aveYsens,[],2);
maxmaxYsens = max(maxYsens,[],2);

aveYsens = aveYsens./maxaveYsens.*100;
maxYsens = maxYsens./maxmaxYsens.*100;
%% creating plots
clc
close all

% Time-averaged membrane RAF1 results (reparameterized model, +sfnb): Figure 9B, row 6 ***
figure
hm1 = heatmap(labels,'Membrane Raf1 (average)',aveYsens(6,:));
xtickangle(90)
caxis([0 100])
colormap(jet)

% Results for time-averaged values of all model outputs:
figure
hm2 = heatmap(labels,speciesnames,aveYsens);
xtickangle(90)
colormap(jet)
title('Time-averaged model outputs')

% Maximum membrane RAF1 results (reparameterized model, +sfnb): Figure 9B, row 5 ***
figure
hm3 = heatmap(labels,'Membrane Raf1 (maximum)',maxYsens(6,:));
xtickangle(90)
caxis([0 100])
colormap(jet)
title('Reparameterized model, +Sorafenib')

% Results for maxima of all model outputs:
figure
hm4 = heatmap(labels,speciesnames,maxYsens);
xtickangle(90)
caxis([0 100])
colormap(jet)
title('Maxima of model outputs')

