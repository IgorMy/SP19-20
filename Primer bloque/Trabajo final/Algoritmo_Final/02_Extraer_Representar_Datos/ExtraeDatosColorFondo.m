%% Inicializamos los directorios y borramos el espacio de trabajo
clear,clc;
addpath("../01_GeneracionMaterial");
addpath("VariablesGeneradas");
addpath("Funciones");

%% Cargamos las imagenes de calibración
load ImagenesEntrenamiento_Calibracion.mat

%% Visualización de las imagenes

[N, M, NumComp, NumImag] = size(imagenes);

for i=1:NumImag
    imshow(imagenes(:,:,:,i)),title(num2str(i))
    pause
end

% 1-7 Imagen de fondo
% 8-15 Imagenes con el objeto

%% Extracción de pixeles de las imagenes con el objeto

inicial = 1;

for i=8:NumImag
    
    I = imagenes(:,:,:,i);

    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
    ROI = roipoly(I);
    DatosColor(inicial:inicial+sum(ROI(:))-1,:,:,:) = [i*ones(length(R(ROI)),1) R(ROI) G(ROI) B(ROI)];
    inicial = inicial+sum(ROI(:));
end



%% Extracción de pixeles de las imagens de fondo

numero_de_tomas = 2;
inicial = 1;

for i=1:7
    for j=1:numero_de_tomas
    I = imagenes(:,:,:,i);

    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
    ROI = roipoly(I);
    DatosFondo(inicial:inicial+sum(ROI(:))-1,:,:,:) = [i*ones(length(R(ROI)),1) R(ROI) G(ROI) B(ROI)];
    inicial = inicial+sum(ROI(:));
    end
end


%% Generamos conjunto de datos X e Y

X = [DatosColor(:,2:4) ; DatosFondo(:,2:4)];

Y = [ones(size(DatosColor,1),1) ; zeros(size(DatosFondo,1),1) ];



%% Guardamos los datos obtenidos

save("./VariablesGeneradas/conjunto_de_datos_originales","X","Y");

%% Pasamos a representar los datos
clear;
load("./VariablesGeneradas/conjunto_de_datos_originales");
close all;
representa_datos_color_seguimiento_fondo(X,Y);


%% Eliminación de colores atipicos
clear;
load("./VariablesGeneradas/conjunto_de_datos_originales");
pos_outliers = funcion_detecta_outliers_clase_interes(X,Y);

X(pos_outliers,:) = [];
Y(pos_outliers,:) = [];

representa_datos_color_seguimiento_fondo(X,Y);

save('./VariablesGeneradas/conjunto_de_datos','X','Y');
