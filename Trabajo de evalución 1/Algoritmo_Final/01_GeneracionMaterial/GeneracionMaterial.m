%% Comprobamos la camara

clear,clc;

video = videoinput('winvideo',2,'RGB24_320X240');
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
% Esta camara funciona a 30fps

%% Creando el archivo de video

clear,clc;

video = videoinput('winvideo',2,'RGB24_320X240');

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FrameGrabInterval = 3;

% Creamos el archivo de salida
aviobj = VideoWriter("01_ColorAzul.avi", 'Uncompressed AVI');
aviobj.FrameRate = 10;

% Empiezo a grabar con la modificación (sube gama cada segundo)
figure,hold on
open(aviobj);
start(video);
for i=1:300
    
    Ibuf = getdata(video,1);
    writeVideo(aviobj,Ibuf);
    imshow(Ibuf);
    
end
stop(video);
close(aviobj);

%% Recorremos el archivo de video para sacar los frames mas significativos

clear,clc;

video = VideoReader("01_ColorAzul.avi");

for i=1:video.NumFrames;
    I = read(video,i);
    imshow(I),title(i);
    pause;
end

% 29 fondo centro
% 43 fondo centro cerca
% 58 fondo centro lejos
% 73 fondo izquierda
% 82 fondo derecha
% 94 fondo arriba
% 106 fondo abajo
% 125 color centro-abajo
% 132 color centro
% 140 color arriba
% 154 color abajo
% 166 color derecha
% 180 color izquierda
% 203 color centro cerca
% 221 color lejos

%% Recogemos los frames mas importantes

clear,clc;
video = VideoReader("01_ColorAzul.avi");

I = [29,43,58,73,82,94,106,125,132,140,154,166,180,203,221];
imagenes = uint8(zeros(240,320,3,size(I,2)));

for i=1:size(I,2)
    imagenes(:,:,:,i) = uint8(read(video,I(i)));
end

save("ImagenesEntrenamiento_Calibracion",'imagenes');

