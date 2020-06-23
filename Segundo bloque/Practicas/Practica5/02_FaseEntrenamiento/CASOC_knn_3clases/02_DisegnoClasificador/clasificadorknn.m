clear, close all, clc;
%% Cargamos los datos del problema
rutaFichero = '../01_SeleccionDescriptores/DatosGenerados/';

nombreFichero = 'espacio_ccas_knn.mat';
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

save('./DatosGenerados/knn','espacioCcas', 'XoIRed', 'YoIRed', 'nombresProblemaIORed');