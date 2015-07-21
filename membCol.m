function y=membCol(x)

% function y=membCol(x)
% Applies memb function to each column of 2D array x
% note no distribution is provided, or collected
% may be worth developping that code here the same way that it is available
% in memb

[n,m]=size(x);
y=x; % ini y
for i=1:m
    y(:,i)=memb(x(:,i));
end