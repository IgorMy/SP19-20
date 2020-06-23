clear,clc;

%% Rutas a directorios y carga de información
addpath('../01_GeneracionMaterial/');
addpath('../02_Extraer_Representar_Datos/VariablesGeneradas');
addpath('../03_DiseñoClasificador/VariablesGeneradas');

addpath('Funciones');
addpath('VariablesGeneradas');

load ImagenesEntrenamiento_Calibracion.mat;
load datos_multiples_esferas.mat;

%% Visualización de la información cargada

% 1.- Imágenes de calibración

[N, M, numComp, numImag] = size(imagenes);
% Vemos las imagenes
for i=1:numImag
    imshow(imagenes(:,:,:,i)),title(num2str(i));
    pause
end
close all;

% 2.- Visualizacion de esferas en el espacio de caracteristicas junto con
% los datos de entrenamiento
load conjunto_de_datos.mat
representa_multiples_esferas_espacio_ccas(datosMultiplesEsferas,X,Y);

%% Calibracion de paramentros: Radio esferas y umbral de conectividad

% --------------------
% Calibración de Radio de las esferas
% --------------------

% 1.- Visualización deteccion de las esferas en cada imagen

% En cada ventana, 4 representaciones, la original, y el resultado de la
% detección con cada uno de los tres criterios de radio de esferas
% considerado.

close all;
funcion_imagenes_calibracion_multiples_esferas(imagenes,datosMultiplesEsferas);
close all;

% Se puede coger cualquiera de los 3 radios

% 2.- Eleccion de radio en base al analisis de las imágenes anteriores

% Posibles radio y criterios
% 1: radio sin perdida de color
% 2: radio minimo sin ruido
% 3: radio de compromiso

% Para este caso se ha elegido el radio de compromiso
radio = 3;
datosMultiplesEsferas_clasificador = datosMultiplesEsferas(:,[1:3 3+radio]);

% Notar que esta variable datosMultiplesEsferas_clasificador tiene la misma
% estructura que la que se le ha pasado por parámetro a la funcion
% calcula_deteccion_multiples_esferas_en_imagen


% -------------------
% Calibración de parámetro de conectividad: numPix
% -------------------

% De la imagen binaria resultante de la detección por distancia se eliminan
% todas las agrupaciones conectadas de menos de numPix pixeles.

% Este parámetro numPix se ajusta sobre la imagen donde el objeto se
% encuentra en la posición mas alejada (es cuando es mas pequeño)

% 1.- Utilizando roipoly, marcamos la superficie del objeto.
% 2.- Calculamos el área o número de pixeles del objeto en esta posicion
% NOtar que este es el valor máximo que puede tener este parámetro si no se
% quiere perder al objeto en esta posición
% 3.- Seleccionar numPix como un porcentaje de esta área del objeto en si
% posición más alejada

% Cálculo del área del objeto en su posición mas alejada

I_objeto_pos_mas_alejada = imagenes(:,:,:,size(imagenes,4));
Ib = roipoly(I_objeto_pos_mas_alejada);
numPixReferencia = sum(Ib(:));

numPixAnalisis = round([0.25 0.5 0.75]*numPixReferencia); % Posivles valores

% Al igual que antes, visualizamos cuantro gráficas por cada imagen
% 1.- Imagen de calibraciñon con la deteccion por distancia sin eliminar
% nada 2, 3 y 4; se eliminan las componentes concetadas con los tres
% valores de prueba del cevto numPixAnalisis

close all;
funcion_imagenes_calibracion_numPix(imagenes,datosMultiplesEsferas_clasificador,numPixAnalisis);

close all;

% Eleccion de numPix en base al análisis de las imágenes anteriores
numPix = numPixAnalisis(3);

%% Guardamos parametros para la aplicación del clasificador

save('VariablesGeneradas/parametros_clasificador','datosMultiplesEsferas_clasificador','numPix');
