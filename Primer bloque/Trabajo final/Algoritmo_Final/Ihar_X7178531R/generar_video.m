clear,clc;

%% Cargamos las variables necesarias
% Se supone que el video esta en la carpeta junto al script
addpath('Funciones')

%% Lectura video de entrada

nombre_archivo_video_entrada = 'video_entrada.avi';
videoInput = VideoReader(nombre_archivo_video_entrada);
[numFrames, numFilasFrame, numColumnasFrame,FPS] = carga_video_entrada(videoInput);

%% Generar video de salida
nombre_archivo_video_salida = 'video_salida_color_azul.avi';
videoOutput = VideoWriter(nombre_archivo_video_salida);
videoOutput.FrameRate = FPS;
open(videoOutput);

color = [0,255,0];
anterior = read(videoInput,1);
umbral = 50;

for i=2:numFrames
    I = read(videoInput,i);
    Ib = rgb2gray(I);
    Iba = rgb2gray(anterior);
    imagen = imabsdiff(Ib,Iba) >= umbral;
    salida = funcion_visualiza(I,imagen,color);
    writeVideo(videoOutput,salida);
    anterior = I;
end

close(videoOutput);
