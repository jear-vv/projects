%% Load Data

load('C:\TrainDATAtoyGaussian1D.mat','x1');
mus=[0 3];
sigmas=[0.5  1];
pis=[0.5 0.5];
C=2;
N=x1;
for i=1:N
    for j=1:C
nom=mvnpdf(X(i),mus(j)',sigmas(j)').*pis(j)' ;
denom=sigma(
    end
end
