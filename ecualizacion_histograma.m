function I2 = ecualizacion_histograma(I,b)
I2=I;
L= (2^b);
h = zeros(L,1);   % Histograma
he = zeros(L,1);  % Histograma Ecualizado
[m,n] = size(I);

% Sacamos el histograma de la imagen original
for i=1:m
    for j=1:n 
        h(I2(i,j)+1) = h(I2(i,j)+1)  +1;
    end
end
% Dividimos sobre el numero de pixeles que hay en la imagen
pr = h./(sum(h))
% Ecualizamos el Histograma
for i=1:L 
    s=sum(pr(1:i));
    he(i)= round((L-1)*s); 
end
% Reemplazamos en la imagen de salida con el histograma ecualizado 
% usandola tecnica de look up table
for i=1:m
   for j=1:n
    I2(i,j)=he(I(i,j)+1);    
   end
end
