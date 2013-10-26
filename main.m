clc
clear all
tic
disp('Proyecto Final - Video digital y Procesamiento de Imágenes')

I = imread('images/DHV-377.jpg');

% img=img(100:400,100:650,:);
% I=im2double(I);
F=I;
% F=im2double(F);
r=F(:,:,1);
g=F(:,:,2);
b=F(:,:,3);


% imshow(S)




IE  = ecualizacion_histograma(g,8);

ventanaD(IE)

toc