%% Cargamos los directorios
addpath("Funciones");
addpath("Imagenes");

%% Ejercicio 1
% Utilizando la función de Matlab subplot , muestre en una misma ventana tipo figure la
% imagen capturada y distintas imágenes que resalten, sobre la imagen original, aquellos píxeles
% cuya intensidad sea mayor que un determinado umbral (asigne distintos valores de umbral
% para generar las distintas imágenes). La intensidad de un píxel se calculará como la media de
% los niveles de gris de las componentes roja, verde y azul.

% Limpio el espacio de trabao
clear,clc;

% Primero compruebo el hardware de adquisición de imagenes del ordenador
datos=imaqhwinfo;
datos.InstalledAdaptors % Linux = linuxvideo , Windows = winvideo

% Compruebo los formatos disponibles (linux)
datos = imaqhwinfo("linuxvideo");
datos.DeviceInfo.SupportedFormats % En linux son todos YUY2

% Creo el objeto de video
video = videoinput('linuxvideo',1,'YUY2_352X288');

% Cambio el color a devolver para no tener que hacerlo luego color a
% color
video.ReturnedColorSpace = 'RGB';

% Guardo una imagen en la matriz imagen
I = getsnapshot(video);imtool(I);

% Defino los umbrales;
umbrales = [50 130 210];

% Genero la imagen en blanco y negro
Ib = rgb2gray(I);

% Genero el subplot
subplot(2,2,1),imshow(I);
subplot(2,2,2),imshow(funcion_visualiza(I,Ib>umbrales(1),[255,0,0]));
subplot(2,2,3),imshow(funcion_visualiza(I,Ib>umbrales(2),[0,255,0]));
subplot(2,2,4),imshow(funcion_visualiza(I,Ib>umbrales(3),[0,0,255]));

%% Ejercicio 2
% Para  cada  una  de  las imágenesgeneradas  en  el  apartado  anterior,localice a  
% través  de  su centroide los distintos “objetos” (agrupaciones de píxeles conexos) 
% detectados.  Visualice  el centroide del objeto de mayor área en otro color para distinguirlo.

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('linuxvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'RGB';

% Recogo una foto
I = getsnapshot(video);

% Empiezo generando el subplot
subplot(2,2,1),imshow(I);

% Genero el segundo subplot con su centroide
stats=regionprops(Ib>umbrales(1),'Area','Centroid');
Areas = cat(1,stats.Area);
Centroides = cat(1,stats.Centroid);
[~,Indice] = sort(Areas,'descend');
subplot(2,2,2),imshow(funcion_visualiza(I,Ib>umbrales(1),[255,0,0])),hold on, plot(Centroides(Indice(1),1),Centroides(Indice(1),2),'*b');

% Genero el tercer subplot con su centroide
stats=regionprops(Ib>umbrales(2),'Area','Centroid');
Areas = cat(1,stats.Area);
Centroides = cat(1,stats.Centroid);
[~,Indice] = sort(Areas,'descend');
subplot(2,2,3),imshow(funcion_visualiza(I,Ib>umbrales(2),[0,255,0])),hold on, plot(Centroides(Indice(1),1),Centroides(Indice(1),2),'*r');

% Genero el cuarto subplot
stats=regionprops(Ib>umbrales(3),'Area','Centroid');
Areas = cat(1,stats.Area);
Centroides = cat(1,stats.Centroid);
[~,Indice] = sort(Areas,'descend');
subplot(2,2,4),imshow(funcion_visualiza(I,Ib>umbrales(3),[0,0,255])),hold on, plot(Centroides(Indice(1),1),Centroides(Indice(1),2),'*r');

%% Ejercicio 3
% La  escena inicialmente oscureciday  aclarándose progresivamente(utilizar  la  instrucción imadjust).

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('linuxvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'RGB';

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=3;
video.FrameGrabInterval=3;

% Empiezo a grabar con la modificación

gamma = 0:0.5:4;
start(video);
for i=1:size(gamma,2)
    Ibuf = getdata(video,1);
    imshow(imadjust(I,[],[],gamma(i)));
end
stop(video);

%% Ejercicio 4
% Todoslos  píxeles  que  tenganuna  intensidad  mayor que  un  determinado  umbral.  Asignar inicialmente 
% el valor 0 a este umbral e ir aumentándolo progresivamente.

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('linuxvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'RGB';

% establezco el umbral
umbral=0:255;

%Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=5;
video.FrameGrabInterval=2;

% Empiezo a grabar con la modificación
start(video);
for i=1:256
    Ibuf = getdata(video,1);
    Ib=rgb2gray(Ibuf)<=umbral(i);
    R = Ibuf(:,:,1).*uint8(Ib);
    G = Ibuf(:,:,2).*uint8(Ib);
    B = Ibuf(:,:,3).*uint8(Ib);
    imshow(cat(3,R,G,B));
end
stop(video);

%% Ejercicio 5
% Las diferencias que se producen entre los distintos frames que captura la webcam(utilizar la instrucción imabsdiff).

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('linuxvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'RGB';

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=10;
video.FrameGrabInterval=2;

% Capturo una imagen inicial
inicial = getsnapshot(video);

start(video);
for i=1:200
    ibuf = getdata(video,1);
    diferencia = rgb2gray(imabsdiff(inicial,ibuf)) > 20;
    subplot(1,2,1),imshow(funcion_visualiza(ibuf,diferencia,[255,0,0])),title("Diferencia");
    subplot(2,2,2),imshow(ibuf),title("Tiempo real");
    subplot(2,2,4),imshow(inicial),title("Anterior");
    inicial = ibuf;
end
stop(video);

%% Ejercicio 6
% El movimiento más significativo a partir de diferencias de imágenes de intensidad.

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('linuxvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'RGB';

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=10;
video.FrameGrabInterval=2;

% Capturo una imagen inicial
inicial = getsnapshot(video);

start(video);
for i=1:500
    
    ibuf = getdata(video,1);
    diferencia = rgb2gray(imabsdiff(inicial,ibuf)) > 50; % para eliminar parte del ruido
    
    if(sum(sum(diferencia)) > 50)
    stats=regionprops(diferencia,'Area','Centroid');
    Areas = cat(1,stats.Area);
    Centroides = cat(1,stats.Centroid);
    [~,Indice] = sort(Areas,'descend');
       subplot(1,2,1),imshow(inicial),hold on,plot(Centroides(Indice(1),1),Centroides(Indice(1),2),'*r'),title("Diferencia");
    else
       subplot(1,2,1),imshow(inicial),title("Diferencia");
    end
    subplot(2,2,2),imshow(ibuf),title("Tiempo real");
    subplot(2,2,4),imshow(inicial),title("Anterior");
    inicial = ibuf;
end

stop(video);

%% Ejercicio 7

% El seguimiento del movimiento del objeto mayor detectado en las diferencias
% significativas de imágenes de intensidad. El seguimiento debe visualizarse a través de un
% punto rojo situado en el centroide del objeto.

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('linuxvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'RGB';

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=10;
video.FrameGrabInterval=2;

% Capturo una imagen inicial
inicial = getsnapshot(video);
dinicial = 0;
start(video);
for i=1:500
    
    ibuf = getdata(video,1);
    diferencia = rgb2gray(imabsdiff(inicial,ibuf)) > 50; % para eliminar parte del ruido
    if(sum(sum(diferencia))>dinicial)
        
    else
        imshow()
    end
    
    
end

stop(video);