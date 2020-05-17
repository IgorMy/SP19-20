function T_otsu = funcion_otsu(I)

h = imhist(uint8(I));

gIni = 1; gFin = 256;
[gmedio, numPix] = calcular_valor_medio_region_histograma(h,gIni,gFin);

var = zeros(256,1);

for g=2:255
    T = g;
    var(g) = calcula_varianza_entre_clases(T,h,numPix,gmedio);
end

[~, indice] = max(var);

T_otsu = indice - 1;

end