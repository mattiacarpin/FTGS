function F = myfun(x,N,gammas)
W=1;
F=zeros(3*N,1);
%Compute the result of equation (5) [Equation (4) in the paper]
j=1;
for i=1:N
    R_i=x(N+i);
    summation=sum(1./(x(N+1:2*N)));
    F(j)=x(i)-1/(R_i*summation); j=j+1;
end

%Solve equation (12)   [Equation (10) in the paper]
for i=1:N
    F(j) = x(i)-integral(@(s)function12(s,i,x,W,gammas),0,40);
    j=j+1;
end

%Solve equation (15)   [Equation (12) in the paper]
for i=1:N
    F(j) = (x(N+i)/x(2*N+i))-integral(@(s)function15(s,i,x,W,gammas),0,40);
    j=j+1;
end
end
