restoredefaultpath,clear, clc, close all;

addpath('Funciones')

%% Cargamos los datos de interes
rutaFichero = '../01_SeleccionDescriptores/DatosGenerados/';

nombreFichero = 'datos_MD_C_E.mat';
load([rutaFichero nombreFichero]);

clear rutaFichero nombreFichero;

%% Preparamos la información leida

XoIRed = XoI(:,espacioCcas);
YoIRed = YoI;

% Clasificación MDE

[~,~,d12MDE,coeficientes_d12MDE] = funcion_calcula_funciones_decision_MDE_clasificacion_binaria(XoIRed,YoIRed);

% Clasificación MDM

[~,~,d12MDM,coeficientes_d12MDM] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(XoIRed,YoIRed);

%% Representamos muestras y plano del clasificador
nombresProblemaIORed = [];
nombresProblemaIORed.descriptores = nombresProblemaIO.descriptores(espacioCcas);
nombresProblemaIORed.clases = nombresProblemaIO.clases;
nombresProblemaIORed.simbolos = nombresProblemaIO.simbolos;

%funcion_representacion_clasificacion_binaria_con_frontera(XoIRed,YoIRed,coeficientes_d12,nombresProblemaIORed);

%% Guardamos los datos
save('./DatosGenerados/C_MD_C_E','espacioCcas', 'd12MDE', 'coeficientes_d12MDE', 'd12MDM', 'coeficientes_d12MDM','XoIRed', 'YoIRed', 'nombresProblemaIORed');