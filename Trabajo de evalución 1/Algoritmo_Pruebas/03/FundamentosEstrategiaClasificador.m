clear,close all;

%% Rutas a directorios con información
addpath('../02/VariablesGeneradas');
addpath('../01/');
addpath('funciones');

%% Lectura de conjunto de datos (implay para ver videos en matlab)
load conjunto_de_datos.mat

%% Representamos datos
representa_datos_color_seguimiento_fondo(X,Y);

%% Estrategia de clasificación
% Basada en el establecer una region del espacio de caracteristicas que
% englobe a todas las muestras de al clase correspondiente a los pixeles
% que son del color del objeto de seguimiento

% Datos de esa clase de interés
valoresY = unique(Y);
FoI = Y == valoresY(2);
Xclase = X(FoI,:);

% Valores representativos de esa clase: Valores medios, máximos y minimos
% de cada atributo (R,G,B)
valoresMedios = mean(Xclase);
valoresMaximos = max(Xclase);
valoresMinimos = min(Xclase);

%% Primera Opción
% Caracterización de la región de interes basada en Establecer un prisma
% rectangular en el espacio RGB asociado al color de seguimiento.

% Dimensiones del prisma basada en valores maximos y minimos
% de esta forma engloba a todos los pixeles del color
Rmin = valoresMinimos(1); Rmax = valoresMaximos(1);
Gmin = valoresMinimos(2); Gmax = valoresMaximos(2);
Bmin = valoresMinimos(3); Bmax = valoresMaximos(3);

% Representación del prisma en el espacio de caracteristicas
% close all;
% open('...');

% Clasificador: regla de decisión sencilla
% Considerar un pixel caracterizado por R, G y B es del color is:
% (Rmin < R < Rmax) && (Gmin < G  < Gmax) && (Bmin < B < Bmax)

% close all;
% representa_datos_fondo(X,Y);

% Conclusiones: si se utiliza este esquema de clasificación para analizar
% los frames del vido:

% Por cada frame y cada pixel del mismo
% 1.- Sacar valores R,G,B
% 2.- Evaluar la regla de decisión anterior y generar imagen binaria
% 3.- Etiquetar agrupaciones conexas de 1's y calcular sus centroides
% 4.- Modificar el frame original para visualizar los centroides con cajas
% 3x3
% 5.- Generar video de salida con los frames procesados

% implay(...)

% Observación: si se pierde el objeto es porque las muestras de color
% extraidas de las imágenes de clasificación no ha nsido representativas,
% no hay ninguna imagen que haya caracterizado el color del objeto en esa 
% posicion donde se pierde el seguimiento

%% Segunda opción
% Caracterización basada en superficie esférica centrada en color medio

% Centro de la esfera: Color medio
valoresMedios = mean(Xclase);
Rc = valoresMedios(1);
Gc = valoresMedios(2);
Bc = valoresMedios(3);

% Representamos el centroide sobre la nube del color de seguimiento
close all,representa_datos_color_seguimiento(X,Y);
hold on, plot3(Rc,Gc,Bc,'*k');



%% Funciones pedidas

datosEsfera = calcula_datos_esfera(X,Y);

close all;
centroide = datosEsfera(1:3); radios = datosEsfera(4:6);
for i=1:length(radios)
    representa_datos_color_seguimiento_fondo(X,Y);
    hold on, representa_esfera(centroide,radios(i)),hold off
    title(['Esfera de Radio: ' num2str(radios(i))])
end
close all;


%% Funcion que muestra los subplot
clear,clc;
addpath('../01/');
addpath('../02/VariablesGeneradas');
addpath('funciones');
load conjunto_de_datos.mat
datosEsfera = calcula_datos_esfera(X,Y);
load ImagenesEntrenamiento_Calibracion.mat
funcion_imagenes_calibracion(imagenes,datosEsfera);

