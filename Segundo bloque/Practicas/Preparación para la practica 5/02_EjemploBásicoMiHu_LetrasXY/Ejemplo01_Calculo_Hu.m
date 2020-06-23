clear,clc,close all;
addpath('Funciones')
addpath('Imagenes')

% Calcular los momento de hu de la primera letra X

x = imread('X.JPG');
Ib = x < 255*graythresh(x);
Ietiq = bwlabel(Ib);
Ib1 = Ietiq == 1;
hu = Funcion_Calcula_Hu(Ib1);

% Calcular en X, los momentos de hu de todas las letras x

X = [];
x = imread('X.JPG');
Ib = x < 255*graythresh(x);
[Ietiq N] = bwlabel(Ib);
for i=1:N
    Ibi = Ietiq == i;
    hu = Funcion_Calcula_Hu(Ibi);
    X = [X;hu'];
end

% Calcular en X, los momento de hu de todas las letras X y letras Y

nombreClases = [];
nombreClases{1,1} = 'X';
nombreClases{2,1} = 'Y';
extension = '.jpg';

X = [];
numClases = length(nombreClases);

for i=1:numClases
    nombreImagen = [nombreClases{i} extension];
    I = imread(nombreImagen);
    umbral = 255*graythresh(I);
    Ibin = I < umbral;
    [Ietiq, N ] = bwlabel(Ibin);
    
    for j=1:N
        Iobjeto = Ietiq == j;
        m = Funcion_Calcula_Hu(Iobjeto);
        X = [X;m'];
    end
end

% Calcular en Y, matriz de codificación de salida de los datos de X

nombreClases = [];
nombreClases{1,1} = 'X';
nombreClases{2,1} = 'Y';
extension = '.jpg';

X=[];
Y=[];
numClases = length(nombreClases);
codifClases = 1:numClases; % Se puede utilizar el bucle del siguiente for
                            % directamente, se ponde asi por si se quiere
                            % establecer de otra forma

for i=1:numClases
    nombreImagen = [nombreClases{i} extension];
    I = imread(nombreImagen);
    umbral = 255*graythresh(I);
    Ibin = I < umbral;
    [Ietiq, N ] = bwlabel(Ibin);
    
    for j=1:N
        Iobjeto = Ietiq == j;
        m = Funcion_Calcula_Hu(Iobjeto);
        X = [X;m'];
    end
    
    Y = [Y; codifClases(i)*ones(N,1)];
end

% Guardar la información de directorio datosgenerados

save('./DatosGenerados/conjunto_datos','X','Y');

% Representar en el espacio por dos-tres descriptores las muestras de
% letras X Y letras Y hacer el programacion generica
clear,clc,close all;
addpath('Funciones')
load('DatosGenerados/conjunto_datos.mat');

funcion_representa_datos(X,Y,espacioCcas, nombresProblema)

espacioCcas = [1 3];
espacioCcas = [1 5 7];

nombreDescriptores = {'Hu1', 'Hu2', 'Hu3', 'Hu4', 'Hu5', 'Hu6', 'Hu7'};
nombreClases{1} = 'Letras X';
nombreClases{2} = 'Letras Y';
simbolosClases{1} = '*r';
simbolosClases{2} = '*b';

funcion_representa_datos_sinEstructura(X,Y,espacioCcas, nombreDescriptores,nombreClases , simbolosClases)

nombresProblema = [];
nombresProblema.descriptores = nombreDescriptores;
nombresProblema.clases = nombreClases;
nombresProblema.simbolos = simbolosClases;
save('DatosGenerados/nombresProblema','nombresProblema');

funcion_representa_datos(X,Y,espacioCcas, nombreProblema);
