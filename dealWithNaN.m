function y=dealWithNaN(x)

% replaceing numeric "NaN" with string "NaN" in a cell array of strings

n=length(x);
for i=1:n
    if isnumeric(x{i})
        x{i}='NaN';
    end
end
y=x;

