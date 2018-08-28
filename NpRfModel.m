function [Res]=NpRfModel(Data)
% based on Thanawala MS, Regehr WG (2016) Determining Synaptic Parameters Using High-Frequency Activation. J Neurosci Methods 264:136–152.
% fit to EPSC data with free variables: f, N0, p and R;
% 
% input arguments: EPSC amplitudes
% output arguments: Struct containing values for f, N0, p and R;

PPR = Data(2)/Data(1);

ft=fittype('a*exp(-x/tau)+c');
fo = fitoptions(ft);
if PPR<1
    x = 1:numel(Data);
    y = Data;
elseif PPR>=1
    x = 2:numel(Data);
    y = Data(2:end);
end
fo.StartPoint = [y(1),1,5]; fo.Lower = [0 0 0];

[FO] = fit(x(:)-1,y(:),ft,fo);

f = FO(0)/Data(1);


oldoptions = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective',...
    'MaxFunctionEvaluations',5000,'StepTolerance',1e-9,...
    'FunctionTolerance',1e-9,'MaxIterations',1500,'Display','none');

P0 = [30,0.1,0.02];
PL = [0 0 0];
PU = [Inf Inf Inf];


fun = @(P0) NpRfModel_Fit(Data,f,P0);

PF = lsqnonlin(fun,P0,PL,PU,oldoptions);

[Res.EPSCs_Model,~,~,f] = NpRfModel_FitFun(Data,f,PF);

Res.Pr = PF(2);
Res.RRP = PF(1);
Res.replenishment = PF(3);
Res.facilitation = f;




