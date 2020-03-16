function [ matriz_etiquetada N ] = funcion_etiquetar(Imagen_binaria)

N = 0;
matriz_etiquetada = zeros(size(Imagen_binaria,1),size(Imagen_binaria,2)); % Establecemos a 0 el fondo

for i=1:size(Imagen_binaria,1)
    for j=1:size(Imagen_binaria,2)
        if(Imagen_binaria(i,j) == 1)
            N = N + 1;
            [Imagen_binaria,matriz_etiquetada] = vecinos(Imagen_binaria,matriz_etiquetada,i,j,N);
        end
    end
end

end