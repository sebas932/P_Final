function [out,data] = clasificador(IMG)
%Letter
A=imread('train/caracteres/A.jpg');B=imread('train/caracteres/B.jpg');
C=imread('train/caracteres/C.jpg');D=imread('train/caracteres/D.jpg');
E=imread('train/caracteres/E.jpg');F=imread('train/caracteres/F.jpg');
G=imread('train/caracteres/G.jpg');H=imread('train/caracteres/H.jpg');
I=imread('train/caracteres/I.jpg');J=imread('train/caracteres/J.jpg');
K=imread('train/caracteres/K.jpg');L=imread('train/caracteres/L.jpg');
M=imread('train/caracteres/M.jpg');N=imread('train/caracteres/N.jpg');
O=imread('train/caracteres/O.jpg');P=imread('train/caracteres/P.jpg');
Q=imread('train/caracteres/Q.jpg');R=imread('train/caracteres/R.jpg');
S=imread('train/caracteres/S.jpg');T=imread('train/caracteres/T.jpg');
U=imread('train/caracteres/U.jpg');V=imread('train/caracteres/V.jpg');
W=imread('train/caracteres/W.jpg');X=imread('train/caracteres/X.jpg');
Y=imread('train/caracteres/Y.jpg');Z=imread('train/caracteres/Z.jpg');

%Number
one=imread('train/caracteres/1.jpg');  two=imread('train/caracteres/2.jpg');
three=imread('train/caracteres/3.jpg');four=imread('train/caracteres/4.jpg');
five=imread('train/caracteres/5.jpg'); six=imread('train/caracteres/6.jpg');
seven=imread('train/caracteres/7.jpg');eight=imread('train/caracteres/8.jpg');
nine=imread('train/caracteres/9.jpg'); zero=imread('train/caracteres/0.jpg');


disp('Corriendo Clasificador')
data=[];
imgi =IMG;
tcm = 100;
tcn = 42;
landay=1;
landax=100;
conta=0;
[m,n]= size(imgi);
i=1;
mayor = -1;
patron =rgb2gray(T);

while i<m
    j=1;
    while j<=n
        conta= conta+1;
        y = imgi(i:tcm,j:tcn,:);  
        if(corr2(patron,y)>mayor)
            mayor = corr2(patron(:,:,1),y);
            out=y;
            
        end 
%         imshow(y)
%         pause(0.1)
        data=[data corr2(patron(:,:,1),y)];
        if tcn+landay<=n
            tcn= tcn+landay;
        else
            j=n;
            tcn=42;
        end
        j=j+landay;
    end
    if tcm+landax<=m
        tcm= tcm+landax;
    else
        i=m;
        tcm=100;
    end
    i=i+landax;
end
% plot(data)
imshow(out)