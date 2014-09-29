function [ result ] = function12( s,i,x,W,gammas )
%This is integral [10] in the paper

N=length(x)/3;
alphas=x(2*N+1:end);
e=exp(1);
Gamma=5.5294;

factor1=(Gamma*log(2)*alphas(i)/(W*gammas(i)));
factor2=2.^(s.*alphas(i)/W);
factor3=e.^(Gamma*(1-2.^(s.*alphas(i)/W))/gammas(i));
factor4=1;
 for j=1:N
     if i~=j
        factor4=factor4.*(1-e.^(Gamma*(1-2.^(alphas(j).*s/W))/gammas(j)));
     end
 end
result=factor1.*factor2.*factor3.*factor4;
end

