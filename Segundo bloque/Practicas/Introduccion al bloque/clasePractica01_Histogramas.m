clear,clc;

%% Ejemplo conceptos básicos - Histograma

I = uint8([ 0 1 5 0; 2 2 2 5]);
imhist(I);
h = imhist(I);
stem(0:5,h(1:6),'.r'),grid on

%% Valor Medio:

% 1.- Recorriendo todos los pixeles de la imagen
Id = double(I);

[numFilas, numColumnas] = size(Id);
numPix = numFilas*numColumnas;
vm=0;
for i=1:numFilas
    for j=1:numColumnas
        vm = vm + Id(i,j);
    end
end
vm=vm/numPix;

vm = mean(Id(:));

% 2.- A partir del histograma
h = imhist(I);
p = h/sum(h); % normalizamos el histograma
vm = 0;
for g=0:255 % es el nivel de gris
    ind = g+1;
    vm = vm + g*p(ind);
end

Ib = I>2 & I <=5; % rango, esto es menos eficiente para nosotros
vm = mean(Id(Ib));

%% Varianza: Desviacion típica al cuadrado

% 1.- Recorriendo todos los pixeles

Id = double(I);
vm = mean(Id(:));

[numFilas, numColumnas] = size(Id);
numPix = numFilas*numColumnas;
varianza=0;
for i=1:numFilas
    for j=1:numColumnas
        varianza = varianza + (Id(i,j)-vm)^2; % Cuanto se aleja cada pixel del valor medio
    end
end
varianza=varianza/numPix;
varianza = var(Id(:),1);

% 2.- A partir del histograma

h = imhist(I);
numPix = sum(h);

varianza = 0;
for g=0:255
    ind = g + 1;
    varianza = varianza + h(ind)*(g-vm)^2;
end
varianza = varianza/numPix;
