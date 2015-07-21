%%% Report on Shuko's Harada data for Emmanuel
% Jonas Almeida
disp(date)
%% The data
% We are in a hurry so we start with David's Crossman's report,
% specifically with the "normalized" 12 columns, stored in
% "normalilized.txt"

dt = haradaRead
haradaPlot(dt)

%% Exploratory analysis
% a first look at what structure can we find in the data

%lets start by normalizing the data by quantilization
dtQ=dt;
dtQ.x=membCol(dtQ.x);dtQ.vs=membCol(dtQ.vs);
% and having a first look at the quantiles
haradaPlot(dtQ);

%% Comparing HER LUM and TN
% Since we have three effects one can't resist a 3D plot :-D

close all;
%plot3(dtQ.vs(:,1),dtQ.vs(:,2),dtQ.vs(:,3),'.');
haradaPlot(dtQ,'vs3d');
%% Housecleaning
% It's a good time to develope some basic house cleanign functions.
% Let's start with the representation of a transcriptomic unit, tr (gene):

help showGene

%for example
showGene(dt,4)

% ...


%% Quantile shift
% So we are ready to have a look at the quantile shift between the three
% efects

%     HER LUM TN 
% HER  I  [1] [2] [[4]]
% LUM  .   I  [3] [[5]]
%  TN  .   .   I  [[6]]
%      ..  ..  ..
%
% I  - identify comparison (all equal to 1)
% [x] - comparison of one vactor agains the other
% [[x]] - comparison of one factor agains the other two
% . - redundant comparison

help vsShift

% note default p 

%% [1] [HER] vs [LUM]
s{1}=vsShift(dtQ,1,2);

%% [2] [HER] vs [TN]
s{2}=vsShift(dtQ,1,3);

%% [3] [LUM] vs [TN]
s{3}=vsShift(dtQ,2,3);

%% [[4]] [HER] vs [LUM + TN]
s{4}=vsShift(dtQ,1);

%% [[5]] [LUM] vs [HER + TN]
s{5}=vsShift(dtQ,2);

%% [[6]] [TN] vs [HER + LUM]
s{6}=vsShift(dtQ,3);

%% All together now

% attempt to have it all in a single figure
close all;haradaPlot(dtQ,'vsALL',s);
% also as a video:
% <https://www.youtube.com/embed/VX12k1N96to?hq=1 YouTube>

%% Cluster Analysis
dtQ.s=s;
haradaPlot(dtQ,'selected clustergram',50);
