function [boundRaf_frac,Raf_pm] = vcell_outputfuncs(allValues)
size_all = size(allValues);
len = size_all(1);


Raf1_pm_param = allValues(:,122);
Raf1_cyt_param = allValues(:,33);
boundRaf_frac_parameter = allValues(:,123);

Raf_pm = Raf1_pm_param;
boundRaf_frac = boundRaf_frac_parameter;
end