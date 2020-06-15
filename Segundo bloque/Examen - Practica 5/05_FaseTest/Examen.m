restoredefaultpath,clear, clc, close all;

%% Establecemos el nombre y la ruta de la imagen de test
addpath('Funciones');

rutaFichero = '../Imagenes/';
nombreFichero1 = 'Test01.bmp';
nombreFichero2 = 'Test02.bmp';

%% Clasificamos

Funcion_Reconoce_Formas([rutaFichero nombreFichero1]);
Funcion_Reconoce_Formas([rutaFichero nombreFichero2]);

