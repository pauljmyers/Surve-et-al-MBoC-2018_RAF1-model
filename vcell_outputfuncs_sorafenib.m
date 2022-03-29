
function [boundRaf_frac, Raf_pm] = vcell_outputfuncs_sorafenib(allValues)


% Raf_pm = zeros(len,1);
% Raf_cyt = zeros(len,1);
% boundRaf_frac = zeros(len,1);


Raf1_pm_param = allValues(:,130);
Raf1_cyt_param = allValues(:,37);
boundRaf_frac_parameter = allValues(:,131);

Raf_pm = Raf1_pm_param;
boundRaf_frac = boundRaf_frac_parameter;
end