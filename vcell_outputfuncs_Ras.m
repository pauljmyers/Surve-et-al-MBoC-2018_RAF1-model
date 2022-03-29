
function [boundRaf_frac,Raf_pm] = vcell_outputfuncs_Ras(allValues)
size_all = size(allValues);
len = size_all(1);



% Raf_pm = zeros(len,1);
% Raf_cyt = zeros(len,1);
% boundRaf_frac = zeros(len,1);
% frac_Rac1_dimerized = zeros(len,1);

Raf_pm = allValues(:,121);
boundRaf_frac = allValues(:,122);
end