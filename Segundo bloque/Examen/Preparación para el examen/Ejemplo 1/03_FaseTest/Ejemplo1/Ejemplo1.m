clear, clc, close all;
restoredefaultpath
%% Establecemos el nombre y la ruta de la imagen de test
addpath('Funciones');

rutaFichero = '../../Imagenes/Test/';
nombreFichero1 = 'Test1.JPG';
nombreFichero2 = 'Test2.JPG';

%% Clasificamos

Funcion_Reconoce_Formas([rutaFichero nombreFichero1]);
Funcion_Reconoce_Formas([rutaFichero nombreFichero2]);

% Se observa que el clasificador discrimina bien en la primera fase 
% (CirculoCuadrado_Triangulo) pero falla en la segunda fase. Esto es
% debido a los descriptores escogidos. Podemos observar que algunas de 
% las muestras de diferentes clases estan muy proximas y no se puede
% diferenciar entre ellos.