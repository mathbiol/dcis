function str = showGene(dt,i,opt)

% str = showGene(dt,i,opt) extracts a string to describe gene #i in dt.tr
% This function is teh right place to prettify it. The different options
% are flagged by the 3rd input argument, opt
%
% Jonas Almeida Sept 2013

if nargin<3;opt='pretty';end

gene = dt.tr(i,:);

% check if opt is a field of gene

j = find(strcmp(opt,fieldnames(gene)));
if ~isempty(j) % its is: use it!
    str=gene.(opt){1};
else %look for somethign more specialized
    % switch structure for prettier str goes here:
    switch opt
        case 'pretty'
            str=[gene.genesymbol{1},': ',gene.genedescription{1}];
    end
end





