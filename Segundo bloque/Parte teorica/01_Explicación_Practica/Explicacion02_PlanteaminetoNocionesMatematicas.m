clear,clc,close all;
addpath('Datos')

datos = [1,3;1,5;3,3;3,7;2,2]; 
% Se pueden modelar mediante una función normal gausiana
% Estamos en el caso bidimensional
% En una sola dimension no necesitariamos la matriz de covarianzas

% Vamos a representarlos
[numDatos, numCcas] = size(datos);
x1 = datos(:,1);
x2 = datos(:,2);
nombreCcas{1} = 'Caracteristica columna 1 - x1';
nombreCcas{2} = 'Caracteristica columna 2 - x2';

% Representacion
    DatosEjeX = x1;
    DatosEjeY = x2;
    plot(DatosEjeX,DatosEjeY,'*r');
    axis([0 6 0 10]);
    legend('Datos de objetos de un Clase')
    xlabel(nombreCcas{1}),ylabel(nombreCcas{2});
    grid on
    
% Punto medio
M = mean(datos); % La media de cada columna 
%(En la teoria es un vector columna y aqui es un vector fila)
hold on, plot(M(1),M(2),'xb') % representamos el punto medio

% Varianza caracteristicas 1 y 2
% 1º metodo
% A cada elemenento se le resta su media , se eleva al cuadrado , se suma y
% se divide por el numero de elementos totales
V1 = ( (1-2)^2 + (1-2)^2 + (3-2)^2 + (3-2)^2 + (2-2)^2 )/5;
V2 = ( (3-4)^2 + (5-4)^2 + (3-4)^2 + (7-4)^2 + (2-4)^2 )/5;
% 2º metodo (mas facil)
V1 = var(datos(:,1),1);
V2 = var(datos(:,2),1);

% La covarianza es una matriz de n*m elementos, en la que la diagonal es la
% varianza del elemento al cuadrado y el resto de los elementos es la
% varianza combinada del elemento de fila * elemento de la columna
% [ V1 V12 ]
% [ V12 V2 ]
% Para calcular V12:
V12 = ( (1-2)*(3-4) + (1-2)*(5-4) + (3-2)*(3-4) + (3-2)*(7-4) + (2-2)*(2-4) )/5;

% Esto es un coñazo hacerlo de forma normal y luego componer la tabla, por
% lo que usaremos una funciñon de matlab
MCovarianza = cov(datos,1);

%%%% Significado de la matriz de covarianzas
clear, clc, close all
%load DasoBasicos1.mat % Cargar desde 1 hasta el 4 

datos = [];

for i=0:999
    datos = [datos;2+i*0.002,0.2+i*0.002];
end
%(No tenemos el archivo asik pasando), hare una aproximación

% Vamos a representarlos
[numDatos, numCcas] = size(datos);
x1 = datos(:,1);
x2 = datos(:,2);
nombreCcas{1} = 'Caracteristica columna 1 - x1';
nombreCcas{2} = 'Caracteristica columna 2 - x2';

% Representacion
    DatosEjeX = x1;
    DatosEjeY = x2;
    plot(DatosEjeX,DatosEjeY,'*r');
    legend('Datos de objetos de un Clase')
    xlabel(nombreCcas{1}),ylabel(nombreCcas{2});
    grid on

% Se obserca una clara dependencia lineas (es una linea de puntos de 2 a 4
% en diagonal) de orden casi 1  
% Coeficiente de correlacion mide la dependecnai lineal (puede ser desde -1 hasta 1)

% Calculamos la matriz de covarianzas
MCovarianza = cov(datos,1)

% El termino cruzado es una estimación de la correlacion lineal entre las
% variables - podemos hacer un cambio de escala para que corresponda con la
% correlación lineal de pearson cov(xy) / sigmax * sigmay

corr_x1_x2 = MCovarianza(1,2) / (sqrt(MCovarianza(1,1))*sqrt(MCovarianza(2,2)))
% Observamos que es 1 (hay una correlacion lineal perfecta)

% Funcion de matlab que lo facilita (Medida de dependecncia lineal)
corr(x1,x2)

% Variables aleatorias
clear, clc, close all
%load DatosBasicos2.mat % no los tengo

datos = rand(1000,2);

% Vamos a representarlos
[numDatos, numCcas] = size(datos);
x1 = datos(:,1);
x2 = datos(:,2);
nombreCcas{1} = 'Caracteristica columna 1 - x1';
nombreCcas{2} = 'Caracteristica columna 2 - x2';

% Representacion
    DatosEjeX = x1;
    DatosEjeY = x2;
    plot(DatosEjeX,DatosEjeY,'*r');
    legend('Datos de objetos de un Clase')
    xlabel(nombreCcas{1}),ylabel(nombreCcas{2});
    grid on
 
% Viendo la muestra, se observa que no hay una dependencia lineal entre
% esos dos atributos
MCovarianza = cov(datos,1)
corr(x1,x2) % Se observa que no presenta una correlación lineal

%% Calculo de distancia euclide entre le punto medio y un punto cualquiera

clear,close all
addpath('Datos')

datos = [1,3;1,5;3,3;3,7;2,2]; 
% Se pueden modelar mediante una función normal gausiana
% Estamos en el caso bidimensional
% En una sola dimension no necesitariamos la matriz de covarianzas

% Vamos a representarlos
[numDatos, numCcas] = size(datos);
x1 = datos(:,1);
x2 = datos(:,2);
nombreCcas{1} = 'Caracteristica columna 1 - x1';
nombreCcas{2} = 'Caracteristica columna 2 - x2';

% Representacion
    DatosEjeX = x1;
    DatosEjeY = x2;
    plot(DatosEjeX,DatosEjeY,'*r');
    axis([0 6 0 10]);
    legend('Datos de objetos de un Clase')
    xlabel(nombreCcas{1}),ylabel(nombreCcas{2});
    grid on
    
% Punto medio
M_vector_fila = mean(datos); % La media de cada columna 
%(En la teoria es un vector columna y aqui es un vector fila)
hold on, plot(M_vector_fila(1),M_vector_fila(2),'xb') % representamos el punto medio

% Suponemos un punto cualquiera
x1 = 3; x2 = 5; X = [x1 ; x2];
M = M_vector_fila';
d_2 = ( (X-M)'*(X-M) ) % Distancia al cuadrado

% Planteamiento teórico Distancia del Centro a cualquier punto dado por x1
% y x2

    x1 = sym('x1','real');
    x2 = sym('x2','real');
    
    X = [x1;x2];
    d_2 = expand( (X-M)' * (X-M));
    x1 = 3;x2 = 5, eval(d_2)
    
% Calculo de distancia euclidea entre el punto medio y un punto cualquiera
% en una recta

clear, clc,close all;

datos = [1,1;2,2.5;3,3.5;4,5;5,6]; 

% Vamos a representarlos
[numDatos, numCcas] = size(datos);
x1 = datos(:,1);
x2 = datos(:,2);
nombreCcas{1} = 'Caracteristica columna 1 - x1';
nombreCcas{2} = 'Caracteristica columna 2 - x2';

% Representacion
    DatosEjeX = x1;
    DatosEjeY = x2;
    plot(DatosEjeX,DatosEjeY,'*r');
    axis([0 6 0 10]);
    legend('Datos de objetos de un Clase')
    xlabel(nombreCcas{1}),ylabel(nombreCcas{2});
    grid on
    
% Punto medio
M_vector_fila = mean(datos); % La media de cada columna 
%(En la teoria es un vector columna y aqui es un vector fila)
hold on, plot(M_vector_fila(1),M_vector_fila(2),'xb') % representamos el punto medio
 
% Distancia Euclidea punto dado por [x1,x2] al punto M
M = M_vector_fila';

    x1 = sym('x1','real');
    x2 = sym('x2','real');
    
    X = [x1;x2];
    dE_2 = expand( (X-M)' * (X-M));
    x1 = 3;x2 = 5; eval(dE_2) % Esta mucho mas cerca por distancia euclidea
    x1 = 6;x2 = 7; eval(dE_2) % Esta mucho mas lejos por distancia euclidea

% Distancia Mahalanobis
    MCovarianza = cov(datos,1);
    x1 = sym('x1','real');
    x2 = sym('x2','real');
    
    X = [x1;x2];
    dM_2 = expand( (X-M)' * pinv(MCovarianza) * (X-M)); % Es cuadratica tambien
    x1 = 3;x2 = 5; eval(dM_2) % Esta mucho mas lejos segun Mahalanobis
    x1 = 6;x2 = 7; eval(dM_2) % Esta mucho mas cerca
    

