clear,close all, clc
addpath('Datos')
addpath('Funciones')

%% Mínima distancia euclidea 2 dimensiones
load Datos_MDM_3dimensiones.mat

valoresClases = unique(Y);
numClases = length(valoresClases);
[numDatos, numAtributos] = size(X);

%% Representación de los datos
funcion_representa_muestras_clasificacion_binaria(X,Y)

hold on

%% Diseño del clasificador MDM

[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X,Y);

% si al evaluar las instancias con d12 obtenemos >0 es de la clase 1 y si
% es < 0 es de la clase 2

%% Representacion ed la frontera de separacion entre las dos clases: linea recta d12 = 0
x1min = min(X(:,1));x1max = max(X(:,1));
x2min = min(X(:,2));x2max = max(X(:,2));
x3min = min(X(:,3));x3max = max(X(:,3));
axis([x1min x1max x2min x2max x3min x3max]);

A = coeficientes_d12(1); B = coeficientes_d12(2); C= coeficientes_d12(3);D = coeficientes_d12(4);

Xmin = min(X(:));
Xmax = max(X(:));
paso = (Xmax-Xmin)/100;
[x1Plano, x2Plano] = meshgrid(Xmin:paso:Xmax);
x3Plano = -(A*x1Plano + B*x2Plano + D) / (C+eps);
surf(x1Plano,x2Plano,x3Plano);

%% Aplicacion del clasificador: opcion cuadratica - tantas funciones de decision como clases

Y_clasificador1 = zeros(size(Y));
%A = coeficientes_d12(1); B = coeficientes_d12(2); C= coeficientes_d12(3);

for i=1:numDatos
    
    XoI = X(i,:);
    x1 = XoI(1);
    x2 = XoI(2);
    x3 = XoI(3);
    
    valor_d1 = eval(d1);
    valor_d2 = eval(d2);
    
    % d12_manual = A*x1 + B*x2 + C*x3 + D
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

