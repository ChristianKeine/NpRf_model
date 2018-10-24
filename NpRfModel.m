function [Res]=NpRfModel(Data)
%
% calculates synaptic parameters by fitting synaptic currents from train stimulation to NpRf model.
% Estimates N (RRP size), p (initial release probability), R (replenishment), and f (synaptic facilitation).
%
% Input arguments: PSC amplitudes from train stimulation
% output arguments: Struct containing values for f, N0, p, R and the EPSC fit function;
%
% when using this function, please cite the following publication:
% Thanawala MS, Regehr WG (2016): Determining Synaptic Parameters Using High-Frequency Activation. J Neurosci Methods 264:136–152.

Data = abs(Data);
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

%set starting points of fit
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

end

function EPSC_Diff = NpRfModel_Fit(Data,f,P)

EPSC = NpRfModel_FitFun(Data,f,P);

EPSC_Diff = cumsum(EPSC(:))-cumsum(Data(:));
% EPSC_Diff = EPSC(:)-Data(:);
end

function [EPSC,N,Rep,f] = NpRfModel_FitFun(Data,f,P)

N(1) = P(1);
p = P(2);
R = P(3);

EPSC(1) = p*N(1);
N(2) = N(1)*(1-p+p*R);
EPSC(2) = p*f*N(2);

Rep(2) = R*p*N(1);

for t=3:numel(Data)
    N(t) = N(t-1)*(1-p*f-R+p*f*R)+N(1)*R;
    EPSC(t) = p*f*N(t);
    Rep(t) = N(t-1)*R*(p*f-1)+N(1)*R;
end


end
