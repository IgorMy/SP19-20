%% Introducón al problema de segmentación - Histograma bimodal
%% Clases Objeto-Fondo bien separadas

clear, clc, close all
addpath('Imagenes')
addpath('Funciones')

I = imread('Matric.tif');

figure, imshow(uint8(I))

%% Objetivo_ Seleccionar de forma automática umbrales de separación entre clases

%% Primera opción básica: Utilizar estadísticos simples: Ejemplo - valor Medio

I = double(I);
T = mean(I(:));
Ib = I < T;
figure,
subplot(2,1,1),imshow(uint8(I))
subplot(2,1,2),funcion_visualiza(uint8(I),Ib,[255 0 0])

%% Pequeño parentesis - terminamos de segmentar los caracteres
% Asumimos que conocemos el numero de caracteres, nos quedamos con los mas
% grandes

numCaracteres = 7;

[Ietiq, Nobj] = bwlabel(Ib); % matriz etiquetada
stats = regionprops(Ietiq,'Area');
areas = cat(1,stats.Area);
areas_ord = sort(areas,'descend');
numPix = areas_ord(numCaracteres); % numero de pixeles de la menor agrupacion mayor
IbFiltrada = bwareaopen(Ib,numPix);
figure,
subplot(3,1,1),imshow(uint8(I))
subplot(3,1,2),funcion_visualiza(uint8(I),Ib,[255 0 0])
subplot(3,1,3),funcion_visualiza(uint8(I),IbFiltrada,[0 255 0])


%% Mostrar cada objeto en un color distinto
close all;
figure,
subplot(4,1,1),imshow(uint8(I))
subplot(4,1,2),funcion_visualiza(uint8(I),Ib,[255 0 0])
subplot(4,1,3),funcion_visualiza(uint8(I),IbFiltrada,[0 255 0])

Ietiq = bwlabel(IbFiltrada);
R = uint8(I); G = R; B = R;
colores = uint8((255*rand(numCaracteres,3)));
for i=1:numCaracteres
    IbFiltrada_i = Ietiq == i;
    R(IbFiltrada_i) = colores(i,1);
    G(IbFiltrada_i) = colores(i,2);
    B(IbFiltrada_i) = colores(i,3);
end

subplot(4,1,4), imshow(cat(3,R,G,B));


%% Retomamos Histograma bimodal, con clases objeto-fondo bien separadas

% Umbrales basados en estadísticos simples: ejemplo - valor medio
clear, clc, close all
addpath('Imagenes')
addpath('Funciones')
I = imread('Matric.tif');
I = double(I);
I = double(I);
T = mean(I(:));
Ib = I < T;
subplot(3,1,1),imshow(uint8(I))
subplot(3,1,2),imhist(uint8(I))
subplot(3,1,3),funcion_visualiza(uint8(I),Ib,[255 0 0])
title(['Umbral definido como valor medio: ' num2str(T)])

% Clases separadas pero desbalanceadas:
% Mejor: Metodo minimo entre maximos

[g_MinEntreMax, gma1, gmax2] = funcion_MinEntreMax(I,'NO') % Hace falta programarla
Ib = I<g_MinEntreMax;
figure,
subplot(2,1,1), imshow(uint8(I))
subplot(2,1,2),funcion_visualiza(uint8(I),Ib,[255 0 0])
figure,imhist(uint8(I))
title(['Umbral: i' num2str(g_MinEntreMax)])

