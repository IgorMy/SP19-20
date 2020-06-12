clear, close all, clc, restoredefaultpath;
%% Cargamos los datos del problema

addpath('Funciones')

rutaFichero = '../01_SeleccionDescriptores/DatosGenerados/';

nombreFichero = 'MDE_CC_T.mat';
load([rutaFichero nombreFichero]);

clear rutaFichero nombreFichero;

%% Reducimos los datos a los necesarios para el clasificador

YoIRed = YoI;
XoIRed = XoI(:,espacioCcas);

[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDE_clasificacion_binaria(XoIRed,YoIRed);

%% Generamos el resto de los datos

nombresProblemaIORed = [];
nombresProblemaIORed.descriptores = nombresProblemaIO.descriptores(espacioCcas);
nombresProblemaIORed.clases = nombresProblemaIO.clases;
nombresProblemaIORed.simbolos = nombresProblemaIO.simbolos;

%% Guardamos los datos

save('./DatosGenerados/C_MDE_CC_T','espacioCcas', 'd12', 'coeficientes_d12', 'XoIRed', 'YoIRed', 'nombresProblemaIORed');