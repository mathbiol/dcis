function tb = shiftTable(n,m)

% tb = shiftStat(n,m) creates a distribution table for quantile shifts
% n is teh number of elements in the quantile vector
% m is the number of iterations, default is 1000
%
% Jonas Almeida September 2013

if nargin <2
    m=1000;
end

% I'm sure this can be optmized, lets do it right first:
% random values:
r1 = rand(n,m);
[lala,q1] = sort(r1);
r2 = rand(n,m);
[lala,q2] = sort(r2);
qs=q1./n-q2./n; %quantile shift
tb=abs(sort(-abs(qs)));



