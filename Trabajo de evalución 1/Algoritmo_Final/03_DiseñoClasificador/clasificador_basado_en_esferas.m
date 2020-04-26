clear,close all;

%% RUTAS A DIRECTORIOS CON INFORMACIÓN
addpath('../02_Extraer_Representar_Datos/VariablesGeneradas');
addpath('Funciones');

%% Lectura y representación de datos

load conjunto_De_datos.mat;

representa_datos_color_seguimiento_fondo(X,Y);

%% Agrupamiento de datos y representación -clase de interes

% Datos de esa clase de interes
valoresY = unique(Y);
FoI = Y == valoresY(2); % Filas de la clase de interes - color de seguimiento
Xcolor = X(FoI,:);

numAgrup = 2;
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
addpath('../01_GeneracionMaterial/');
addpath('Funciones');
addpath('VariablesGeneradas');
load ImagenesEntrenamiento_Calibracion.mat;
load datos_multiples_esferas.mat;
funcion_imagenes_calibracion_multiples_esferas(imagenes,datosMultiplesEsferas);
