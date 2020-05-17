%% Metodo de otsu

clear, clc, close all;
addpath('Funciones')
addpath('Imagenes')

I = imread('Matric.tif');
imshow(I),figure,imhist(I);

g_otsu = funcion_otsu(I)
255*graythresh(I) % funcion implementada por matlab (lo devuelve en un umbral normalizado)

%% Funcion OTSU para dos umbrales

I = imread('Matric2.tif');
close all,
figure, imshow(I), figure,imhist(I)

[g1 g2] = funcion_otsu_2umb(I); 

figure,
subplot(3,1,1),imshow(uint8(I))
subplot(3,1,2),funcion_visualiza(uint8(I),I<g1,[255,0,0])
subplot(3,1,3),funcion_visualiza(uint8(I),I>g1 & I<g2,[255,0,0])
