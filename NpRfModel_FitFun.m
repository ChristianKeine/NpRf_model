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