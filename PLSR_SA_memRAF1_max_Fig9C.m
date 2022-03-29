clear
clc
close all
rng('default')
%%
number = 3000; % total number of parameter sets to use

params = [21910.6052602647;3.30222950844396;5.40187714674488e+16;1.42933217919049e+15];
my_super_nice_params = params;
timedata =  [0 2.5 5.0 10.0 15.0 30.0 60.0]';
rasdatapcnts = [0 99.46 94.34 61.31 13.59 5.53 14.51]';
rasdatanums = rasdatapcnts.*270;

options = optimset('MaxFunEvals', 1000.*length(my_super_nice_params),'MaxIter',100*length(my_super_nice_params));

objfunc = @(x) sum((minus_sorafenib_new_refitted_rasraf_binding(x,timedata) - rasdatanums).^2);
fittedparams = fminsearchbnd(objfunc,my_super_nice_params,zeros(length(params),1),[],options);

% Define parameters of interest:
wanted_param = [15; 93; 112; 88; 102;...
    12; 10; 18; 14;...
    124; 79;...
    73;...
    71; 36; 33; 92;...
    22; 69; 76; 21];
names = {'\it[BRaf]';'\it[Raf1]';'\it[Ras-GTP]';'\it[MEK]';'\itERK';...
    '\itk_{B,f}'; '\itk_{B,r}';'\itk_{R1,f}';'\itk_{R1,r}';...
    '\itk_{fpR1,r}';'\itk_{fpB,r}';...
    '\itk_{dR1,f}';...
    '\itk_{dR1,r}';'\itk_{pR1}';'\itk_{nfpBR1}';'\itk_{dpR1}';...
    '\itk_{pMEK}';'\itk_{dpMEK}';'\itk_{pERK}';'\itk_{dpERK}'};

%% Run PLSR-based sensitivity analysis
% Get baseline values:
[~,T,~,yinit,param,~,allValues] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams);
ogRaf = allValues(:,122);
old_ave = simpsons(ogRaf,T);
% define number of random sets of parameters if not given

% Initiate matrices & lists:
really_random_change_matrix = zeros(number,length(wanted_param));
my_other_params = zeros(number,length(wanted_param));
remove_list = [];

% Generate randomized parameters and calculate model results:
my_y = zeros(number,1);
iteration = 0;
parfor count = 1:number
    clc
    iteration = iteration + 1
    super = -1 + 2 * rand(length(wanted_param),1);
    super = super';
    changed_params = param;
    my_changed_params = zeros(1,length(wanted_param));
    for i = 1:length(wanted_param)
        changed_params(wanted_param(i)) = param(wanted_param(i)) * 10^(super(i));
        my_changed_params(i) = changed_params(wanted_param(i));
    end
    [~,Tnew,~,~  ,~,~,allValues] = minus_sorafenib_new_refitted_rasraf_binding(fittedparams.*[10^super(3) 1 10^super(3) 1],T,yinit,changed_params);
    Raf_pm = allValues(:,122);  % membrane RAF1 concentration
    new_max = max(Raf_pm);    % calculate maximum value
    my_y(count) = new_max;
    percent_change = abs(new_max - old_ave) / old_ave * 100;
    really_random_change_matrix(count,:) = super;
    my_other_params(count,:) = my_changed_params;
end

param_size = size(my_other_params);
observations = param_size(1);
my_log_params = zeros(param_size);
for o = 1:observations
    for p = 1:length(wanted_param)
        if my_other_params(o,p) == 0
            my_log_params(o,p) = my_other_params(o,p);
        else
            my_log_params(o,p) = log10(my_other_params(o,p));
        end
    end
end

% Standardize parameter values
z_scores = zeros(number,length(wanted_param)); %-size_r when removing aka one iteration
for p = 1:length(wanted_param)
    x = my_log_params(:,p);
    Zsc = @(x) (x - mean(x))./std(x);   % Z-score function
    Zx = Zsc(x)  ;
    z_scores(:,p) = Zx;
end
%%
% PLSR:
[Xloadings,YL,XS,YS,BETA,PCTVAR,PLSmsep] = plsregress(z_scores,my_y,12,'CV',10);
Q2Y = 1-PLSmsep(2,2:end)./(sum((my_y-mean(my_y)).^2)./length(my_y))

% Turn loadings into sensitivities:
max_loadings = max(abs(Xloadings(:,1)));
sensitivities = zeros(size(Xloadings(:,1)));
for p = 1:length(wanted_param)
    sensitivities(p) = abs(Xloadings(p,1)) / max_loadings * 100;
end

%% Plot loadings -- Figure 9C, column 1
close all
figure
bar(categorical(names), Xloadings(:,1), 'b')
ylabel('Parameter loadings')
title('Maximum Membrane RAF1')
xtickangle(90)

