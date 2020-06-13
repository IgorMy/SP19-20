%% REPRESENTACIÓN Y ANÁLISIS CUALITATIVO INICIAL DEL CONJUNTO DE DATOS X-Y
%% ------------------------------------------------------------------------
clear, clc, close all, restoredefaultpath;
%% --------------------------------------------------------------
%% CARGAR CONJUNTO DE DATOS Y VARIABLES DEL PROBLEMA
%% --------------------------------------------------------------

addpath('DatosGenerados')
addpath('Funciones')
load conjunto_datos.mat
load nombresProblema.mat


%% --------------------------------------------------------------
%% REPRESENTAR LOS DATOS EN ESPACIOS DE CARACTERISTICAS DOS A DOS
%% --------------------------------------------------------------

% Cada gráfica en una ventana tipo figure. Utilizar la función:
% funcion_representa_datos(X,Y, espacioCcas, nombresProblema)
for i=1:2:size(X,2)-1
    funcion_representa_datos(X,Y, [i i+1], nombresProblema)
end

%% ---------------------------------------------------------------
%% REPRESENTACIÓN HISTOGRAMA Y DIAGRAMA DE CAJAS DE CADA DESCRIPTOR
%% ---------------------------------------------------------------

% Para cada descriptor, abrir dos ventanas tipo figure
% una para representar histogramas y otra para diagramas de caja

% En cada una de ellas se representan los datos del descriptor para las 
% distintas clases del problema en gráficas independientes

% - Histogramas: tantas filas de gráficas como clases -


subplot(numClases,1,i)
%- Diagramas de caja: tantas columnas de gráficas como clases -
subplot(1,numClases,i)

%Ejemplo de programación

numClases = size(unique(Y),1);
numDescriptores = size(X,2);
codifClases = unique(Y);
nombreDescriptores = nombresProblema.descriptores;
nombreClases = nombresProblema.clases;
numMuestras = size(X,1);

for j=1:numDescriptores - 1 % se descarta el numero de euler
    
    % Valores máximo y mínimos para representar en la misma escala
    vMin = min(X(:,j)); 
    vMax = max(X(:,j));
    
    hFigure = figure; hold on
    bpFigure = figure; hold on
    
    for i=1:numClases
    
        Xij = X(Y==codifClases(i),j); % datos de la clase i del descriptor j 
        numDatosClase = size(Xij,1);

        figure(hFigure)
        subplot(numClases,1,i), hist(Xij),
        xlabel(nombreDescriptores{j})
        ylabel('Histograma')
        axis([ vMin vMax 0 numMuestras/4]) % inf para escala automática del eje y
        title(nombreClases{i})
        
        figure(bpFigure)
        subplot(1,numClases,i), boxplot(Xij)
        xlabel('Diagrama de Caja')
        ylabel(nombreDescriptores{j})
        axis([ 0 2 vMin vMax ])
        title(nombreClases{i})
    end
end


%% ---------------------------------------------------------------
%% OBTENER CONCLUSIONES DE LA EFICIENCIA DE CADA DESCRIPTOR - ANÁLISIS CUALITATIVO
%% ---------------------------------------------------------------

% Por cada descriptor, asignar una categoría según la siguiente escala:

% Escala de adecuación del descriptor: no adecuado, adecuado, muy adecuado 

% 1 muy adecuado
% 2 no adecuado
% 3 no adecuado
% 4 no adecuado
% 5 adecuado
% 6 muy adecuado
% 7 no adecuado
% 8 no adecuado
% 9 no adecuado
% 10 no adecuado
% 11 no adecuado
% 12 no adecuado
% 13 muy adecuado
% 14 no adecuado
% 15 no adecuado
% 16 no adecuado
% 17 adecuado
% 18 no adecuado
% 19 no adecuado
% 20 no adecuado
% 21 adecuado
% 22 no adecuado
% 23 no adecuado

