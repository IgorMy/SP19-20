%% Ridelr and Calvard - Isodata

clear, clc, close all;
addpath('Funciones')
addpath('Imagenes')

I = imread('Matric.tif');
Id = double(I);

h = imhist(I);

%% Programación funcion de interés y comprobación 
% funcion que calcula le valor medio del histograma entre dos niveles de
% grises

gIni = 50; gFin = 125;
gMean = calcula_valor_medio_region_histograma(h,gIni,gFin);

Ib = I >= gIni-1 & I<=gFin-1;
sum(Ib(:));
mean(I(Ib)) % Una unidad menor porque nosotros programamos de 1 ~ 256

%% programación isodata

umbralParada = 0;

varControl = true;

gIni = 1; gFin = 256;
T = calcula_valor_medio_region_histograma(h,gIni,gFin);

while varControl
    
    gIni = 1; gFin = round(T);
    gMean1 = calcula_valor_medio_region_histograma(h,gIni,gFin);
    
    gIni = round(T)+1; gFin = 256;
    gMean2 = calcula_valor_medio_region_histograma(h,gIni,gFin);
    
    newT = mean([gMean1 gMean2]); % En una determinada ejecución podria se rinfinito
    
    if abs(T-newT) <= umbralParada
        varControl = false;
    end
    
    T = newT;
end

T = T - 1; % El nivel de gris real para en 1 menos
funcion_isodata(h,umbralParada)