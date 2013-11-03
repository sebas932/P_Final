function I2 =realce(I,rmin,rmax)
disp('Ejecutando funcion de realce')
I2=I;
[m,n] = size(I);
for i = 1:m
    for j = 1:n
        if (I2(i,j) > rmin && I2(i,j) < rmax)
            I2(i,j) = 255;
        else
        I2(i,j) = 0;
        end
    end
end