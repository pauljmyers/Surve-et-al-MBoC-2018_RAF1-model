%% Comparisons of membrane RAF1 abundance from model and experiment with overexpress RAS or RAF1
%% fitting Ras dynamics for EGF simulation
clear
close all
clc

params = [21910.6052602647;3.30222950844396;5.40187714674488e+16;1.42933217919049e+15];
my_super_nice_params = params;
timedata =  [0 2.5 5.0 10.0 15.0 30.0 60.0]';
rasdatapcnts = [0 99.46 94.34 61.31 13.59 5.53 14.51]';
X = 3.0;
rasdatanums = rasdatapcnts.*270.*X;%2700; %10x RAS-GTP

objfunc = @(x) sum((minus_sorafenib_new_refitted_rasraf_binding(x,timedata) - rasdatanums).^2);

options = optimset('MaxFunEvals', 1000.*length(my_super_nice_params),'MaxIter',1000.*length(my_super_nice_params));

fittedparams = fminsearchbnd(objfunc,my_super_nice_params,zeros(length(params),1),[],options);
%% 3x stimulated Ras-GTP
[correct_total,Tstim,Ystim,yinit,paramstim,allNamesstim,allValuesstim] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams.*[1 1 1 1],[0,60]);
[boundRaf_frac,ogRaf_pm] = vcell_outputfuncs(allValuesstim);

% Raf1pm_stimRas_max = max(ogRaf_pm)
Raf1pm_stimRas_max = max(boundRaf_frac).*100

%% 2x RAF1 and RAF1-YFP comparison
%1x transient Ras-GTP activation --> for comparison to all other model results
objfunc = @(y) sum((minus_sorafenib_new_refitted_rasraf_binding(y,timedata) - rasdatanums./X).^2);
fittedparams = fminsearchbnd(objfunc,my_super_nice_params,zeros(length(params),1),[],options);

[~,~,~,~,params10xraf1,~,allValues] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams);
[Raf1model_1xRaf1,Raf_pm] = vcell_outputfuncs(allValues);
basemodelmaxRAF1pct = max(Raf1model_1xRaf1).*100;

%2x RAF1 model prediction with transient Ras-GTP
params10xraf1(93) = 2.*params10xraf1(93);

objfunc = @(y) sum((minus_sorafenib_new_refitted_rasraf_binding(y,timedata,[],params10xraf1) - rasdatanums./X).^2);
fittedparams = fminsearchbnd(objfunc,my_super_nice_params,zeros(length(params),1),[],options);

[~,~,~,~,~,~,allValues] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams,[],[],params10xraf1);
[Raf1model_2xRaf1,Raf_pm2x] = vcell_outputfuncs(allValues);
%% constitutively active Ras
%3x
[~,~,yinitconst,param,~, ~] = constant_rasgtp_new([0,240]);
yinitconst(6) = yinitconst(6).*3;%10;
[T,Y,~,~, allNames3x, allValues3x] = constant_rasgtp_new([0,240],yinitconst,param);
[boundRaf_fracconst, ogRaf_pmconst] = vcell_outputfuncs_Ras(allValues3x);
% Raf1pm_constitRas_eq = ogRaf_pmconst(end)
Raf1pm_constitRas_eq3x = boundRaf_fracconst(end).*100

%2x
[~,~,yinitconst,param,~, ~] = constant_rasgtp_new([0,240]);
yinitconst(6) = yinitconst(6).*2;
[T2,Y2,yinitconst2,param2, allNames2, allValues2] = constant_rasgtp_new([0,240],yinitconst,param);
[boundRaf_fracconst2, ogRaf_pmconst2] = vcell_outputfuncs_Ras(allValues2);
% Raf1pm_constitRas_eq = ogRaf_pmconst(end)
Raf1pm_constitRas_eq2x = boundRaf_fracconst2(end).*100

%% Membrane RAF1 values for HeLa cells expressing CFP-HRAS, CFP-HRAS-G12V, and RAF1-YFP
expRAF1 = [(0.306700971-0.147578976)./0.147578976; %CFP-HRAS w/ EGF-Rh
    (0.233522559-0.147578976)./0.147578976].*100; %CFP-HRAS-G12V
expRAF1error = [0.128199084;
    0.00305507].*100;

expRAF1YFP = 0.251520591; %RAF1-YFP w/ EGF-Rh
expRAF1YFPerror = 0.048319776.*100;
%% Figure S5C
close all
rasgtp_3x = (Raf1pm_stimRas_max-basemodelmaxRAF1pct)./basemodelmaxRAF1pct.*100;
rasconst_3x = (Raf1pm_constitRas_eq3x-basemodelmaxRAF1pct)./basemodelmaxRAF1pct.*100;

values = [rasgtp_3x, rasconst_3x; expRAF1(1), expRAF1(2)];
names = categorical({'+EGF, 3x RAS-GTP','3x constitutively active RAS',...
    '+EGF, CFP-HRAS','CFP-HRAS-G12V'});

% +EGF conditions:
figure
vals1 = [expRAF1(1); rasgtp_3x];
names1 = categorical({'CFP-HRAS';'3x RAS-GTP'});
b1 = bar(names1(2), vals1(1), 'grouped', 'FaceColor', 'flat', 'LineWidth', 1.0);
b1.CData(1,:) = [1 1 1];
hold on
b11 = bar(names1(1), vals1(2), 'grouped', 'FaceColor', 'flat', 'LineWidth', 1.0);
b11.CData(1,:) = [0 0 0];
xticklabels(names1)
ylabel('% increase in membrane RAF1')
xlabel('+EGF')
box off
set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
hold on
errorbar(vals1,[expRAF1error(1); 0], 'k.', 'LineWidth', 1.0)
legend({'HeLa/RAF1-mV','Model prediction'}, 'location','northwest')

% Constitutively active Ras conditions:
figure
vals2 = [expRAF1(2), rasconst_3x];
names2 = categorical({'CFP-HRAS-G12V';'3x constitutively active RAS'});
b2 = bar(names2(2), vals2(1), 'grouped', 'FaceColor', 'flat', 'LineWidth', 1.0);
b2.CData(1,:) = [1 1 1];
hold on
b21 = bar(names2(1), vals2(2), 'grouped', 'FaceColor', 'flat', 'LineWidth', 1.0);
b21.CData(1,:) = [0 0 0];
xticklabels(names2)
ylabel('% increase in membrane RAF1')
box off
set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
hold on
errorbar(vals2,[expRAF1error(2); 0], 'k.', 'LineWidth', 1.0)
legend({'HeLa/RAF1-mV','Model prediction'},'location','northwest');
%% Figure S5D
% Compile values for comparison to RAF1-YFP data (from Sasha):
values10xRAF1 = [expRAF1YFP; max(Raf1model_2xRaf1)].*100;

expPCTinc = (0.251520591-0.147578976)./0.147578976.*100;
modelPCTinc = (max(Raf_pm2x)-max(Raf_pm))./max(Raf_pm).*100;


figure
vals3 = [expPCTinc; modelPCTinc];
names3 = categorical({'EGF-Rh';'2x [RAF1]',});
b3 = bar(names3(2), vals3(1), 'grouped', 'FaceColor', 'flat', 'LineWidth', 1.0);
b3.CData(1,:) = [1 1 1];
hold on
b31 = bar(names3(1), vals3(2), 'grouped', 'FaceColor', 'flat', 'LineWidth', 1.0);
b31.CData(1,:) = [0 0 0];
xticklabels(names3)
ylabel('% increase in membrane RAF1')
box off
set(gca,'TickDir','out','LineWidth',1.0,'TickLength',[0.01 0.01])
hold on
errorbar(vals3, [expRAF1YFPerror; 0], 'k.', 'LineWidth', 1.0)
legend({'HeLa/RAF1-YFP','Model prediction'},'location','northwest');


