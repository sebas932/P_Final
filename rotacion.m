function p_rot = rotacion(p)

[m,n] = size(p);
mitad = round(n/2);

punto1 = 255;
punto2 = 255;

coord1 = [];
coord2 = [];
cont = 0;
intensidad = 0;

while cont < m
    if (intensidad ~= punto1)
        for i1 = 1:m
            for j1 = 1:n
                intensidad = p(i1,j1);
                if (intensidad == punto1)
                    coord1 = [i1,j1];
                end
            end
        end
    else
        for i2 = 1:m
            for j2 = 1:n
                intensidad = p(i1,j1);
                if (intensidad == punto1)
                    coord1 = [i1,j1];
                end
            end
        end
    end
    cont = cont + 1;
end