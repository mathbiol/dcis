function F=genMovie(n,fname);

% genMovie(n) generates movie of rotating gcf in n steps
%
% Jonas Almeida Sept 2013

if nargin<2
    fname='lixo';
end

writerObj = VideoWriter(fname);
open(writerObj);
view(30,30);
axis vis3d
set(gca,'NextPlot','replaceChildren');
for i = 1:n 
    view(30+(i-1)*360/n,30);
    daspect([1,1,1]);
    writeVideo(writerObj,getframe(gcf));
end
close(writerObj);