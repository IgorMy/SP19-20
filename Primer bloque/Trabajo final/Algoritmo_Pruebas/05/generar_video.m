clear,clc;

%% Cargamos las variables necesarias
addpath('../01')
addpath('../04/VariablesGeneradas')

addpath('Funciones')

%% Datos del clasificador

load parametros_clasificador.mat;

%% Lectura video de entrada

nombre_archivo_video_entrada = '01_ColorAzul.avi';
videoInput = VideoReader(nombre_archivo_video_entrada);
[numFrames, numFilasFrame, numColumnasFrame,FPS] = carga_video_entrada(videoInput);

%% Generar video de salida
nombre_archivo_video_salida = 'video_salida_color_azul1.avi';
videoOutput = VideoWriter(nombre_archivo_video_salida);
videoOutput.FrameRate = FPS;

open (videoOutput);
color = [255 255 255];

% Por cada frame del video de entrada:

% - Calcular imagen binaria detección por distancia basada en múltiples
% esferas

% - Eliminar agrupaciones de 1's binarios que no tengan un área minima
% según umbral de conectividad. El resultado sigue siendo una matríz lógica

% - Solo si hay 1's binarios en la matriz binaria anterior (si no hay, es 
% que no se ha detectado nada y no hay nada que mostrar; en este caso el video
% de salida se genera con el frame del video de entrada sin modificar)

    % - Etiquetar
    
    % - Calcular los centroides de las agrupaciones
    
    % - Modificar el frame que esta siendo analizado situando una caja
    %   blanca 3x3 centrada en los pixeles más cercanos a cada centroide
    %   obtenido
    
    % - Si no es posible situar la caja 3x3 por no entrar en las
    % dimensiones de la imagen, unicamente localizar cada centroide,
    % poniendo en color blanco unicamente el pixel en cuestion
    
    % - Escribir el frame modificado en el archivo de video de salida
    
for i=1:numFrames
    I = read(videoInput,i);
    Ib = calcula_deteccion_multiples_esferas_en_imagen(I, datosMultiplesEsferas_clasificador);
    stats=regionprops(Ib,'Area','Centroid');
    Areas = cat(1,stats.Area);
    Centroides = cat(1,stats.Centroid);
    if(max(Areas)>numPix)
        R = I(:,:,1);
        G = I(:,:,2);
        B = I(:,:,3);
        for j=1:size(Areas,1)
            Centroides(j,2) = round(Centroides(j,2));
            Centroides(j,1) = round(Centroides(j,1));
            if(Centroides(j,2) > 0 && Centroides(j,2) < numFilasFrame && Centroides(j,1) > 0 && Centroides(j,1) < numColumnasFrame)
                R(Centroides(j,2)-1:Centroides(j,2)+1,Centroides(j,1)-1:Centroides(j,1)+1) = color(1);
                G(Centroides(j,2)-1:Centroides(j,2)+1,Centroides(j,1)-1:Centroides(j,1)+1) = color(2);
                B(Centroides(j,2)-1:Centroides(j,2)+1,Centroides(j,1)-1:Centroides(j,1)+1) = color(3);
            else
                R(Centroides(j,2),Centroides(j,1)) = color(1);
                G(Centroides(j,2),Centroides(j,1)) = color(2);
                B(Centroides(j,2),Centroides(j,1)) = color(3);
            end
        end
        I=cat(3,R,G,B);
    end
    writeVideo(videoOutput,I); 
end

close(videoOutput);

%% Posibles variantes

% Unicamente mostar el centroide del area mas grande

%% Lectura video de entrada

nombre_archivo_video_entrada = '01_ColorAzul.avi';
videoInput = VideoReader(nombre_archivo_video_entrada);
[numFrames, numFilasFrame, numColumnasFrame,FPS] = carga_video_entrada(videoInput);

%% Generar video de salida
nombre_archivo_video_salida = 'video_salida_color_azul2.avi';
videoOutput = VideoWriter(nombre_archivo_video_salida);
videoOutput.FrameRate = FPS;
open(videoOutput);

for i=1:numFrames
    I = read(videoInput,i);
    Ib = calcula_deteccion_multiples_esferas_en_imagen(I, datosMultiplesEsferas_clasificador);
    stats=regionprops(Ib,'Area','Centroid');
    Areas = cat(1,stats.Area);
    Centroides = cat(1,stats.Centroid);
    if(max(Areas)>numPix)
        [~,Indice] = sort(Areas,'descend');
        R = I(:,:,1);
        G = I(:,:,2);
        B = I(:,:,3);
        Centroides(Indice(1),2) = round(Centroides(Indice(1),2));
        Centroides(Indice(1),1) = round(Centroides(Indice(1),1));
        if(Centroides(Indice(1),2) > 0 && Centroides(Indice(1),2) < numFilasFrame && Centroides(Indice(1),1) > 0 && Centroides(Indice(1),1) < numColumnasFrame)
            R(Centroides(Indice(1),2)-1:Centroides(Indice(1),2)+1,Centroides(Indice(1),1)-1:Centroides(Indice(1),1)+1) = color(1);
            G(Centroides(Indice(1),2)-1:Centroides(Indice(1),2)+1,Centroides(Indice(1),1)-1:Centroides(Indice(1),1)+1) = color(2);
            B(Centroides(Indice(1),2)-1:Centroides(Indice(1),2)+1,Centroides(Indice(1),1)-1:Centroides(Indice(1),1)+1) = color(3);
        else
            R(Centroides(Indice(1),2),Centroides(Indice(1),1)) = color(1);
            G(Centroides(Indice(1),2),Centroides(Indice(1),1)) = color(2);
            B(Centroides(Indice(1),2),Centroides(Indice(1),1)) = color(3);
        end
        
        I=cat(3,R,G,B);
    end
    writeVideo(videoOutput,I); 
end

close(videoOutput);

%% Ademas de la detección por distacia considerar unicamente los pixeles
% En movimiento. Se conisdera que los pixeles en movimiento con aquellos
% cuya diferencia en valor absoluto de dos frames de intensidad
% consecutivos, es superior a un cierto umbral. En esta situacion no
% eliminar ninguna agrupacion por conectividad

% Por cada frame del  vidoe de entrada:

% - Calcular imagen binaria detección por distancia basada en multiples
% esferas

% - Calcular imagen binaria detección movimiento

% calcular imagen binaria detección final: pixeles presentes en las dos
% detecciones

% No eliminar pequeñas agrupaciones conexas

% .....

%% Lectura video de entrada

nombre_archivo_video_entrada = '01_ColorAzul.avi';
videoInput = VideoReader(nombre_archivo_video_entrada);
[numFrames, numFilasFrame, numColumnasFrame,FPS] = carga_video_entrada(videoInput);

%% Generar video de salida
nombre_archivo_video_salida = 'video_salida_color_azul3.avi';
videoOutput = VideoWriter(nombre_archivo_video_salida);
videoOutput.FrameRate = FPS;
open(videoOutput);

Ibb = false(numFilasFrame,numColumnasFrame);

for i=1:numFrames
    I = read(videoInput,i);
    Ib = calcula_deteccion_multiples_esferas_en_imagen(I, datosMultiplesEsferas_clasificador);
    Ic = imabsdiff(Ib,Ibb);
    stats=regionprops(Ic,'Area','Centroid');
    Areas = cat(1,stats.Area);
    Centroides = cat(1,stats.Centroid);
    if(max(Areas)>1)
        [~,Indice] = sort(Areas,'descend');
        R = I(:,:,1);
        G = I(:,:,2);
        B = I(:,:,3);
        Centroides(Indice(1),2) = round(Centroides(Indice(1),2));
        Centroides(Indice(1),1) = round(Centroides(Indice(1),1));
        if(Centroides(Indice(1),2) > 0 && Centroides(Indice(1),2) < numFilasFrame && Centroides(Indice(1),1) > 0 && Centroides(Indice(1),1) < numColumnasFrame)
            R(Centroides(Indice(1),2)-1:Centroides(Indice(1),2)+1,Centroides(Indice(1),1)-1:Centroides(Indice(1),1)+1) = color(1);
            G(Centroides(Indice(1),2)-1:Centroides(Indice(1),2)+1,Centroides(Indice(1),1)-1:Centroides(Indice(1),1)+1) = color(2);
            B(Centroides(Indice(1),2)-1:Centroides(Indice(1),2)+1,Centroides(Indice(1),1)-1:Centroides(Indice(1),1)+1) = color(3);
        else
            R(Centroides(Indice(1),2),Centroides(Indice(1),1)) = color(1);
            G(Centroides(Indice(1),2),Centroides(Indice(1),1)) = color(2);
            B(Centroides(Indice(1),2),Centroides(Indice(1),1)) = color(3);
        end
        
        I=cat(3,R,G,B);
    end
    writeVideo(videoOutput,I);
    Ibb = Ib;
end

close(videoOutput);
