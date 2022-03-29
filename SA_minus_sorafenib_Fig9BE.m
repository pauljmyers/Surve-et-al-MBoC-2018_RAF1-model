%% model sensitivity analysis --> no sorafenib with refitted Ras-Raf binding parameters
clc
close all
clear
tic
warning('off','all')
%%
% Define parameters names, species names, and relevant indeces from outputs
% of model:
paramindex = [15; 93; 112; 88; 102;...
    12; 10; 18; 14;...
    124; 79;...
    73;...
    71; 36; 33; 92;...
    22; 69; 76; 21];
paramnames = {'[BRaf]';'[Raf1]';'[Ras-GTP]';'[MEK]';'[ERK]';...
    'kB,f'; 'kB,r';'kR1,f';'kR1,r';...
    'kfpR1,r';'kfpB,r';...
    'kdR1,f';...
    'kdR1,r';'kpR1';'knfpBR1';'kdpR1';...
    'kpMEK';'kdpMEK';'kpERK';'kdpERK'};

speciesindex = [3; 4; 5; 8; 11; 12; 13; 14; 16; 17; 20; 22; 24; 25; 26; 122];
speciesnames = {'Ras:BRaf';'Ras:nfpRaf1';...
    'Ras:pRaf1';'pRaf1 dimer';'BRaf:pRaf1 dimer';...
    'pRaf1:Raf1 dimer';'nfpRaf1';'Ras:nfpBRaf';'pMEK';...
    'pRaf1';'Ras:Raf1';'nfpBRaf';'BRaf:Raf1 dimer';'BRaf dimer';...
    'pERK'; 'Membrane Raf1'};
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

options = optimset('MaxFunEvals',1000.*length(my_super_nice_params),'MaxIter',1000.*length(my_super_nice_params));

objfunc = @(x) sum((minus_sorafenib_new_refitted_rasraf_binding(x,timedata) - rasdatanums).^2);
fittedparams = fminsearchbnd(objfunc,my_super_nice_params,zeros(4,1),[],options);

% Baseline model predictions:
[correct_total,T,Y,yinit,param,allNames,allValues] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams);
[boundRaf_frac,ogRaf_pm] = vcell_outputfuncs(allValues);
og_max = max(ogRaf_pm);
og_average = 1./(T(end)-T(1)).*simpsons(ogRaf_pm,T);

basepRAF1ave = (simpsons(allValues(:,5)+allValues(:,7)+allValues(:,8)+allValues(:,11)+allValues(:,12)+allValues(:,17),T))./(T(end)-T(1));
basepRAF1max = max(allValues(:,5)+allValues(:,7)+allValues(:,8)+allValues(:,11)+allValues(:,12)+allValues(:,17));

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
    [~,decT,decY,decyinit,dec_param,allNames,allValuesdec] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams,T,yinit,dec_param);
    
%INCREASE
    [~,incT,incY,incyinit,inc_param,allNames,allValuesinc] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams,T,yinit,inc_param);

%Y SPECIES CALCS
    % Calculate average value of each species over simulation time:
    for j = 1:length(speciesindex)
        decYave(j,1) = simpsons(allValuesdec(:,speciesindex(j)),decT);
        incYave(j,1) = simpsons(allValuesinc(:,speciesindex(j)),incT);
    end
    decpRAF1ave = simpsons((allValuesdec(:,5)+allValuesdec(:,7)+allValuesdec(:,8)+allValuesdec(:,11)+allValuesdec(:,12)+allValuesdec(:,17)),decT);
    incpRAF1ave = simpsons((allValuesinc(:,5)+allValuesinc(:,7)+allValuesinc(:,8)+allValuesinc(:,11)+allValuesinc(:,12)+allValuesinc(:,17)),incT);
    
    decpRAF1ave = decpRAF1ave./(decT(end)-decT(1));
    incpRAF1ave = incpRAF1ave./(incT(end)-incT(1));
    
    decpRAF1max = max(allValuesdec(:,5)+allValuesdec(:,7)+allValuesdec(:,8)+allValuesdec(:,11)+allValuesdec(:,12)+allValuesdec(:,17));
    incpRAF1max = max(allValuesinc(:,5)+allValuesinc(:,7)+allValuesinc(:,8)+allValuesinc(:,11)+allValuesinc(:,12)+allValuesinc(:,17));
    
    decYave = decYave./(decT(end)-decT(1));
    incYave = incYave./(incT(end)-incT(1));
    
    decYmax = max(allValuesdec(:,speciesindex))';
    incYmax = max(allValuesinc(:,speciesindex))';
    
    % Calculate order-of-magnitude differences of species averages compared
    % to base model case:
    decpRAF1avediff = log10(decpRAF1ave./basepRAF1ave);
    incpRAF1avediff = log10(incpRAF1ave./basepRAF1ave);
    
    decpRAF1maxdiff = log10(decpRAF1max./basepRAF1max);
    incpRAF1maxdiff = log10(incpRAF1max./basepRAF1max);
    
    decYavediff = log10(decYave./baseYave);
    incYavediff = log10(incYave./baseYave);
    
    decYmaxdiff = log10(decYmax./baseYmax);
    incYmaxdiff = log10(incYmax./baseYmax);
    
    % Get unnormalized Y sensitivity values:
    avepRAF1sens(1,i) = abs(decpRAF1avediff)+abs(incpRAF1avediff);
    maxpRAF1sens(1,i) = abs(decpRAF1maxdiff)+abs(incpRAF1maxdiff);
    
    aveYsens(:,i) = abs(decYavediff)+abs(incYavediff);
    maxYsens(:,i) = abs(decYmaxdiff)+abs(incYmaxdiff);
    
    %Reset model parameters
    inc_param = param;
    dec_param = param;
end

% 0.1x Ras sensitivity data:
rasdatanums01 = rasdatapcnts.*27;
objfunc01 = @(x) sum((minus_sorafenib_new_refitted_rasraf_binding(x,timedata) - rasdatanums01).^2);
fittedparams01 = fminsearchbnd(objfunc01,my_super_nice_params,zeros(length(params),1),[],options);
[CT_decRas,decTRas,decYRas,yinitincRas,dec_paramRas,~,allValuesdecRas] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams01.*[1 1 1 1],T,yinit);

% 10x Ras sensitivity data:
rasdatanums10 = rasdatapcnts.*2700;
objfunc10 = @(x) sum((minus_sorafenib_new_refitted_rasraf_binding(x,timedata) - rasdatanums10).^2);
fittedparams10 = fminsearchbnd(objfunc10,my_super_nice_params,zeros(length(params),1),[],options);
[CT_incRas,incTRas,incYRas,yinitdecRas,inc_paramRas,~,allValuesincRas] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams10.*[1 1 1 1],T,yinit);


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

RdecpRAF1ave = simpsons((allValuesdec(:,5)+allValuesdec(:,7)+allValuesdec(:,8)+allValuesdec(:,11)+allValuesdec(:,12)+allValuesdec(:,17)),decT);
RincpRAF1ave = simpsons((allValuesinc(:,5)+allValuesinc(:,7)+allValuesinc(:,8)+allValuesinc(:,11)+allValuesinc(:,12)+allValuesinc(:,17)),incT);

RdecpRAF1ave = RdecpRAF1ave./(decT(end)-decT(1));
RincpRAF1ave = RincpRAF1ave./(incT(end)-incT(1));

RdecpRAF1max = max(allValuesdecRas(:,5)+allValuesdecRas(:,7)+allValuesdecRas(:,8)+allValuesdecRas(:,11)+allValuesdecRas(:,12)+allValuesdecRas(:,17));
RincpRAF1max = max(allValuesincRas(:,5)+allValuesincRas(:,7)+allValuesincRas(:,8)+allValuesincRas(:,11)+allValuesincRas(:,12)+allValuesincRas(:,17));

% Calcualte order-of-magnitude differences of species averages compared
% to base model case:
decYRasavediff = log10(decYRasave./baseYave);
incYRasavediff = log10(incYRasave./baseYave);

decYRasmaxdiff = log10(decYRasmax./baseYmax);
incYRasmaxdiff = log10(incYRasmax./baseYmax);

RdecpRAF1avediff = log10(RdecpRAF1ave./basepRAF1ave);
RincpRAF1avediff = log10(RincpRAF1ave./basepRAF1ave);

RdecpRAF1maxdiff = log10(RdecpRAF1max./basepRAF1max);
RincpRAF1maxdiff = log10(RincpRAF1max./basepRAF1max);
%%
% Get unnormalized Y sensitivity values to Ras-GTP:
aveYsensRas = abs(decYRasavediff)+abs(incYRasavediff);
maxYsensRas = abs(decYRasmaxdiff)+abs(incYRasmaxdiff);

RavepRAF1sens = abs(RdecpRAF1avediff)+abs(RincpRAF1avediff);
RmaxpRAF1sens = abs(RdecpRAF1maxdiff)+abs(RincpRAF1maxdiff);

% Replace temporary Ras-GTP sens with unnormalized sensitivity:
aveYsens(:,3) = aveYsensRas;
maxYsens(:,3) = maxYsensRas;

avepRAF1sens(1,3) = RavepRAF1sens;
maxpRAF1sens(1,3) = RmaxpRAF1sens;


% Calculate normalized sensitivities (norm. to max for each variable/output):
aveYsens = aveYsens./max(aveYsens,[],2).*100;
maxYsens = maxYsens./max(maxYsens,[],2).*100;

% Calculate normalized pRAF1 sensitivies (norm. to max):
avepRAF1sens = avepRAF1sens./max(avepRAF1sens).*100.0;
maxpRAF1sens = maxpRAF1sens./max(maxpRAF1sens).*100.0;
%% creating plots
clc
close all

% Time-averaged membrane RAF1 results (reparameterized model): Figure 9B, row 4 ***
figure
hm1 = heatmap(labels,'Membrane Raf1 (average)',aveYsens(4,:));
xtickangle(90)
caxis([0 100])
colormap(jet)

% Results for time-averaged values of all model outputs:
figure
hm2 = heatmap(labels,speciesnames,aveYsens);
xtickangle(90)
caxis([0 100])
colormap(jet)
title('Time-averaged model outputs')

% Maximum membrane RAF1 results (reparameterized model): Figure 9B, row 3 ***
figure
hm3 = heatmap(labels,'Membrane Raf1 (maximum)',maxYsens(4,:));
xtickangle(90)
caxis([0 100])
colormap(jet)
title('Reparameterized model')

% Results for maxima of all model outputs:
figure
hm4 = heatmap(labels,speciesnames,maxYsens);
xtickangle(90)
caxis([0 100])
colormap(jet)
title('Maxima of model outputs')


% ----------- pRAF results ----------- %
% Time-averaged pRAF1 results (reparameterized model): Figure 9E, row 2 ***
figure
hm5 = heatmap(labels,'Average pRAF1',avepRAF1sens);
xtickangle(90)
caxis([0 100])
colormap(jet)

% Maximum pRAF1 results (reparameterized model): Figure 9E, row 1 ***
figure
hm6 = heatmap(labels,'Maximum pRAF1',maxpRAF1sens);
xtickangle(90)
caxis([0 100])
colormap(jet)

