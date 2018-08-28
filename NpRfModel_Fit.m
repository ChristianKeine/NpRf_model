function EPSC_Diff = NpRfModel_Fit(Data,f,P)

EPSC = NpRfModel_FitFun(Data,f,P);

EPSC_Diff = cumsum(EPSC(:))-cumsum(Data(:));
% EPSC_Diff = EPSC(:)-Data(:);



