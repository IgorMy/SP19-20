restoredefaultpath,clear, close all, clc;

%% Añadimos los directorios
addpath('Imagenes');
addpath('Funcion');

%% Cargo la imagen

I = imread('imagenEj1.bmp');

%% Ejercicio 1

[umbral_min_entre_max, ~, ~] = funcion_MinEntreMaximos(I,[1 2 3 2 1])
umbral_otsu = funcion_otsu(I)
umbral_isodata = round(funcion_isodata(imhist(I),10))

% una vez calculado el umbral procedemos a calcular las matrices binarias

Ibin_min_entre_maximos = I > umbral_min_entre_max;
Ibin_otsu = I > umbral_otsu;
Ibin_isodata = I > umbral_isodata;

% Calculamos el numero de agrupaciones conexas
[Ietiq_min_entre_max,N_min_entre_max] = bwlabel(Ibin_min_entre_maximos);
[Ietiq_otsu,N_otsu] = bwlabel(Ibin_otsu);
[Ietiq_isodata,N_isodata] = bwlabel(Ibin_isodata);

N_min_entre_max
N_otsu
N_isodata



