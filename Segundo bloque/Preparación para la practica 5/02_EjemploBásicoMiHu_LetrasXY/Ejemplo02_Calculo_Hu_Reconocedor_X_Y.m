% Diseñar soguiente funcion: funcion_reconocedor_X_Y_porHu1
% Entrada: nombre o ruta de la Imagen
% Salida: ABRIR TANTAS IMÁGENES COMO OBJETOS, DONDE SE RESALTEN LOS PIXELES
% DEL OBJETO EN UN COLOR Y SE HAGA CONSTAR SU RECONOCIMIENTO EN EL TÍTULO

% UTILIZAR COMO CLASIFICADOR UNA REGLA DE DECISIÓN BASADA EN EL PRIMER hu

%% PARA VER EL PRIMER MOMENTO DE HU Y ESTABLECER LA REGLA E DECISIÓN

clear, clc, close all

addpath('DatosGenerados')
addpath('Funciones')

load conjunto_datos.mat
load nombresProblema.mat % strings para la representación (1X7 descriptores, 1x2 clases, 1x2 simbolos)

% Variables del problema
[numMuestras, numDescriptores] = size(X);
codifClases = unique(Y);
numClases = length(codifClases);

funcion_representa_datos(X,Y,[1 2],nombresProblema);

% CONCLUSION: Si Hu1 es > 1.1: letra X, caso contrario, letra Y

%% función Ejemplo_Calculo_Hu_Reconocedor_X_Y(Imagen)

% Programación de funcion reconoce objetos: Paosos generales

% 0. Cargar/Generar Información especifica relativa a nuestro problema de
% calsificador
% En este ejemplo especifico: cargar el dato discriminante de Hu1

% 1.- Binarizar (Metodo de selección automática umbral - OTSU)

% 2.- Eliminar posibles componentes conectadas ruidosas:
% Componente ruidosa:
% Componente de menos del 0.1% del número total de pixeles de la Imagen o
% número de píxeles menor al area del objeto mayor /5 se debe cumplir
% cualquiera de als dos condiciones

% 3.- Etiquetar

% 4.- Llamar a una funcion que calcule todos los descriptores considerados
% es decir, funcón que genera matriz X de datos (No tenemos Y!!! ---> Es lo
% que tenemos que generar con nuestro clasificador)
% En el ejemplo especifico:
% XTest = funcion_calcula_Hu_objetos_imagen(Ietiq, N);

% 5.- Recorrer cada objeto y aplicar la regla de decisión para generar la
% salida solicitada


