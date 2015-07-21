function h=haradaPlot2(dt,opt,more)

% haradaPlot2(dt,opt) plots different views of harada's data as retrieved by harada.m
%
% Jonas Almeida Aug 15, 2013

if nargin<2
    opt='xvs';
end

switch opt
    case 'x'
        h=imagesc(dt.x);
        colorbar;
        %axis off
        [n,m]=size(dt.x);
        hold on
        for i=1:m
            j=strfind(dt.xLabel{i},'_');
            L=dt.xLabel{i}(1:j(1)-1);
            text(i,0,[' ',L],'rotation',45)
        end
        hold off
        %set(gca,'XTick',[1:length(dt.xLabel)]);
        %set(gca,'XTickLabel',dt.xLabel);
        
    case 'vs'
        h=imagesc(dt.vs);
        colorbar;
        %axis off
        [n,m]=size(dt.vs);
        hold on
        for i=1:m
            L=regexp(dt.vsLabel{i},'\((.+)\)','tokens');
            LL{i}=L{1}{1};
            text(i,0,['   ',LL{i}],'rotation',20)
        end
        hold off
        %set(gca,'XTick',[1:length(LL)],'XAxisLocation','top','XTickLabel',LL);
        
    case 'xvs'
        h=figure();
        subplot(1,2,1)
        haradaPlot2(dt,'x');
        subplot(1,2,2)
        haradaPlot2(dt,'vs');
        
    case 'vs3d'
        
        h=plot3(dt.vs(:,1),dt.vs(:,2),dt.vs(:,3),'+');
        xlabel(dt.vsLabel{1});
        ylabel(dt.vsLabel{2});
        zlabel(dt.vsLabel{3});
        grid on
        
    case 'vs3d+' % enhanced 3D plot
        
        h=plot3(dt.vs(:,1),dt.vs(:,2),dt.vs(:,3),'o');
        xlabel(dt.vsLabel{1});
        ylabel(dt.vsLabel{2});
        zlabel(dt.vsLabel{3});
        grid on
        
    case 'vsHER' % enhanced 3D plot
        
        h=plot3(dt.vs(:,1),dt.vs(:,2),dt.vs(:,3),'ok');
        xlabel(dt.vsLabel{1});
        ylabel(dt.vsLabel{2});
        zlabel(dt.vsLabel{3});
        grid on
        s = more;
        hold on
        n = size(s{1},1);
        for i=1:n
            j=s{1}(i);
            plot3(dt.vs(j,1),dt.vs(j,2),dt.vs(j,3),'.')
            text(dt.vs(j,1),dt.vs(j,2),dt.vs(j,3),[' ',dt.tr.genesymbol(j)],'Color','b','Rotation',-30);
        end
        hold off
        
  case 'vsALL' % enhanced 3D plot
        
        h=plot3(dt.vs(:,1),dt.vs(:,2),dt.vs(:,3),'ok');
        xlabel(dt.vsLabel{1});
        ylabel(dt.vsLabel{2});
        zlabel(dt.vsLabel{3});
        grid on
        s = more;
        hold on
        n = size(s{1},1);
        for i=1:n
            j=s{1}(i);
            plot3(dt.vs(j,1),dt.vs(j,2),dt.vs(j,3),'.')
            text(dt.vs(j,1),dt.vs(j,2),dt.vs(j,3),[' ',dt.tr.genesymbol(j)],'Color','b','Rotation',-30);
            j=s{2}(i);
            plot3(dt.vs(j,1),dt.vs(j,2),dt.vs(j,3),'.r')
            text(dt.vs(j,1),dt.vs(j,2),dt.vs(j,3),[' ',dt.tr.genesymbol(j)],'Color','r','Rotation',0);
            j=s{3}(i);
            plot3(dt.vs(j,1),dt.vs(j,2),dt.vs(j,3),'.g')
            text(dt.vs(j,1),dt.vs(j,2),dt.vs(j,3),[' ',dt.tr.genesymbol(j)],'Color','g','Rotation',30);
        end
        hold off
        
    case 'Emmanuel-1' % tailored subtraction of quantiles requested by Emmanuel
        
        
        n = size(dt.x,1);
        L={'HER2','ER+/PR+','TN'};
        figure;
        for i=1:3
            subplot(1,3,i);
            jj=[1,2,3];
            jj(i)=[];
            x=dt.x(:,1:3);
            x(:,i)=[];
            Li=L;
            Li(i)=[];
            h=imagesc(x-repmat(dt.x(:,i),1,2));
            set(gca,'XTick',[1,2]);
            set(gca,'XTick',[]);
            k=0;
            for j=jj
                k=k+1;
                text(k,-30,L{j},'HorizontalAlignment','center','rotation',0);
            end
            text(1.5,-90,['(Subtracting ',L{i},')'],'HorizontalAlign','center');
            %colorbar;
                
        end
        
        
    case 'Emmanuel-2' % tailored subtraction of quantiles requested by Emmanuel
        
        n = size(dt.x,1);
        L={'HER2','LUM A','TN'};
        for i=1:3
            jj=[1,2,3];
            jj(i)=[];
            x=dt.x(:,1:3);
            x(:,i)=[];
            Li=L;
            Li(i)=[];
            figure;
            h=imagesc(x-repmat(dt.x(:,i),1,2));
            set(gca,'XTick',[1,2]);
            set(gca,'XTick',[]);
            k=0;
            for j=jj
                k=k+1;
                text(k,-30,L{j},'HorizontalAlignment','center','rotation',0);
                title(['(Subtracting ',L{i},')']);
            end
            colorbar;
                
        end
        
    case 'cluster test' % testing cluster analysis with Emmanuel
        subplot(2,1,1)
        tree = linkage(dt.x','UPGMA','euclidean');
        dendrogram(tree);
        subplot(2,1,2);
        imagesc(dt.x);
        4
    
    case 'clustergram' % testing clustergram 
        
        clustergram(dt.x,'ColumnLabels',dt.xLabel)
        
    case 'selected clustergram'
        s=[dt.s{4}(:,2),dt.s{5}(:,2),dt.s{6}(:,2)];
        I=[dt.s{4}(:,1),dt.s{5}(:,1),dt.s{6}(:,1)]'; %the indexes of the selected positions
        if nargin<3;more=30;end
        k = more; % top k values per discriminability, change k for different subset
        %S=abs(s);
        %ii = I(Ind(1:k)); % indexes of top k transcripts
        ii = I(1:k); % indexes of top k transcripts
        dt.newLabels.xLabel={};
        for i=1:length(dt.xLabel)
            dt.newLabels.xLabel{i}=regexprep(dt.xLabel{i},'_.+','');
        end
        %clustergram(dt.x(ii,:),'ColumnLabels',dt.newLabels.xLabel,'RowLabels',dealWithNaN(dt.tr.genesymbol(ii)))
        cm = redgreencmap;
        clustergram(dt.vs(ii,:).*2-1,'ColumnLabels',dt.vsLabel,'RowLabels',dealWithNaN(dt.tr.genesymbol(ii)),'Colormap',(cm(end:-1:1,:)).^10)
        

        
end

