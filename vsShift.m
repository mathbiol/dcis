function y=vsShift(dt,i,j,p)

%y=vsShift(dt,i,j,p) produces table with .vs shifts between effect i and j. 
% Note that normally this would be applied to dtQ, not dt, such that the
% quantile shift is produced. Default p is 0.05
%
% Jonas ALmeida Sept 2013

if nargin<3;j=nan;end
if nargin<4;p=nan;end

ss = [dt.vs(:,1:3)-repmat(dt.vs(:,i),[1,3])]; % all shifts

if ~isnan(j) % if j is defined
    s=ss(:,j);
else % if the comparison is with all others effects
    s=ss;
    s(:,i)=[]; % remove identity comparison (all 1's)
    s = sum(ss,2);
end

q=memb(abs(s)); % quantile of the ABSOLUTE shift

if isnan(p);p=0.05;end %default p value
[lala,I]=sort(-q); % sort ABSOLUTE order of shifts

Imax=floor(length(q)*p);
warning off
y=[]; % colect results here
for i=1:Imax
    ii=I(i);
    disp([num2str(i),' (',num2str(s(ii)),') ',showGene(dt,ii)])
    y=[y;[ii,s(ii)]];
end
warning on

% note positions in plot
close all;h=haradaPlot(dt,'vs3d')

hold on
for i=1:Imax
    ii=I(i);
    %disp([num2str(i),' (',num2str(s(ii)),') ',showGene(dt,ii)])
    text(dt.vs(ii,1),dt.vs(ii,2),dt.vs(ii,3),[' ',num2str(i)],'Color','r');
    plot3(dt.vs(ii,1),dt.vs(ii,2),dt.vs(ii,3),'ro')
end
hold off

% Scree plot
figure;
plot(abs(y(:,2)),'o-');
grid on
xlabel ('rank #');ylabel('shift');








