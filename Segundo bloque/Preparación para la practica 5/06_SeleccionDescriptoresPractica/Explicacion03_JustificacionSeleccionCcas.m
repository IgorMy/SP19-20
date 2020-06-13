%% PROBLEMA DE CLASIFICACIÓN:
% UN EXPERTO RECOMIENDA A CLIENTES SOBRE SI PARA ELLOS ES MEJOR ALQUILAR
% O COMPRAR UNA VIVIENDA. PARA EFECTUAR ESTA RECOMENDACIÓN SE BASA EN 
% INFORMACIÓN DE LOS CLIENTES RELATIVA A SUS INGRESOS, GASTOS, NÚMERO DE HIJOS...

clear, clc, close all

addpath('Datos_ejemplo_seleccion_atributos')
addpath('Funciones')

%% CARGAMOS CONJUNTO DE DATOS, DEFINIMOS VARIABLES DEL PROBLEMA
load datosEjemploSeleccionAtributos.mat

[numMuestras, numDescriptores] = size(X);
codifClases = unique(Y);
numClases = length(codifClases);

%% REPRESENTACION DESCRIPTORES PARA LAS DOS CLASES

% DIAGRAMAS DE CAJA DE CADA DESCRIPTOR

nombreDescriptores = nombresProblema.descriptores;
nombreClases = nombresProblema.clases;
close all

for j=1:numDescriptores-1

    bpFigure = figure; hold on
    
    for i=1:numClases
    
        Xij = X(Y==codifClases(i),j); % datos clase i del descriptor j
    
        figure(bpFigure)
        subplot(1,numClases,i), boxplot(Xij)
        xlabel('Diagrama de Caja')
        ylabel([nombreDescriptores{j} ' - ' nombreClases{i}])
        axis([ 0 2 -3 3 ]) % manejamos datos estandarizados

    end
    
    inputs = X(:,j)';
    outputs = Y';
    indiceJdescriptor = indiceJ(inputs,outputs);
    sgtitle(['Separabilidad ' nombreDescriptores{j} ': ' num2str(indiceJdescriptor)])
    
end


% EN ESPACIOS DE CARACTERISTICAS DOS A DOS
close all
for i=1:2:numDescriptores-1 % para que sean pares
    
    espacioCcas = [i i+1];
    funcion_representa_datos(X,Y, espacioCcas, nombresProblema)
    % la funcion abre una ventana tipo figure
    
    inputs = X(:,espacioCcas)';
    outputs = Y';
    indiceJEspacioCca = indiceJ(inputs,outputs);
    title(['Separabilidad Espacio CCas dado por  '...
        nombreDescriptores{espacioCcas} ': ' num2str(indiceJEspacioCca)])
    
end


%% EJERCICIO:

%% 1- DETERMINA LOS TRES MEJORES DESCRIPTORES INDIVUDIALES

outputs = Y';
valoresJ = zeros(1,numDescriptores);
for j=1:numDescriptores
    inputs = X(:,j)';
    valoresJ(1,j) = indiceJ(inputs,outputs);
end
[valoresJord,indices] = sort (valoresJ,'descend');

mejoresDInd = indices(1:3);
JmejoresDInd = valoresJord(1:3);

%% 2.- REPRESENTA SUS DIAGRAMAS DE CAJA Y AÑADE EN EL TÍTULO EL INDICE DE 
% SEPARABILIDAD DE CADA DESCRIPTOR

nombreDescriptores = nombresProblema.descriptores;
nombresClases = nombresProblema.clases;
close all;

for j=1:length(mejoresDInd)%6 %numDescriptores - 1 % se descarta el numero de euler

    d = mejoresDInd(j);
    bpFigure = figure; hold on;
    
    for i=1:numClases
    
        Xij = X(Y==codifClases(i),d); % datos de la clase i del descriptor j 
        
        figure(bpFigure);
        subplot(1,numClases,i), boxplot(Xij);
        xlabel('Diagrama de Caja');
        ylabel([nombreDescriptores{d} ' - ' nombresClases{i}]);
        axis([ 0 2 -3 3 ]);
    end
    sgtitle(['Separabilidad ' nombreDescriptores{j} ': ' num2str(JmejoresDInd(j))]);
end

%% 3.- REPRESENTA LAS MUESTRAS EN EL ESPACIO DE CARACTERÍSTICAS DEFINIDO POR
% ESOS TRES DESCRIPTORES

espacioCcas = mejoresDInd;
funcion_representa_datos(X,Y,espacioCcas,nombresProblema)

%% 4.- AÑADE AL TÍTULO DE LA GRÁFICA ANTERIOR EL VALOR DE SEPARABILIDAD DE 
% ESE ESPACIO  DE CARACTERÍSTICAS

inputs = X(:,espacioCcas)';
outputs = Y';
indicesJEspacioCca = indiceJ(inputs,outputs);
title(['Separabilidad Espacio CCas dado por ' nombreDescriptores{espacioCcas} ': ' num2str(indicesJEspacioCca)]);

%% 5.- UTILIZA LA FUNCIÓN DE MATLAB combnk PARA ENCONTRAR LA COMBINACIÓN DE 
% 3 DESCRIPTORES QUE PRODUCE LA MAYOR SEPARABILIDAD

comb = combnk(1:numDescriptores,3);
numComb = size(comb,1);

outputs = Y';
valoresJ = zeros(numComb,1);
for i=1:numComb
    columnasOI = comb(i,:);
    inputs = X(:,columnasOI)';
    valoresJ(i) = indiceJ(inputs,outputs);
end
[valoresJord,indices] = sort (valoresJ,'descend');

mejoresD = comb(indices(1),:);
JmejoresD = valoresJord(1);

%% 6.- REPRESENTA LAS MUESTRAS DEL ESPACIO DE CARACTERÍSTICAS DEFINIDO POR
% ESOS TRES DESCRIPTORES Y AÑADA EL ÍNDICE DE SEPARABILIDAD EN EL TÍTULO

espacioCcas = mejoresD;
funcion_representa_datos(X,Y,espacioCcas,nombresProblema)
inputs = X(:,espacioCcas)';
outputs = Y';
indicesJEspacioCca = indiceJ(inputs,outputs);
title(['Separabilidad Espacio CCas dado por ' nombreDescriptores{espacioCcas} ': ' num2str(indicesJEspacioCca)]);

%% 7.- ¿QUÉ CONCLUSIONES EXTRAES?

% El proceso de seleccion de atributos es muy importante, a la hora de
% seleccionar un atributo individual puede ser muy malo, pero en conjunto
% con otros puede ser maravilloso