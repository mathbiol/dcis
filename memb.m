function [y,dt]=memb(xo,dt)

% function [y,dt]=memb(xo,dt)
% builds membership function
% xo: raw data
% y: xo represented as membership
% dt: distribution (two column matrix)
%     if not provided it will be calculated

%disp(':-)')
if nargin<2
   x=sort(xo(:));
   n=length(x);
   sx=(0:(1/(n-1)):1)';
   % Cut repeats
   rep_i=find(x(1:end-1)==x(2:end))+1;
   x(rep_i)=[];sx(rep_i)=[];
   % rescaling between 0 and 1
   % sx=(sx-sx(1))/(sx(end)-sx(1));
   dt=[x,sx];
end

y=interp1(dt(:,1),dt(:,2),xo);