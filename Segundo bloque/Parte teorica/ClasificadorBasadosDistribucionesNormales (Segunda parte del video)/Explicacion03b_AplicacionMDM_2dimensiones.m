clear,close all, clc
addpath('Datos')
addpath('Funciones')

%% Mínima distancia euclidea 2 dimensiones
load Datos_MDM_2dimensiones.mat

valoresClases = unique(Y);
numClases = length(valoresClases);
[numDatos, numAtributos] = size(X);

%% Representación de los datos
funcion_representa_muestras_clasificacion_binaria(X,Y)

hold on

% Calculo de las matrices de covarianzas de cada clase
% Objetivo medir correlacion entre los datos y analizar las suposiciones
% Que se tiene que cumplir para aplicar el calsificador MDM

% Aprovechamos para calcular el vector de medias de cada clase

M = zeros(numClases,numAtributos);
mCov = zeros(numAtributos,numAtributos,numClases);

for i=1:numClases
    FoI = Y == valoresClases(i);
    XClase = X(FoI,:);
    M(i,:) = mean(XClase);
    mCov(:,:,i)= cov(XClase,1);
end

hold on, plot(M(:,1),M(:,2),'ko-');

mCov % No tienen que ser exactamente iguales

% Variantes de los atributos aproximadamente iguales

% Variables no correladas, covarianza de las variables aproximadamente 0
mCov_clase1 = mCov(:,:,1);
coef_corr = funcion_calula_coeficiente_correlacion_lineal_2_variables(mCov_clase1)

mCov_clase2 = mCov(:,:,2);
coef_corr = funcion_calula_coeficiente_correlacion_lineal_2_variables(mCov_clase2)

% probabilidad a priori de las clases
numDatosClase1 = sum(Y==valoresClases(1));
numDatosClase2 = sum(Y==valoresClases(2));
% se observa que son iguales las probabilidades
numDatos

% Se cumplen todas las condicines de aplicación para la aplicación de MDE

%% Diseño del clasificador MDM

[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X,Y);

% si al evaluar las instancias con d12 obtenemos >0 es de la clase 1 y si
% es < 0 es de la clase 2

%% Representacion ed la frontera de separacion entre las dos clases: linea recta d12 = 0
x1min = min(X(:,1));x1max = max(X(:,1));
x2min = min(X(:,2));x2max = max(X(:,2));
axis([x1min x1max x2min x2max]);

A = coeficientes_d12(1); B = coeficientes_d12(2); C= coeficientes_d12(3);
x1Recta = x1min:0.01:x1max;
x2Recta = -(A*x1Recta+C)/(B+eps); % A*x1+B*x2+C = 0;

hold on
plot(x1Recta,x2Recta,'k');

%% Aplicacion del clasificador: opcion cuadratica - tantas funciones de decision como clases

Y_clasificador1 = zeros(size(Y));
%A = coeficientes_d12(1); B = coeficientes_d12(2); C= coeficientes_d12(3);

for i=1:numDatos
    
    XoI = X(i,:);
    x1 = XoI(1);
    x2 = XoI(2);
    
    valor_d1 = eval(d1);
    valor_d2 = eval(d2);
    
    % d12_manual = A*x1 + B*x2 + C
    % eval(d12);
    % d12_manual > 0
    % clase 1
    % sino
    % clase 2
    
    if valor_d1 > valor_d2
        Y_clasificador1(i) = valoresClases(1);
    else
        Y_clasificador1(i) = valoresClases(2);
    end
    
end

funcion_representa_muestras_clasificacion_binaria(X,Y_clasificador1)

%% Evaluacion de la precision

Y_modelo = Y_clasificador1;

error = Y_modelo - Y;

num_aciertos = sum(error==0);

Acc = num_aciertos/numDatos

