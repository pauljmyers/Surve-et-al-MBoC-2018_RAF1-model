tic
clear
clc
%%
fittedparams = [21910.6052602647;3.30222950844396;5.40187714674488e+16;1.42933217919049e+15];
n1 = 20;
n2 = 20;
n3 = 1000;
x = n1:n2:n3;
% list = zeros(n3/n2,1);
iteration = 0;
% uni = [0.890681876688104,90.5913775220174,100,0.400977066597967,0.731382423431812,0.863974998869911,0.0462731963272133,77.4793435132122,77.1382224404324,0.218386159568867,1.58621142338121e-07,2.40081371266846,9.27769962413710,1.23185491962608,0.730933882635555,1.11575050988566,0.396075833038556,0.0463990093098660,0.400982152096981,0.0468217487298841];
plsr_sens = zeros(n1,n3/n2);
rng('default')

% tic
% for i = 1:(n3/n2)     % run calcs serially
parfor i = 1:(n3/n2)    % run calcs in parallel
    tic
%     iteration = iteration + 1
    num = i*n2
    [plsr_sens_i] = PLSR_SA_func(num,fittedparams);
    
    plsr_sens(:,i) = plsr_sens_i;
%     change = abs(plsr_sens - plsr_sens_old);
    
%     plsr_sens_old = plsr_sens;
%     ave_change = mean(change);
%     list(iteration) = ave_change;
%     clear ave_change
    toc
end
% toc
%%
change = abs(plsr_sens(2:end,:) - plsr_sens(1:end-1,:)); % differences between sets of parameters
ave_change = mean(change);
% list = ave_change;

%% Plot of PLSR-SA convergence for Figure S5B
close all
figure;
plot(x,ave_change,'b.','MarkerSize',15.0)
xlabel('Number of random parameter sets')
ylabel({'Mean change in PLSR parameter loadings';'compared to previous parameter set'})
title('Convergence of PLSR results')
ylim([0 50])
hold on