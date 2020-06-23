function T_otsu = funcion_otsu(I)

h = imhist(uint8(I));

% Se busca el nuvel de gris medio y el numero de pixeles
gIni = 1; gFin = 256;
[gmedio, numPix] = calcula_valor_medio_region_histograma(h,gIni,gFin);

%para cada nivel de gris calculo el nivel de varianza
var = zeros(256,1);

for g=2:255
    T = g;
    var(g,1) = calcula_varianza_entre_clases(T,h,numPix,gmedio);
end


[~, indice] = max(var);

T_otsu = indice - 1;

end