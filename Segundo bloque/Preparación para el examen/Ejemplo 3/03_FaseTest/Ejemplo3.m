restoredefaultpath,clear, clc, close all;

%% Establecemos el nombre y la ruta de la imagen de test
addpath('Funciones');

rutaFichero = '../Imagenes/Test/';

%% Clasificamos

nombres{1} = 'A3';
nombres{2} = 'B3';
nombres{3} = 'C3';
nombres{4} = 'D3';
nombres{5} = 'E3';

numClases = 5;
numImagenesPorClase = 1;
for i=1:numClases
    for j=1:numImagenesPorClase
        nombreImagen = [rutaFichero nombres{i} '.tif'];
        Funcion_Reconoce_Formas(nombreImagen);
    end
end

