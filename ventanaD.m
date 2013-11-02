function [p,x]= ventanaD(I,alto,ancho,landax,landay,patron)
disp('Corriendo Ventana deslizante')
imgi =I;
tcm = alto;
tcn = ancho;
conta=0;
[m,n]= size(imgi);
x=ones(1,alto*ancho);
i=1;
mayor = 0;
while i<m
    j=1;
    while j<=n
        conta= conta+1;
        y = imgi(i:tcm,j:tcn,:); 
        y=im2bw(y,0.65);
        if(corr2(patron(:,:,1),y)>mayor)
            mayor = corr2(patron(:,:,1),y); 
            p=y;
        end 
%       pause(0.15); 
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
