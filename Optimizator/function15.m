function [ result ] = function15( s,i,x,W,gammas )
%This is integral [12] in the paper
N=length(x)/3;
alphas=x(2*N+1:end);
Gamma=5.5294;

factor1=s.*(Gamma*log(2)*alphas(i))/(W*gammas(i)*x(i));
factor2=2.^(alphas(i).*s/W).*exp(Gamma*(1-2.^(alphas(i).*s/W))/gammas(i));
factor3=1;
for j=1:N
    if i~=j
        factor3=factor3.*(1-exp(Gamma*(1-2.^(alphas(j).*s/W))/gammas(j)));
    end
end
result=factor1.*factor2.*factor3;
end

