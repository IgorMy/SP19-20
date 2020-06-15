restoredefaultpath,clear,clc,close all;
%% Carga de datos

addpath('Funciones')

rutaFichero = '../../01_GeneracionDatos/DatosGenerados/';
nombreFichero = 'conjunto_datos_estandarizados.mat';
load([rutaFichero nombreFichero]);
nombreFichero = 'nombresProblema.mat';
load([rutaFichero nombreFichero]);

clear nombreFichero rutaFichero;

%% Seleccionamos las clases que deseamos

X = Z;
codifClases = unique(Y);
clasesOI = [5 6];
codifClasesOI = codifClases(clasesOI);

filasOI = false(size(Y));
for i=1:length(clasesOI)
    filasOI_i = Y == codifClasesOI(i);
    filasOI = or(filasOI,filasOI_i);
end

numDescriptores = size(X,2);

XoI = X(filasOI,1:numDescriptores - 1); % quitamos el numero de euler
YoI = Y(filasOI);

%% Ejecutamos el algoritmo de seleccion de los mejores atributos
espacioCcas = [13, 15, 21];

%% Guardamos los datos

nombresProblemaIO = [];
nombresProblemaIO.descriptores = nombresProblema.descriptores;
nombresProblemaIO.clases = nombresProblema.clases(clasesOI);
nombresProblemaIO.simbolos = nombresProblema.simbolos;
save('DatosGenerados/datos_TH_TR','espacioCcas','nombresProblemaIO','XoI','YoI');

funcion_representacion_clasificacion_binaria_con_frontera(XoI,YoI,nombresProblemaIO,espacioCcas);
