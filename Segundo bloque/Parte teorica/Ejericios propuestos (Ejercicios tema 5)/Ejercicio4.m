clear,close all, clc
addpath('Datos')
addpath('Funciones')
clear
load 'datos_biomarcadores_exp1';
X1 = datos;
Y1 = clases;
load 'datos_biomarcadores_exp2';
X2 = datos;
Y2 = clases;

%% a)
funcion_representa_muestras_clasificacion_binaria(X1,Y1)
funcion_representa_muestras_clasificacion_binaria(X2,Y2)

%% b) Vamos a definir el clasificador sobre las muestras del primer experimento

% Comprobamos que modelo de decisión usar (como solo hemos aprendido dos 
% clasificadores, suponemos que las muestras son equiprobables y las 
% matrices de covarianzas son parecidas o iguales)
disp('Numero de correlacion del primer experimento');
coeficientes1 = funcion_calcular_coeficiente_correlacion_XY(X1,Y1);

disp('Numero de correlacion del segundo experimento');
coeficientes2 = funcion_calcular_coeficiente_correlacion_XY(X2,Y2);

% Observamos que en el primer experimento es mejor usar MDE y en el segundo
% MDM

% comprobemos MDE con las dos muestras

[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDE_clasificacion_binaria(X1,Y1);
precision11 =  funcion_evalua_precision_clasificador(X1,Y1,d1,d2,d12);

[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDE_clasificacion_binaria(X2,Y2);
precision21 =  funcion_evalua_precision_clasificador(X2,Y2,d1,d2,d12);

% Se observa que usando MDE se obtienen uunos valores bastante buenos para
% los dos experimentos

% Comprobemos MDM

[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X1,Y1);
precision12 =  funcion_evalua_precision_clasificador(X1,Y1,d1,d2,d12);

[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X2,Y2);
precision22 =  funcion_evalua_precision_clasificador(X2,Y2,d1,d2,d12);

% Se observa que con MDM obtenemos un mejor resultado, y es el que usaremos

%% Representacion
[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X1,Y1);
funcion_representacion_clasificacion_binaria_con_frontera(X1,Y1,coeficientes_d12)

[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X2,Y2);
funcion_representacion_clasificacion_binaria_con_frontera(X2,Y2,coeficientes_d12)

%% c) Echo en el apartado anterior
[d1,d2,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X2,Y2);
funcion_representacion_clasificacion_binaria_con_frontera(X2,Y2,coeficientes_d12)


