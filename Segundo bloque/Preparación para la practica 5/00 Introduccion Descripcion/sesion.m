%% Reconocimiento basado en calculo compacticidad de cada objeto

%% Regla de decisión por teoría

% Rergla de decisión
% Si per.2 / área < 14.3 entonces objeto = circulo.
% Si 14.4 < per.2 / área < 18.4 entonces objeto = cuadrado
% Si 18.4 < per.2 / área entones obtejo = triángulo

%% Implementación

I = imread('Test1.JPG');

Ib = I < 255*graythresh(I);

[Ietiq,N] = bwlabel(Ib);
stats = regionprops(I,'Area','Perimeter'); 
areas = cat(1,stats.Area);
perimetros = cat(1,stats.Perimeter);
c = (perimetros.^2)./areas;
close all;
for i=1:N
    figure,
    funcion_visualiza(I,Ietiq==i,[255 255 0])
    if c(i) < 14.3
        title(['Circulo - c = ' num2str(c(i))])
    elseif c(i) > 18.4
        title(['Triangulo - c = ' num2str(c(i))])
    else
        title(['Cuadrado - c = ' num2str(c(i))])
    end     
end

%% Esto no se hace asi
%% El clasificador se diseña en base a los valores de los descriptores
%% En ejemplos conocidos similares - No de conocimiento teórico
% A partir de aqui me faltan las imagenes (En este caso necesito tres imagenes, con muchos circulos/triangulos/cuadrados)
addpath('FotosEntrenam');
nombre{1} = 'Circulo01.JPG';
nombre{2} = 'Cuadrado01.JPG';
nombre{3} = 'Triangulo01.JPG';
I = imread(nombre{1});

Ib = I < 255*graythresh(I);

[Ietiq,N] = bwlabel(Ib);

stats = regionprops(Ietiq,'Area','Perimeter');
areas = cat(1,stats.Area);
perimetros = cat(1,stats.Perimeter);
c = (perimetros.^2)./areas;

valorMedio = mean(c); % Obtendriamos el valor medio de la compacidad de uno de los objetos

%% Calculo de compacidad-Excentricidad de todos los objetos
addpath('FotosEntrenam');
nombre{1} = 'Circulo01.JPG';
nombre{2} = 'Cuadrado01.JPG';
nombre{3} = 'Triangulo01.JPG';
numClases = 3; % Solo tenemos una imagen por clase - No va a ser lo normal

X = [];
Y = [];

for i=1:numClases
    I = imread(nombre{i});
    Ib = I < 255*graythresh(I);

    [Ietiq,N] = bwlabel(Ib);

    stats = regionprops(Ietiq,'Area','Perimeter','Eccentricity');
    areas = cat(1,stats.Area);
    perimetros = cat(1,stats.Perimeter);
    comp = (perimetros.^2)./areas;
    ecc = cat(1,stats.Eccentricity);

    datos = [comp ecc];
    X = [X; datos];
    Y = [Y; i*ones(N,1)];

end

% X columna 1 = compacidad, columna 2 = eccentricidad , filas objetos de
% las mustras

% Y columna 1 1-3 para identificar el tipo de objeto

%% Representación datos en espacio de ccas: compactidad-excentricidad

% Partimos de X-Y

% Respecto las clases:
simbolos = {'*r','*b','*k'};
nombreClases{1} = 'Circulos';
nombreClases{2} = 'Cuadrados';
nombreClases{3} = 'Triangulos';
codifClases = unique(Y);
numClases = length(codifClases);

% Respecto los descriptores
espacioCcas = [1 2];
nombreDescriptores{espacioCcas(1)} = 'compacticidad';
nombreDescriptores{espacioCcas(2)} = 'excentricidad';

figure, hold on
for i=1:numClases
    datosClase = X(Y==codifClases(i),espacioCcas);
    plot(datosClase(:,1), datosClase(:,2),simbolos{i})
end

legend(nombreClases)
xlabel(nombreDescriptores{espacioCcas(1)})
ylabel(nombreDescriptores{espacioCcas(2)})

