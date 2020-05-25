clear,clc,close all;

%% Directorios
addpath('Datos')
addpath('Funciones')

%% Carga de datos
load('datosEj2')

%% 2.1
% Sobre el conjunto de muestras de entrenamiento, diseña un clasificador de
% mínima distancia de Mahalanobis, en su formulación cuadrática 
% (cada clase tiene su propia matriz de covarianzas) y lineal 
% (asumiendo una única matriz de covarianzas para cada clase del problema)

[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(XTrain,YTrain);

%% 2.2
% Representa en el espacio de características, junto con las instancias de 
% test disponibles, el plano que utiliza el clasificador MDM lineal para 
% discriminar las muestras
funcion_representacion_clasificacion_binaria_con_frontera(XTest,YTest,coeficientes_d12)

%% 2.3
% Aplica la versión cuadrática y lineal del clasificador para calcular 
% su acierto en la clasificación de las instancias de test
[precision clasificacion] =  funcion_evalua_precision_clasificador(XTest,YTest,d1,d2,d12);
% precision(1) = cuadratico
% precision(2) = lineal
% clasificacion(:,1) = clasificacion usando la funcion cuadratica
% clasificacion(:,2) = clasificacion usando la funcion lineal

%% 2.4 
% Sin hacer ningún cálculo, ¿por qué no es una buena estrategia de clasificación utilizar 
% un clasificador de mínima distancia Euclidea? Puedes justificar la respuesta representando 
% en el espacio de características las instancias de test junto con el plano que utilizaría 
% para clasificar este tipo de clasificador.

% Es mejor usar minima distancia mahalanobis porque observamos que las
% muestras siguiente una correlación lineal.
funcion_calcular_coeficiente_correlacion_XY(XTrain,YTrain)

% Pero para confirmarlo vamos a representarlo y ver la precision de esta
% funcion de clasificación.
[d11,d21,d121,coeficientes_d121] = funcion_calcula_funciones_decision_MDE_clasificacion_binaria(XTest,YTest);
funcion_representacion_clasificacion_binaria_con_frontera(XTest,YTest,coeficientes_d121)

% Observamos que divide muy mal las mustras, vamos a observar la precision
[precision1 clasificacion1] =  funcion_evalua_precision_clasificador(XTest,YTest,d11,d21,d121);
% Obtenemos una precision del 63%, bastante mala
