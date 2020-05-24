clear,close all, clc
addpath('Datos')
addpath('Funciones')

load 'datos_MDE_2dimensiones';
% load 'datos_MDM_2dimensiones';
% load 'datos_MDM_3dimensiones';

%% 1.-

numDatos = size(X,1); 
porcentajeTrain = 0.7; 
numDatosTrain = round(porcentajeTrain*numDatos); 
numerosMuestrasTrain = randsample(numDatos,numDatosTrain); 
numerosMuestrasTest = find(not(ismember(1:numDatos,numerosMuestrasTrain)));   
% Conjunto de Train 
XTrain = X(numerosMuestrasTrain,:); 
YTrain = Y(numerosMuestrasTrain); 
% Conjunto de Test 
XTest = X(numerosMuestrasTest,:); 
YTest = Y(numerosMuestrasTest);

%% 2.-

figure, subplot(2,1,1), funcion_representa_muestras_clasificacion_binaria_2(XTrain,YTrain),title('Train')
subplot(2,1,2), funcion_representa_muestras_clasificacion_binaria_2(XTest,YTest),title('Test')

%% 3.- 

% Primer archivo
[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDE_clasificacion_binaria(X,Y);

% Segundo y tercer archivo
[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X,Y);

%% 4.- 

% Para el primer y segundo fichero
figure, subplot(2,1,1), funcion_representa_muestras_clasificacion_binaria_2(XTrain,YTrain),title('Train')
hold on
x1min = min(XTrain(:,1));x1max = max(XTrain(:,1));
x2min = min(XTrain(:,2));x2max = max(XTrain(:,2));
axis([x1min x1max x2min x2max]);

A = coeficientes_d12(1); B = coeficientes_d12(2); C= coeficientes_d12(3);
x1Recta = x1min:0.01:x1max;
x2Recta = -(A*x1Recta+C)/(B+eps); % A*x1+B*x2+C = 0;
plot(x1Recta,x2Recta,'k');
hold off

subplot(2,1,2), funcion_representa_muestras_clasificacion_binaria_2(XTest,YTest),title('Test')
hold on
x1min = min(XTest(:,1));x1max = max(XTest(:,1));
x2min = min(XTest(:,2));x2max = max(XTest(:,2));
axis([x1min x1max x2min x2max]);

A = coeficientes_d12(1); B = coeficientes_d12(2); C= coeficientes_d12(3);
x1Recta = x1min:0.01:x1max;
x2Recta = -(A*x1Recta+C)/(B+eps); % A*x1+B*x2+C = 0;
plot(x1Recta,x2Recta,'k');
hold off

% Para el tercer fichero
figure, subplot(2,1,1), funcion_representa_muestras_clasificacion_binaria_2(XTrain,YTrain),title('Train')
hold on

x1min = min(XTrain(:,1));x1max = max(XTrain(:,1));
x2min = min(XTrain(:,2));x2max = max(XTrain(:,2));
x3min = min(XTrain(:,3));x3max = max(XTrain(:,3));
axis([x1min x1max x2min x2max x3min x3max]);

A = coeficientes_d12(1); B = coeficientes_d12(2); C= coeficientes_d12(3);D = coeficientes_d12(4);

Xmin = min(XTrain(:));
Xmax = max(XTrain(:));
paso = (Xmax-Xmin)/100;
[x1Plano, x2Plano] = meshgrid(Xmin:paso:Xmax);
x3Plano = -(A*x1Plano + B*x2Plano + D) / (C+eps);
surf(x1Plano,x2Plano,x3Plano);

hold off

subplot(2,1,2), funcion_representa_muestras_clasificacion_binaria_2(XTest,YTest),title('Test')
hold on

x1min = min(XTest(:,1));x1max = max(XTest(:,1));
x2min = min(XTest(:,2));x2max = max(XTest(:,2));
x3min = min(XTest(:,3));x3max = max(XTest(:,3));
axis([x1min x1max x2min x2max x3min x3max]);

A = coeficientes_d12(1); B = coeficientes_d12(2); C= coeficientes_d12(3);D = coeficientes_d12(4);

Xmin = min(XTest(:));
Xmax = max(XTest(:));
paso = (Xmax-Xmin)/100;
[x1Plano, x2Plano] = meshgrid(Xmin:paso:Xmax);
x3Plano = -(A*x1Plano + B*x2Plano + D) / (C+eps);
surf(x1Plano,x2Plano,x3Plano);

hold off

%% 5.-

% Para el primer y segundo fichero

Y_clasificador1 = zeros(size(YTest));
valoresClases = unique(YTest);
[numDatos, numAtributos] = size(XTest);
for i=1:numDatos
    
    XoI = XTest(i,:);
    x1 = XoI(1);
    x2 = XoI(2);
    
    valor_d1 = eval(d1);
    valor_d2 = eval(d2);
    
    if valor_d1 > valor_d2
        Y_clasificador1(i) = valoresClases(1);
    else
        Y_clasificador1(i) = valoresClases(2);
    end
    
end

% Comprobacion

Y_modelo = Y_clasificador1;

error = Y_modelo - YTest;

num_aciertos = sum(error==0);

Acc = num_aciertos/numDatos

% Para el tercer fchero

Y_clasificador1 = zeros(size(YTest));
valoresClases = unique(YTest);
[numDatos, numAtributos] = size(XTest);
for i=1:numDatos
    
    XoI = XTest(i,:);
    x1 = XoI(1);
    x2 = XoI(2);
    x3 = XoI(3);
    
    valor_d1 = eval(d1);
    valor_d2 = eval(d2);
    
    if valor_d1 > valor_d2
        Y_clasificador1(i) = valoresClases(1);
    else
        Y_clasificador1(i) = valoresClases(2);
    end
    
end

% Comprobacion

Y_modelo = Y_clasificador1;

error = Y_modelo - YTest;

num_aciertos = sum(error==0);

Acc = num_aciertos/numDatos

