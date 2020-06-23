function [gMean, numPix] = calcula_valor_medio_region_histograma(h,gIni,gFin)

% Comprobar los valores inicial y final
gIni = round(gIni);
if gIni<1
    gIni = 1;
end

gFin = round(gFin);
if gFin > 256
    gFin = 256;
end

% Suma los niveles de grises
gMean = 0;
for g = gIni:gFin
    gMean = gMean + g*h(g);
end

% Se suman la cantidad de pizeles de las dos zonas
numPix = sum(h(gIni:gFin));

% Y se devuelve los niveles de grises entre el numero de pizeles o vacio
if numPix > 0
    gMean = gMean/numPix;
else
    gMean = [];
end

end