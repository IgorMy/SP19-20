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

%% Determina la separabilidad del espacio de ccas dado por: [1 5 9]:
%% solo de las muestras de los circulos y cuadrados

espacioCcas = [1 5 9];

clasesOI = [1 2];
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
indiceJEspacionCca = indiceJ(inputs,outputs)

nombresProblemaOI = [];
nombresProblemaOI.descriptores = nombresProblema.descriptores(espacioCcas);
nombresProblemaOI.clases = nombresProblema.clases(clasesOI);
nombresProblemaOI.simbolos = nombresProblema.simbolos(clasesOI);

funcion_representa_datos(XoI,YoI,1:length(espacioCcas), nombresProblemaOI)
% la funcion abre una ventana tipo figure

nombreDescriptores = nombresProblema.descriptores;
title(['Separabilidad Espacio CCas dado por ' nombreDescriptores{espacioCcas} ': ' num2str(indiceJEspacionCca)]);

%% Calculo manual

% Matriz dispersion dentro de las clases: Sw - within clases

% Datos circulos, cuadrados

XCirculos = X(Y==1,espacioCcas);
XCuadrados = X(Y==2,espacioCcas);

covCirculos = cov(XCirculos,1);
covCuadrados = cov(XCuadrados,1);

Sw = covCirculos + covCuadrados

% Mismo código - automatico:

numCcas = length(espacioCcas);
numClases = length(clasesOI);

Sw = zeros(numCcas);
for i=1:numClases

    datosClase = X(Y==codifClasesOI(i),espacioCcas);
    Sw = Sw + cov(datosClase,1);

end
Sw

% Matriz dispersion entre clases Sb - between classes

puntoMedioClases = [];
for i=1:numClases

    datosClase = X(Y==codifClasesOI(i),espacioCcas);
    puntoMedioClases = [puntoMedioClases;mean(datosClase)];
    
end
puntoMedioClases

Sb = size(puntoMedioClases,1)*cov(puntoMedioClases,1);

J = trace(pinv(Sw)*Sb)
