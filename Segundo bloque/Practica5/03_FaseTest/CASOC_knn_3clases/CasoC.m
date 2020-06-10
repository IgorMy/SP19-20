clear, clc, close all;
restoredefaultpath
%% Establecemos el nombre y la ruta de la imagen de test
addpath('Funciones')

rutaFichero = '../../Imagenes/Test/';
nombreFichero1 = 'Test1.JPG';
nombreFichero2 = 'Test2.JPG';

%% Clasificamos

Funcion_Reconoce_Formas([rutaFichero nombreFichero1],"Euclidea");
Funcion_Reconoce_Formas([rutaFichero nombreFichero2],"Euclidea");
Funcion_Reconoce_Formas([rutaFichero nombreFichero1],"Mahalanobis");
Funcion_Reconoce_Formas([rutaFichero nombreFichero2],"Mahalanobis");