function p_rot = rotacion(p)

[m,n] = size(p);
mitad = round(n/2);

punto1 = 255;

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
        if(coord1(1,2) < mitad)
            for i2 = coord(1,1):m
                for j2 = 1:coord(1,2)
                    if (p(i2,j2) == 255)
                        coordtemp = [i2,j2];
                    end
                    if (p(i2,j2) == 255 && j2 < coordtemp(1,2))
                        coord2 = [i2,j2];
                    end
                end
            end
        else
            for i2 = coord(1,1):m
                for j2 = coord(1,2):n
                    if (p(i2,j2) == 255)
                        coordtemp = [i2,j2];
                    end
                    if (p(i2,j2) == 255 && j2 > coordtemp(1,2))
                        coord2 = [i2,j2];
                    end
                end
            end
        end
        
    end
    cont = cont + 1;
end

c = sqrt((coord1(1,1).^2)+(coord2(1,2).^2));
%deltay = abs(coord1(1,2)-coord2(1,2));
deltax = abs(coord1(1,1)-coord2(1,1));

beta = (deltax*sin(90))/c;

p_rot = imrotate(p,beta);