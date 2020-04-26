clear,close all;

%% RUTAS A DIRECTORIOS CON INFORMACIÓN
addpath('../02/VariablesGeneradas');
addpath('funciones');

%% Lectura y representación de datos

load conjunto_De_datos.mat;

representa_datos_color_seguimiento_fondo(X,Y);

%% Agrupamiento de datos y representación -clase de interes

% Datos de esa clase de interes
valoresY = unique(Y);
FoI = Y == valoresY(2); % Filas de la clase de interes - color de seguimiento
Xcolor = X(FoI,:);

numAgrup = 3;
idx = funcion_kmeans(Xcolor,numAgrup);

% Representar agrupaciones
close all;
representa_datos_color_seguimiento_fondo(X,Y);
figure
representa_datos_fondo(X,Y), hold on
representa_datos_color_seguimiento_por_agrupaciones(Xcolor,idx);

%% Calculo de las esferas de cada agrupación

% datosEsferaAgrupación = ...
% calcula_datos_esferas_agrupacion(Xcolor_agrupacion, X, Y);

% 1.- Calcula centroide de los puntos del color de seguimiento de la
% agrupación: Rc,Gc,Bc.
% 2.- Calcula vector distancias entre el centroide anterior y cada uno de
% los puntos de Xcolor_agrupacion.
% 3.- Calcula vector distancias entre el centroide anterior y cada uno de
% los puntos de las muestras de fondo que hay en X.
% 4.- Calcular r1 y r2 a partir de los vectores distancia anteriores.
% 5.- Calcular el radio de compromiso r12
% 6-. Devolver datosEsferaAgrupacion = [Rc,Gc,Bc, r1, r2, r12] {vector fila}

datosMultiplesEsferas = zeros(numAgrup,6);
% Variable que contiene los datos de todas las esferas de todas las
% agrupaciones
% Filas: tantas como agrupaciones
% Columnas: 3 valores para el centroide, 3 para radios
for i=1:numAgrup
    Xcolor_agrupacion = idx == i;
    datosMultiplesEsferas(i,:) = calcula_datos_esfera_agrupacion(Xcolor_agrupacion,X,Y);
end

%% Representar esferas en espacio de caracteristicas

close all;
valoresCentros = datosMultiplesEsferas(:,1:3);
valoresRadios = datosMultiplesEsferas(:,4:6);
significadoRadios{1} = 'Radio sin perdidas';
significadoRadios{2} = 'Radio sin ruido';
significadoRadios{3} = 'Radio compromiso';

for i = 1:size(valoresRadios,2)
    figure(i),set(i,'Name',significadoRadios{i});
    representa_datos_fondo(X,Y),hold on;
    representa_datos_color_seguimiento_por_agrupaciones(Xcolor,idx);
    for j=1:numAgrup
        representa_esfera(valoresCentros(j,:),valoresRadios(j,i));
    end
end

save('./VariablesGeneradas/datos_multiples_esferas','datosMultiplesEsferas');

%% Ejercicio propuesto

% Aplica esta técnica de clasificación en las imágenes de calibración

% por cada imagen de calibracion se debe generar una ventana tipo figure
% con cuatro gráficas (subplot de dos filas y dos columnas de gráficas)
% iguales que el ejercicio propuesto anterior

clear,clc;
addpath('../01/');
addpath('funciones');
addpath('VariablesGeneradas');
load ImagenesEntrenamiento_Calibracion.mat;
load datos_multiples_esferas.mat;
funcion_imagenes_calibracion_multiples_esferas(imagenes,datosMultiplesEsferas);

%% Final del ajuste de clasificación (Ultimo video)
clear,clc;

%% Rutas a directorios y carga de información
addpath('../01/');
addpath('../02/VariablesGeneradas');
addpath('funciones');
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

% La 13 es la ultima imagen de calibración con el objeto en el fondo (No es la ultima de array)

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

% Para este caso se ha elegido el radio sin perdida
radio = 1;
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

I_objeto_pos_mas_alejada = imagenes(:,:,:,13);
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
