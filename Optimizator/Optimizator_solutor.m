clear all;
close all;
clc


N=10;
SNR_min_dB=10;
SNR_avg_dB=15;


SNR_min=10^(SNR_min_dB/10);
SNR_avg=10^(SNR_avg_dB/10);
gammas=linspace(SNR_min,SNR_avg+(SNR_avg-SNR_min),N);   %Generate the average SINR distribution
gammas_dB=10*log10(gammas);
Gamma=5.53;                                             %SINR gap

inverse=1./gammas_dB;               %Consider the inverse of SNRs
inverse=1/sum(inverse)*inverse;     %Normalize probabilities to sum to one
x0=zeros(1,3*N);
x0(1:N)=inverse;                    %x0(1:N) is the initial access probability
x0(N+1:2*N)= 0.2 * gammas_dB;       %x0(N+1:2*N) is the initial average rate \bar(R)
x0(2*N+1:end)= 0.5 * gammas_dB;     %x0(2*N+1:end) is the initial alpha

%Show the trace of the optimization problem
options = optimoptions('fsolve','Display','iter');
options.MaxFunEvals=6000;

%Solve the system of equations
[x,fval] = fsolve(@(x)myfun(x,N,gammas),x0,options);

%Results to the optimization problem
pOpt=x(1:N);
rOpt=x(N+1:2*N);
aOpt=x(2*N+1:end);

epsilon=10^(-5);
if abs((sum(pOpt)-1))>epsilon
    disp('The problem has not been solved: probabilities don''t sum to one!');
else
    disp('The problem has been solved.');
end


%Generate the file alphas.txt that can be imported by ns3
fileID = fopen('alphas.txt','w');
fprintf(fileID,'%12.8f\n',aOpt');
fclose(fileID);