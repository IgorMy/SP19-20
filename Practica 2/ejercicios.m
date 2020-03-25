%% Cargamos los directorios
addpath("Funciones");
addpath("Imagenes");

%% Practica

% 1 

imagen_binaria = imread("ImagenBinaria.tif");
unique(imagen_binaria) % nos mostrara que solo tiene dos valores (0 para el negro y 255 para el blanco), tambien se puede ver com imhist

% 2

imagenv2 = double(imagen_binaria==255);

% 3

[imagenv3,numero] = funcion_etiquetar(imagenv2);

% primera forma de hacerlo
imagenv4 = funcion_visualiza(imagenv3, imagenv3 == 1, [255 0 0]) + funcion_visualiza(imagenv3, imagenv3 == 2, [0 255 0]) + funcion_visualiza(imagenv3, imagenv3 == 3, [0 0 255])+ funcion_visualiza(imagenv3, imagenv3 == 4, [255 255 0]) + funcion_visualiza(imagenv3, imagenv3 == 5, [0 255 255]) + funcion_visualiza(imagenv3, imagenv3 == 6, [255 0 255]);
imshow(imagenv4);

%segunda forma de hacerlo
colores = uint8(255*rand(numero,3));
R = uint8(zeros(size(imagenv3,1),size(imagenv3,2)));
G = R;
B = R;

for i=1:numero
    Ib = imagenv3==i;
    R(Ib) = colores(i,1);
    G(Ib) = colores(i,2);
    B(Ib) = colores(i,3);
end
RGB = cat(3,R,G,B);
imshow( RGB );

% 4

Centroides = Calcula_Centroides(imagenv3);
Areas = Calcular_Area(imagenv3);
[~,Indice] = sort(Areas);

imagenv5 = cat(3,imagenv2,imagenv2,imagenv2);

figure,imshow(imagenv5),hold on, plot(Centroides(:,1),Centroides(:,2),"*b");
plot(Centroides(Indice(1),1),Centroides(Indice(1),2), "*r");
plot(Centroides(Indice(numero),1),Centroides(Indice(numero),2), "*r");

% 5

imagenv6 = Filtra_Objetos(imagenv2,5000);
imshow(imagenv6);

% Extra

% 3

[imagenv3 numero] = bwlabel(imagenv2);
imagenv4 = funcion_visualiza(imagenv3, imagenv3 == 1, [255 0 0]) + funcion_visualiza(imagenv3, imagenv3 == 2, [0 255 0]) + funcion_visualiza(imagenv3, imagenv3 == 3, [0 0 255])+ funcion_visualiza(imagenv3, imagenv3 == 4, [255 255 0]) + funcion_visualiza(imagenv3, imagenv3 == 5, [0 255 255]) + funcion_visualiza(imagenv3, imagenv3 == 6, [255 0 255]);
imshow(imagenv4);

% 4

stats=regionprops(imagenv3,'Area','Centroid');
areas=cat(1,stats.Area);
centroides=cat(1,stats.Centroid);
[~,Indice] = sort(areas);
imagenv5 = cat(3,imagenv2,imagenv2,imagenv2);

figure,imshow(imagenv5),hold on, plot(centroides(:,1),centroides(:,2),"*b");
plot(centroides(Indice(1),1),centroides(Indice(1),2), "*r");
plot(centroides(Indice(numero),1),centroides(Indice(numero),2), "*r");

% 5

MatrizBinaria_ObjetosGrandes=bwareaopen(imagenv2,5000);
imshow(MatrizBinaria_ObjetosGrandes);
