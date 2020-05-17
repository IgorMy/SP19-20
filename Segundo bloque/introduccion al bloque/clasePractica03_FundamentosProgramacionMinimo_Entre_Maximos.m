%% Clases desbalanceadas: Método mínimo entre maximos

clear,clc,close all;
addpath('Funciones')
addpath('Imagenes')

I = imread('Matric.tif');
[g_MinEntreMax, gmax1, gmax2] = funcion_MinEntreMax(I,[])
Ib = I<g_MinEntreMax;
close all;
figure,
subplot(2,1,1),imshow(I)
subplot(2,1,2), funcion_visualiza(I,Ib,[255 0 0])
figure, imhist(I)
title(['Umbral: ' num2str(g_MinEntreMax)])

%% Programación función mínimo entre máximos

% Importante: Consideramos en toda la programacion niveles de gris de 1 a
% 256, despues al resultado le restamos una unidad.

% Objetivo: calcular los dos máximos correspondientes a las clases
% principales del histograma y después el valor mínimo entre ellos.

% 1.- Nivel de gris del máximo mayor:

[h, nivelesGris] = imhist(uint8(I)); % I tipo uint8 
[numPixMax, g1max] = max(h); % Mucho cuidado: el nivel de gris real es g1max - 1

close all, imhist(I); axis([0 255 0 max(h)+1000]), title(num2str(g1max-1));

% 2.- Nivel de gris del máximo correspondiente a la segunda contribucion de
% pixeles:

% Hay que asegurarse que la separación entre los dos máximos sea suficiente
% para evitar que ambos se encuentren en la misma clase.

% Evaluar ara cada nivel de gris [(g - g1max)^2 * h(g)] , 1 >= g >= 256
% El nivel de gris del máximo de la segunda contribución será el que tiene
% el valor máximo.

valores2Max = zeros(256,1);

for g=1:256
    valores2Max(g) = ((g-g1max)^2) * h(g);
end

[~, g2max] = max(valores2Max); % Ojo, en este caso es el valor maximo se ha calculado bien por un pequeño error
close all, imhist(I); axis([0 255 0 max(h)+1000]), title(num2str(g2max));

% 3.- Calcular el minimo entre máximos:

% Vamos a calcular el minimo de h garantizando que ese minimo este entre
% los dos maximos

% En el vector h vamos a modificar todos los valores que no se encuentren
% entre los dos máximos y les vamos a asignar el número máximo de valores
% el histograma - asi podemos hacer el minimo del vector global y acceder
% al indice donde se alcanza.

if g1max < g2max
    h(1:g1max) = numPixMax;
    h(g2max:256) = numPixMax;
    gmax1 = g1max - 1;
    gmax2 = g2max - 1;
else
    h(1:g2max) = numPixMax;
    h(g1max:256) = numPixMax;
    gmax2 = g1max - 1;
    gmax1 = g2max - 1;
end

close all, imhist(I); axis([0 255 0 max(h)+1000]), figure,stem(0:255,h,'.r');

[~, indice] = min(h);
g_MinEntreMax = indice - 1;

%% Observación: método sensible a ruido en h - solucion: suavizado previo (Paso previo)

%% Ejemplo suavizado de histograma

% Primero obtenemos un histograma normalizado(entre 0 y 1)
horig = imhist(uint8(I));
horig_norm = (1/max(horig))*horig;

% Le metemos ruido al histograma
valorMaxRuido = 0.05;
h = horig_norm + valorMaxRuido*rand(size(horig)); % h: h ruidoso
close all;
figure, plot(0:255, horig_norm, 'r');
figure, plot(0:255,h,'g');

% Ejemplo de suavizado
hs = h;
hs(1) = (h(1)+h(2))/2; hs(256) = (h(255)+h(256))/2;

for i=2:255
    hs(i) = (h(i-1)+h(i)+h(i+1))/3;
    % hs(i) = (h(i-1)+2*h(i)+h(i+1))/4; % dando prioridad al pixel a tratar
end
figure, plot(0:255,hs,'b')
% En este caso no es tan importante porque el valor maximo de ruido que le
% hemos es de 0.05

% Vamos a meterle un ruido superior pero en posiciones random

valoresAleatorios = rand(size(horig));
h = horig_norm;
for i = 1:256
    if rand(1)>0.95
        h(i) = 0.4*rand(1);
    end
end
close all;
figure, plot(0:255, horig_norm, 'r');
figure, plot(0:255,h,'g');
% En este caso si que el ruido tiene un efecto determinante a la hora de
% buscar le minimo entre maximos

% Volvemos a suavizar
hs = h;
hs(1) = (h(1)+h(2))/2; hs(256) = (h(255)+h(256))/2;

for i=2:255
    hs(i) = (h(i-1)+h(i)+h(i+1))/3;
    % hs(i) = (h(i-1)+2*h(i)+h(i+1))/4; % dando prioridad al pixel a tratar
end
figure, plot(0:255,hs,'b')
% En este caso se aprecia una gran diferencia pero se puede mejorar mas con
% pesos

vectorPesos = [1 2 4 8 4 2 1];
hSuav = funcion_suaviza_vector_medias_moviles(h,vectorPesos);
figure, plot(0:255,hSuav,'b')


