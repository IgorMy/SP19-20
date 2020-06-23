restoredefaultpath, close all, clear,clc;
addpath('Funciones');
%% --------------------------------
%% 1.- GENERACIÓN VARIABLE TIPO STRUCT nombresProblema
%% --------------------------------
% Cargamos los datos para renombrarlos y que sea mas facil usarlos
load('DatosEntrenamiento/conjunto_datos_entrenamiento');


%% --------------------------------
%% 2.- GENERACIÓN VARIABLE TIPO STRUCT nombresProblema
%% --------------------------------

nombreDescriptores = { 'Compacticidad', 'Excentricidad', 'Solidez_CHull(Solidity)', 'Extension_BBox(Extent)', 'Extension_BBox(Invariante Rotacion)', 'Hu1', 'Hu2', 'Hu3', 'Hu4', 'Hu5', 'Hu6', 'Hu7', 'DF1', 'DF2', 'DF3', 'DF4', 'DF5', 'DF6', 'DF7', 'DF8', 'DF9', 'DF10', 'NumEuler'};

nombreClases{1} = 'Arandelas';
nombreClases{2} = 'Tuercas';
nombreClases{3} = 'Alcayatas Lisas';
nombreClases{4} = 'Alcayatas Roscadas';
nombreClases{5} = 'Tornillos Cabeza Hexagonal';
nombreClases{6} = 'Tornillos Roscados';

simbolosClases{1} = '*r';
simbolosClases{2} = '*g';
simbolosClases{3} = '*b';
simbolosClases{4} = '*c';
simbolosClases{5} = '*y';
simbolosClases{6} = '*k';

nombresProblema = [];
nombresProblema.descriptores = nombreDescriptores;
nombresProblema.clases = nombreClases;
nombresProblema.simbolos = simbolosClases;

%% Representación del problema
funcion_representacion_clasificacion_binaria_con_frontera(X,Y,nombresProblema)

%% --------------------------------
%% 3.- GUARDAR CONJUNTO DE DATOS Y NOMBRES DEL PROBLEMA
% (EN DIRECTORIO DATOSGENERADOS)
%% --------------------------------

save('./DatosGenerados/conjunto_datos','X','Y');
save('DatosGenerados/nombresProblema','nombresProblema');

