function dt=haradaRead2

% dt=haradaRead gets all the data needed for this analysis in a single
% variable

if exist('harada.mat')==2
    load('harada.mat') % caching it here
else
    dt.xLabel={'SH-CON_(HuGene-1_0-st-v1).CEL(normalized)','SH-11_(HuGene-1_0-st-v1).CEL(normalized)','SH-12_(HuGene-1_0-st-v1).CEL(normalized)','HER_(HuGene-1_0-st-v1).CEL(normalized)','SH-9_(HuGene-1_0-st-v1).CEL(normalized)','SH10_(HuGene-1_0-st-v1).CEL(normalized)','LUM_(HuGene-1_0-st-v1).CEL(normalized)','SH-5_(HuGene-1_0-st-v1).CEL(normalized)','SH-6_(HuGene-1_0-st-v1).CEL(normalized)','TN_(HuGene-1_0-st-v1).CEL(normalized)','SH-7_(HuGene-1_0-st-v1).CEL(normalized)','SH-8_(HuGene-1_0-st-v1).CEL(normalized)'};
    dt.x=xlsread('normalized.xlsx');
    dt.vsLabel={'HER vs Controls','ER+/PR+ vs Controls','TN vs Controls','HER vs ER+/PR+','HER vs TN'};
    dt.vs=xlsread('onevstheother.xlsx');
    [a,b,c] = xlsread('transcripts.xlsx');
    warning off % Warning: Variable names were modified to make them valid MATLAB identifiers. 
    dt.tr = cell2dataset(c); % note use of dataset object to handle annotation of trasncripts
    warning on
end