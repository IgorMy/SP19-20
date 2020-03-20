% 1 

imagen_binaria = imread("ImagenBinaria.tif");
unique(imagen_binaria) % nos mostrara que solo tiene dos valores (0 para el negro y 255 para el blanco), tambien se puede ver com imhist

% 2

imagenv2 = double(imagen_binaria==255);

% 3

[imagenv3 numero] = funcion_etiquetar(imagenv2);
imagenv4 = funcion_visualiza(imagenv3, imagenv3 == 1, [255 0 0]) + funcion_visualiza(imagenv3, imagenv3 == 2, [0 255 0]) + funcion_visualiza(imagenv3, imagenv3 == 3, [0 0 255])+ funcion_visualiza(imagenv3, imagenv3 == 4, [255 255 0]) + funcion_visualiza(imagenv3, imagenv3 == 5, [0 255 255]) + funcion_visualiza(imagenv3, imagenv3 == 6, [255 0 255]);
imshow(imagenv4);

%4

Centroides = Calcula_Centroides(imagenv3);
Areas = Calcular_Area(imagenv3);
[~,Indice] = sort(Areas);

imagenv5 = cat(3,imagenv2,imagenv2,imagenv2);

x = round(Centroides(Indice(1),1));
y = round(Centroides(Indice(1),2));
imagenv5(x-1:x+1,y-1:y+1,2) = 0;
imagenv5(x-1:x+1,y-1:y+1,3) = 0;

x = round(Centroides(Indice(numero),1));
y = round(Centroides(Indice(numero),2));
imagenv5(x-1:x+1,y-1:y+1,2) = 0;
imagenv5(x-1:x+1,y-1:y+1,3) = 0;


imshow(imagenv5);

% 5

imagenv6 = Filtra_Objetos(imagenv2,5000);
imshow(imagenv6);
