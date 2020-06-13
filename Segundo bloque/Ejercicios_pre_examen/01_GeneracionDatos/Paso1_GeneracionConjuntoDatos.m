close all, clear,clc

%% PROGRAMACI�N GENERACI�N CONJUNTO DE DATOS X-Y

%% LECTURA AUMATIZADA DE LAS IM�GENES DE ENTRENAMIENTO DISPONIBLES

% LECTURA AUTOMATIZADA DE IMAGENES
addpath('../Imagenes/Entrenamiento')
addpath('Funciones')

nombres{1}='Circulo';
nombres{2} = 'Cuadrado';
nombres{3} = 'Triangulo';

numClases = 3;
numImagenesPorClase = 2;

for i=1:numClases
    for j=1:numImagenesPorClase
        
        nombreImagen = [nombres{i} num2str(j,'%02d') '.jpg']
        I = imread(nombreImagen);
        
    end
end


%% --------------------------------
%% 1.- GENERACI�N CONJUNTO DE DATOS X-Y
%% --------------------------------

X = []; 
Y = [];

%% PARA CADA IMAGEN:

for i=1:numClases
    for j=1:numImagenesPorClase
        
        nombreImagen = [nombres{i} num2str(j,'%02d') '.jpg'];
        I = imread(nombreImagen);
        
%% 1.1- BINARIZAR CON METODOLOG�A DE SELECCI�N AUTOM�TICA DE UMBRAL (OTSU)
% Genera: Ibin

        umbral = 255*graythresh(I);
        Ibin = I < umbral;

%% 1.2.- ELIMINAR POSIBLES COMPONENTES CONECTADAS RUIDOSAS: 

% COMPONENTE RUIDOSA:
% COMPONENTES DE MENOS DEL 0.1% DEL N�MERO TOTAL DE P�XELES DE LA IMAGEN
% O N�MERO DE P�XELES MENOR AL AREA DEL OBJETO MAYOR /5
% SE DEBE CUMPLIR CUALQUIERA DE LAS DOS CONDICIONES

% Genera IbinFilt = funcion_elimina_regiones_ruidosas(Ibin);

        IbinFilt = funcion_elimina_regiones_ruidosas(Ibin);

%% 1.3.- ETIQUETAR.

% Genera matriz etiquetada Ietiq y n�mero N de agrupaciones conexas 
        if sum(IbinFilt(:) > 0)
        [Ietiq,N] = bwlabel(IbinFilt);

%% 1.4.- CALCULAR TODOS LOS DESCRIPORES DE CADA AGRUPACI�N CONEXA

% Genera Ximagen - matriz de N filas y 23 columnas (los 23 descriptores
% generados en el orden indicado en la pr�ctica)

        XImagen = funcion_calcula_descriptores_imagen(Ietiq,N);
        X = [X;XImagen];
%% 1.5.- GENERAR Yimagen

% Genera Yimagen -  matriz de N filas y 1 columna con la codificaci�n
% empleada para la clase a la que pertenecen los objetos de la imagen

        Y = [Y;ones(N,1)*i];
        end
    end
end

%% --------------------------------
%% 2.- GENERACI�N VARIABLE TIPO STRUCT nombresProblema
%% --------------------------------

% nombreDescriptores = {'XXX','XXX', 'XXX', 'XXX', ... HASTA LOS 23};

nombreDescriptores = { 'Compacticidad', 'Excentricidad', 'Solidez_CHull(Solidity)', 'Extension_BBox(Extent)', 'Extension_BBox(Invariante Rotacion)', 'Hu1', 'Hu2', 'Hu3', 'Hu4', 'Hu5', 'Hu6', 'Hu7', 'DF1', 'DF2', 'DF3', 'DF4', 'DF5', 'DF6', 'DF7', 'DF8', 'DF9', 'DF10', 'NumEuler'};

% nombreClases:
%nombreClases{1} = 'XXX';
%nombreClases{2} = 'XXX';
%...

nombreClases{1} = 'Circulo';
nombreClases{2} = 'Cuadrado';
nombreClases{3} = 'Triangulo';

% simboloClases: simbolos y colores para representar las muestras de cada clase
% simbolosClases{1} = '*r';
% simbolosClases{2} = 'XXX';
% ...
simbolosClases{1} = '*r';
simbolosClases{2} = '*g';
simbolosClases{3} = '*b';


% ------------------------------------
% nombresProblema = [];
% nombresProblema.descriptores = nombreDescriptores;
% nombresProblema.clases = nombreClases;
% nombresProblema.simbolos = simbolosClases;

nombresProblema = [];
nombresProblema.descriptores = nombreDescriptores;
nombresProblema.clases = nombreClases;
nombresProblema.simbolos = simbolosClases;


%% --------------------------------
%% 3.- GUARDAR CONJUNTO DE DATOS Y NOMBRES DEL PROBLEMA
% (EN DIRECTORIO DATOSGENERADOS)
%% --------------------------------

save('./DatosGenerados/conjunto_datos','X','Y');
save('DatosGenerados/nombresProblema','nombresProblema');

