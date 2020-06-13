%% Carga de información: Datos y variables del problema
clear,close all, clc

addpath('DatosGeneradosPasoGeneracionDatos')
addpath('Funciones')

load conjunto_datos_estandarizados.mat
load nombresProblema.mat

X = Z;

% Variables del problema
[numMuestras, numDescriptores] = size(X);
codifClases = unique(Y);
numClases = length(codifClases);

%% Representacion diagramas de caja de cada descriptor
nombreDescriptores = nombresProblema.descriptores;
nombreClases = nombresProblema.clases;

for j=1:6 %numDescriptores - 1 % se descarta el numero de euler
    
    % Valores máximo y mínimos para representar en la misma escala
    vMin = min(X(:,j)); 
    vMax = max(X(:,j));
    
    %hFigure = figure; hold on
    bpFigure = figure; hold on
    
    for i=1:numClases
    
        Xij = X(Y==codifClases(i),j); % datos de la clase i del descriptor j 
        numDatosClase = size(Xij,1);

        %figure(hFigure)
        %subplot(numClases,1,i), hist(Xij),
        %xlabel(nombreDescriptores{j})
        %ylabel('Histograma')
        %axis([ vMin vMax 0 numMuestras/4]) % inf para escala automática del eje y
        %title(nombreClases{i})
        
        figure(bpFigure)
        subplot(1,numClases,i), boxplot(Xij)
        xlabel('Diagrama de Caja')
        ylabel(nombreDescriptores{j})
        axis([ 0 2 vMin vMax ])
        %title(nombreClases{i})
    end
    
    inputs = X(:,j)';
    outputs = Y';
    indiceJdescriptor = indiceJ(inputs,outputs);
    sgtitle(['Separabilidad ' nombreDescriptores{j} ': ' num2str(indiceJdescriptor)]);
end

%% Representar los datos en espacio de caracteristicas

for i=1:2:6-1
    funcion_representa_datos(X,Y, [i i+1], nombresProblema)
    inputs = X(:,[i i+1])';
    outputs = Y';
    indiceJEspacionCca = indiceJ(inputs,outputs);
    title(['Separabilidad Espacio CCas dado por ' nombreDescriptores{[i i+1]} ': ' num2str(indiceJEspacionCca)]);
end

%% Determina la separabilidad del espacio de ccas dado por: [1 4 10]:

espacioCcas = [1 4 10];
funcion_representa_datos(X,Y, espacioCcas, nombresProblema)
% la funcion abre una ventana tipo figure
    inputs = X(:,espacioCcas)';
    outputs = Y';
    indiceJEspacionCca = indiceJ(inputs,outputs);
    title(['Separabilidad Espacio CCas dado por ' nombreDescriptores{espacioCcas} ': ' num2str(indiceJEspacionCca)]);

%% Determina la separabilidad del espacio de ccas dado por: [1 4 10]:
%% solo de las muestras de los circulos y triangulos

espacioCcas = [1 4 10];

clasesOI = [1 3];
codifClasesOI = codifClases(clasesOI);

filasOI = false(size(Y));
for i=1:length(clasesOI)
    filasOI_i = Y == codifClasesOI(i);
    filasOI = or(filasOI,filasOI_i);
end

XoI = X(filasOI,espacioCcas);

YoI = Y(filasOI);

inputs = XoI';
outputs = YoI';
indiceJEspacionCca = indiceJ(inputs,outputs);

nombresProblemaOI = [];
nombresProblemaOI.descriptores = nombresProblema.descriptores(espacioCcas);
nombresProblemaOI.clases = nombresProblema.clases(clasesOI);
nombresProblemaOI.simbolos = nombresProblema.simbolos(clasesOI);

funcion_representa_datos(XoI,YoI,1:length(espacioCcas), nombresProblemaOI)
% la funcion abre una ventana tipo figure

nombreDescriptores = nombresProblema.descriptores;
title(['Separabilidad Espacio CCas dado por ' nombreDescriptores{espacioCcas} ': ' num2str(indiceJEspacionCca)]);


 
