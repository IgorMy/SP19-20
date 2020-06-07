clear,clc,close all
%% Carga de datos

addpath('Funciones')
addpath('../../../../01_GeneracionDatos/DatosGenerados')
load('conjunto_datos_estandarizados.mat')
load('nombresProblema.mat')

% otra forma de cargar los datos
rutaFichero = '../../../../01_GeneracionDatos/DatosGenerados/';
nombreFichero = 'conjunto_datos_estandarizados.mat';
load([rutaFichero nombreFichero]);
nombreFichero = 'nombresProblema.mat';
load([rutaFichero nombreFichero]);

clear nombreFichero rutaFichero;

%% Seleccionamos las clases que deseamos

X = Z;
codifClases = unique(Y);

clasesOI = [1 3];
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
numDescriptoresOI = 9;
[espacioCcas, JespacioCcas]=funcion_selecciona_vector_ccas_3_dim(XoI,YoI,numDescriptoresOI);


%% Guardamos los datos

nombresProblemaIO = [];
nombresProblemaIO.descriptores = nombresProblema.descriptores;
nombresProblemaIO.clases = nombresProblema.clases(clasesOI);
nombresProblemaIO.simbolos = nombresProblema.simbolos;
save('DatosGenerados/espacio_ccas_MD_Circulos_Triangulo','espacioCcas','nombresProblemaIO','XoI','YoI');
