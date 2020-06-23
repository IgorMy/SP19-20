restoredefaultpath,clear, close all, clc ;
%% Cargamos los datos del problema

addpath('Funciones')

rutaFichero = '../01_SeleccionDescriptores/DatosGenerados/';

nombreFichero = 'datos_KNN_A_D';
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

%% Guardamos los datos

save('./DatosGenerados/C_KNN_A_D','espacioCcas', 'XoIRed', 'YoIRed', 'nombresProblemaIORed');