% 1 

imagen_binaria = imread("ImagenBinaria.tif");
unique(imagen_binaria) % nos mostrara que solo tiene dos valores (0 para el negro y 255 para el blanco), tambien se puede ver com imhist

% 2

imagenv2 = double(imagen_binaria==255);

% 3

[imagenv3 numero] = funcion_etiquetar(imagenv2);
imagenv4 = funcion_visualiza(imagenv3, imagenv3 == 1, [255 0 0]) + funcion_visualiza(imagenv3, imagenv3 == 2, [0 255 0]) + funcion_visualiza(imagenv3, imagenv3 == 3, [0 0 255])+ funcion_visualiza(imagenv3, imagenv3 == 4, [255 255 0]) + funcion_visualiza(imagenv3, imagenv3 == 5, [0 255 255]) + funcion_visualiza(imagenv3, imagenv3 == 6, [255 0 255]);
imshow(imagenv4);