%% Cargamos los directorios
addpath("Funciones");
addpath("Imagenes");

%% Comprobar camara
video = videoinput('linuxvideo',1,'YUY2_352X288');
preview(video);
video.TriggerRepeat = inf;
video.FrameGrabInterval = 1;
start(video);
TIEMPO=[];
while video.FramesAcquired < 150
   [I,TIME] = getdata(video,1);
   TIEMPO = [TIEMPO ; TIME];
   imshow(I);
end

stop(video);
video
flushdata(video);

% Mi camara funciona a 10fps (Algo absurdo pero es lo k hay)

%% Ejercicio 3
% La  escena inicialmente oscurecida y aclarándose progresivamente(utilizar la instrucción imadjust).

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('winvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'RGB';

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=10;
set(video, 'LoggingMode', 'memory'); %innecesario

% Creamos el archivo de salida
aviobj = VideoWriter("3.avi", 'Uncompressed AVI');
aviobj.FrameRate = 10;

% Empiezo a grabar con la modificación (sube gama cada segundo)
gamma = 4:-0.5:0;
figure,hold on
open(aviobj);
start(video);
for i=1:size(gamma,2)*10
    
    Ibuf = getdata(video,1);
    g = round(i/10);
    if(g == 0)
        g = 1;
    end
    writeVideo(aviobj,imadjust(Ibuf,[],[],gamma(g)));
    imshow(imadjust(Ibuf,[],[],gamma(g)));
    
    
end
stop(video);
close(aviobj);

%% Ejercicio 4
% Todoslos  píxeles  que  tenganuna  intensidad  mayor que  un  determinado  umbral.  Asignar inicialmente 
% el valor 0 a este umbral e ir aumentándolo progresivamente.

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('winvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'RGB';

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=10;
set(video, 'LoggingMode', 'memory'); %innecesario

% Creamos el archivo de salida
aviobj = VideoWriter("4.avi", 'Uncompressed AVI');
aviobj.FrameRate = 10;

% establezco el umbral
umbral=0:255;

% Empiezo a grabar con la modificación
open(aviobj);
start(video);
for i=1:256
    Ibuf = getdata(video,1);
    Ib=Ibuf>=umbral(i);
    imshow(uint8(times(double(Ibuf),double(Ib))));
    writeVideo(aviobj,uint8(times(double(Ibuf),double(Ib))));
end
stop(video);
close(aviobj);

%% Ejercicio 5
% Las diferencias que se producen entre los distintos frames que captura la webcam(utilizar la instrucción imabsdiff).

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('winvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'RGB';

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=10;
set(video, 'LoggingMode', 'memory'); %innecesario

% Creamos el archivo de salida
aviobj = VideoWriter("5.avi", 'Uncompressed AVI');
aviobj.FrameRate = 10;

open(aviobj);
start(video);

inicial = getdata(video,1);

for i=1:100 % 10s
    ibuf = getdata(video,1);
    diferencia = imabsdiff(inicial,ibuf);
    inicial = ibuf;
    imshow(diferencia);
    writeVideo(aviobj,diferencia);
end
stop(video);
close(aviobj);

%% Ejercicio 6
% El movimiento más significativo a partir de diferencias de imágenes de intensidad.

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('winvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'grayscale';

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=10;
set(video, 'LoggingMode', 'memory'); %innecesario

% Creamos el archivo de salida
aviobj = VideoWriter("6.avi", 'Uncompressed AVI');
aviobj.FrameRate = 10;

open(aviobj);

umbral = 65;

start(video);

inicial =   getdata(video,1);

for i=1:100
    ibuf = getdata(video,1);
    diferencia = imabsdiff(inicial,ibuf);
    sig = (diferencia > umbral);
    inicial = ibuf;
    subplot(1,3,1),imshow(ibuf);
    subplot(1,3,2),imshow(diferencia);
    subplot(1,3,3),imshow(sig);
    writeVideo(aviobj,double(sig));
end

stop(video);
close(aviobj);

%% Ejercicio 7

% El seguimiento del movimiento del objeto mayor detectado en las diferencias
% significativas de imágenes de intensidad. El seguimiento debe visualizarse a través de un
% punto rojo situado en el centroide del objeto.

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('winvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'grayscale';

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=2;

umbral = 65;

start(video);

inicial =   getdata(video,1);

for i=1:200
    ibuf = getdata(video,1);
    diferencia = imabsdiff(inicial,ibuf);
    sig = (diferencia > umbral);
    inicial = ibuf;
    if(sum(sum(sig)) > 5)
        stats=regionprops(sig,'Area','Centroid');
        Areas = cat(1,stats.Area);
        Centroides = cat(1,stats.Centroid);
        [~,Indice] = sort(Areas,'descend');
        subplot(1,2,1),imshow(ibuf),hold on, plot(Centroides(Indice(1),1),Centroides(Indice(1),2),'*r');
    else
        subplot(1,2,1),imshow(ibuf),hold on, plot(1,1,'*r');
    end
    subplot(1,2,2),imshow(sig);
end

stop(video);

%% Ejercicio propuesto

% Grabar un video a 10fps de 15segundos que muestre sobre las imágenes a color capturadaspor 
% una  webcamuna cuadrado  3x3rojoque  se  mueva  de  forma aleatoria (en cada imagen, se establecerá de
% forma aleatoria la posición central del cuadrado utilizando la función de Matlab rand).

% Limpio el espacio de trabajo
clear,clc;

% Inicializo las variables de la camara
video = videoinput('winvideo',1,'YUY2_352X288');
video.ReturnedColorSpace = 'RGB';

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=10;
set(video, 'LoggingMode', 'memory'); %innecesario

% Creamos el archivo de salida
aviobj = VideoWriter("ejercicio_propuesto.avi", 'Uncompressed AVI');
aviobj.FrameRate = 10;

open(aviobj);
start(video);

inicial = getdata(video,1);

for i=1:150 % 10s
    ibuf = getdata(video,1);
    x = round(rand()*349) + 2;
    y = round(rand()*285) + 2;
    ibuf(y-1:y+1,x-1:x+1,1) = 255;
    ibuf(y-1:y+1,x-1:x+1,2) = 0;
    ibuf(y-1:y+1,x-1:x+1,3) = 0;
    imshow(ibuf);
    writeVideo(aviobj,ibuf);
end
stop(video);
close(aviobj);