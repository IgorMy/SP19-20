function [Imagenbinaria,Imagendouble] = vecinosv2(Imagenbinaria,Imagendouble,fila,columna,numero)
    if(Imagenbinaria(fila,columna) == 1)
        Imagenbinaria(fila,columna) = 0;
        Imagendouble(fila,columna) = numero;
        if(fila > 1)
            [Imagenbinaria,Imagendouble] = vecinos(Imagenbinaria,Imagendouble,fila-1,columna,numero);
        end
        if(fila < size(Imagenbinaria,1))
            [Imagenbinaria,Imagendouble] = vecinos(Imagenbinaria,Imagendouble,fila+1,columna,numero);
        end
        if(columna > 1)    
            [Imagenbinaria,Imagendouble] = vecinos(Imagenbinaria,Imagendouble,fila,columna-1,numero);
        end
        if(columna < size(Imagenbinaria,2))    
            [Imagenbinaria,Imagendouble] =vecinos(Imagenbinaria,Imagendouble,fila,columna+1,numero);
        end
        if(fila > 1)
            if(columna > 1)    
                [Imagenbinaria,Imagendouble] = vecinos(Imagenbinaria,Imagendouble,fila-1,columna-1,numero);
            end
            if(columna < size(Imagenbinaria,2))    
                [Imagenbinaria,Imagendouble] =vecinos(Imagenbinaria,Imagendouble,fila-1,columna+1,numero);
            end
        end
        if(fila < size(Imagenbinaria,1))
            if(columna > 1)    
                [Imagenbinaria,Imagendouble] = vecinos(Imagenbinaria,Imagendouble,fila+1,columna-1,numero);
            end
            if(columna < size(Imagenbinaria,2))    
                [Imagenbinaria,Imagendouble] =vecinos(Imagenbinaria,Imagendouble,fila+1,columna+1,numero);
            end
        end
    end
end