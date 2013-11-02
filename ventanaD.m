function [p]= ventanaD(I,alto,ancho,landax,landay,patron)
tic
disp('Corriendo Ventana deslizante')
imgi =I;
tcm = alto;
tcn = ancho;
conta=0;
[m,n]= size(imgi);
i=1;
mayor = 0;
while i<m
    j=1;
    while j<=n
        conta= conta+1;
        y = imgi(i:tcm,j:tcn,:);  
        if(corr2(patron(:,:,1),y)>mayor)
            mayor = corr2(patron(:,:,1),y); 
            p=y;
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
toc
