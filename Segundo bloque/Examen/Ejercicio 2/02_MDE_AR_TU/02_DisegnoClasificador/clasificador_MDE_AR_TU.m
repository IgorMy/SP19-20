restoredefaultpath,clear, close all, clc ;
%% Cargamos los datos del problema

addpath('Funciones')

rutaFichero = '../01_SeleccionDescriptores/DatosGenerados/';

nombreFichero = 'datos_MDE_AR_TU';
load([rutaFichero nombreFichero]);

clear rutaFichero nombreFichero;

%% Reducimos los datos a los necesarios para el clasificador

YoIRed = YoI;
XoIRed = XoI(:,espacioCcas);

%% Generamos el resto de los datos

nombresProblemaIORed = [];
nombresProblemaIORed.descriptores = nombresProblemaIO.descriptores(espacioCcas);
nombresProblemaIORed.clases = nombresProblemaIO.clases;
nombresProblemaIORed.simbolos = nombresProblemaIO.simbolos;

[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDE_clasificacion_binaria(XoIRed,YoIRed);
funcion_representacion_clasificacion_binaria_con_frontera(XoIRed,YoIRed,nombresProblemaIORed,espacioCcas,coeficientes_d12);

%% Guardamos los datos

save('./DatosGenerados/C_MDE_AR_TU','espacioCcas','d1','d2','d12','coeficientes_d12', 'XoIRed', 'YoIRed', 'nombresProblemaIORed');