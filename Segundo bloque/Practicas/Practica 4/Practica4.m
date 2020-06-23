clear,clc,close all;

%% Cargo los directorios
addpath('Funciones');
addpath('Imagenes');
addpath('Videos');

% Cargamos las imagenes
A1 = imread('A1.jpg');
A2 = imread('A2.jpg');
A3 = imread('A3.jpg');

% Convertimos la primera imagen a imagen de intensidad
A1I = rgb2gray(A1);

%% Minimo entre maximos (Estudio teorico)

% Calculamos el histograma de cada una de las imagenes
[h1,nivelesGris1] = imhist(A1I);
[h2,nivelesGris2] = imhist(A2);
[h3,nivelesGris3] = imhist(A3);

% Calculamos la intensidad maxima de cada histograma y obtenemos uno de los
% maximos
[numPixMax1, A1I_max] = max(h1);
[numPixMax2, A2_max] = max(h2);
[numPixMax3, A3_max] = max(h3);

% Realmente el nivel maximo es el nivel calculado anteriormente -1 
% debido a que el histograma va de 1~256 y no de 0~255

% Ahora vamos a calcular el segundo maximo
valores2Max1 = zeros(256,1);
valores2Max2 = zeros(256,1);
valores2Max3 = zeros(256,1);

% Se aplica la formula ((posicion_en_estudio - posicion_del_maximo_umbral)^2)*nivel_de_gris_de_la_posicion_en_estudio
for g=1:256
    valores2Max1(g) = ((g-A1I_max)^2)*h1(g);
    valores2Max2(g) = ((g-A2_max)^2)*h2(g);
    valores2Max3(g) = ((g-A3_max)^2)*h3(g);
end

[~, A1I_max2] = max(valores2Max1);
[~, A2_max2] = max(valores2Max2);
[~, A3_max2] = max(valores2Max3);

% Generación de la función
minimo_entre_maximos1 = funcion_minimo_entre_maximos(A1I_max,A1I_max2,numPixMax1,h1);
minimo_entre_maximos2 = funcion_minimo_entre_maximos(A2_max,A2_max2,numPixMax2,h2);
minimo_entre_maximos3 = funcion_minimo_entre_maximos(A3_max,A3_max2,numPixMax3,h3);

%% Suavización de ruido en el histograma
% Se lo aplicaremos a la imagen 3

horig = imhist(A3);
horig_norm = (1/max(horig))*horig;

valorMaxRuido = 0.05;
h = horig_norm + valorMaxRuido*rand(size(horig));
close all;
figure, plot(0:255,horig_norm,'r');
figure, plot(0:255,h,'g');

%% Segunda parte

vectorPesos = [1 2 9 2 1];
[g_MinEntreMax, gmax1, gmax2] = funcion_MinEntreMaximos(A1I,vectorPesos);
[g_MinEntreMax, gmax1, gmax2] = funcion_MinEntreMaximos(A2,vectorPesos);
[g_MinEntreMax, gmax1, gmax2] = funcion_MinEntreMaximos(A3,vectorPesos);


