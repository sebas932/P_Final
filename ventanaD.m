function [y,x]= ventanaD(I,alto,ancho,landax,landay)
imgi =I; 
tcm = alto;
tcn = ancho;
conta=0;
[m,n]= size(imgi);
x=ones(1,alto*ancho);
i=1;
while i<m
    j=1;
    while j<=n
        conta= conta+1;
        y = imgi(i:tcm,j:tcn,:);
%         y=imadjust(y);
%         y=edge(y,'sobel');
          y=im2bw(y,0.3);
           
%         SE=strel('square',1);
%         y=imdilate(y,SE);
%         SE=strel('square',1);
%         y=imerode(y,SE);
%           interfaz(I,y)
        imshow(y)
%         imwrite(y,strcat('n',num2str(conta),'.jpg'));
%         title(['Imagen Recortada_ ' num2str(conta)])
        pause(0.15)
        
        if conta == 1
            x(1,:)=reshape(y,1,[]);
        else
            A= reshape(y,1,[]);
            x = [x;A];
        end
        if tcn+landay<=n
            tcn= tcn+landay;
        else
            j=n;
            tcn=ancho;
        end
        j=j+landay;
    end
    if tcm+landax<=m
        tcm= tcm+landax;
    else
        i=m;
        tcm=alto;
    end
    i=i+landax;
end
