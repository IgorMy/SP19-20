function [ matriz_etiquetada N ] = funcion_etiquetarv2(Imagen_binaria,vecindad,orden) % vecindad = false (tipo 4), vecindad = true (tipo 8)
                                                                                      % orden = false filas, orden = true (columnas)

N = 0;
matriz_etiquetada = zeros(size(Imagen_binaria,1),size(Imagen_binaria,2)); % Establecemos a 0 el fondo

if(orden == false)
    for i=1:size(Imagen_binaria,1)
        for j=1:size(Imagen_binaria,2)
            if(Imagen_binaria(i,j) == 1)
                N = N + 1;
                if(vecindad==false)
                    [Imagen_binaria,matriz_etiquetada] = vecinos(Imagen_binaria,matriz_etiquetada,i,j,N);
                else
                    [Imagen_binaria,matriz_etiquetada] = vecinosv2(Imagen_binaria,matriz_etiquetada,i,j,N);
                end
            end
        end
    end
else
    for i=1:size(Imagen_binaria,2)
        for j=1:size(Imagen_binaria,1)
            if(Imagen_binaria(j,i) == 1)
                N = N + 1;
                if(vecindad==false)
                    [Imagen_binaria,matriz_etiquetada] = vecinos(Imagen_binaria,matriz_etiquetada,j,i,N);
                else
                    [Imagen_binaria,matriz_etiquetada] = vecinosv2(Imagen_binaria,matriz_etiquetada,j,i,N);
                end
            end
        end
    end
end

end