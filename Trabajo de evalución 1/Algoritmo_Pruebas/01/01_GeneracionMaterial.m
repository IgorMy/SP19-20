
%% Comprobamos la camara

clear,clc;

video = videoinput('linuxvideo',1,'YUY2_320X240');
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

% Esta camara funciona a 10fps

%% Creando el archivo de video

clear,clc;

video = videoinput('linuxvideo',1,'YUY2_320X240');
video.ReturnedColorSpace = 'RGB';

% Inicializo los datos de captura
video.TriggerRepeat=inf;
video.FramesPerTrigger=10;

% Creamos el archivo de salida
aviobj = VideoWriter("01_ColorAzul.avi", 'Uncompressed AVI');
aviobj.FrameRate = 10;

% Empiezo a grabar con la modificación (sube gama cada segundo)
figure,hold on
open(aviobj);
start(video);
for i=1:300
    
    Ibuf = getdata(cam,1);
    writeVideo(aviobj,Ibuf);
    imshow(Ibuf);
    
    
end
stop(video);
close(aviobj);

%% Recorremos el archivo de video para sacar los frames mas significativos

clear,clc;

video = VideoReader("01_ColorAzul.avi");

for i=1:video.NumFrames
    I = read(video,i);
    imshow(I),title(i);
    pause;
end

% 49 fondo vacio
% 98 objeto en el centro
% 123 objeto en el fondo
% 154 objeto frente a la camara
% 189 objeto a la izquierda
% 212 objeto a la derecha
% 225 objeto arriba
% 248 objeto abajo
% 259 objeto abajo pero no del todo
% 271 objeto a la derecha pero no del todo
% 286 objeto arriba pero no del todo
% 300 objeto a la izquierda pero no del todo

%% Recogemos los frames mas importantes

clear,clc;
video = VideoReader("01_ColorRojo.avi");

I = [49,98,123,154,189,212,225,248,259,271,286,300];
imagenes = uint8(zeros(240,320,3,12));

for i=1:size(I,2)
    imagenes(:,:,:,i) = uint8(read(video,I(i)));
end

save("ImagenesEntrenamiento_Calibracion",'imagenes');

