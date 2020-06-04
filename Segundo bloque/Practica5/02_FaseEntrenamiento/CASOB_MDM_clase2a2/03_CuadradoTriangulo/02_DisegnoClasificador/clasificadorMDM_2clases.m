clear, clc, close all;

addpath('Funciones')

%% Cargamos los datos de interes
rutaFichero = '../01_SeleccionDescriptores/DatosGenerados/';

nombreFichero = 'espacio_ccas_cuad_trian.mat';
load([rutaFichero nombreFichero]);

clear rutaFichero nombreFichero;

%% Preparamos la información leida

XoIRed = XoI(:,espacioCcas);
YoIRed = YoI;

% Clasificación MDE

[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(XoIRed,YoIRed);

%% Representamos muestras y plano del clasificador
nombresProblemaIORed = [];
nombresProblemaIORed.descriptores = nombresProblemaIO.descriptores(espacioCcas);
nombresProblemaIORed.clases = nombresProblemaIO.clases;
nombresProblemaIORed.simbolos = nombresProblemaIO.simbolos;

funcion_representacion_clasificacion_binaria_con_frontera(XoIRed,YoIRed,coeficientes_d12,nombresProblemaIORed);

%% Guardamos los datos
save('./DatosGenerados/MDM_cuad_trian','espacioCcas', 'd12', 'coeficientes_d12', 'XoIRed', 'YoIRed', 'nombresProblemaIORed');