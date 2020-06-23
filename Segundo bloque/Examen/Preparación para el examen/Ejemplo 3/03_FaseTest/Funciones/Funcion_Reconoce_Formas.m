function Funcion_Reconoce_Formas(rutaFicheroImagen, Tipo)

    %% Cargamos los datos de estandarización
    load("../01_GeneracionDatos/DatosGenerados/datos_estandarizados");
    
    %Clasificador knn
    rutaFichero = '../02_KNN/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'C_KNN.mat';
    load([rutaFichero nombreFichero]);
    
    clear rutaFichero nombreFichero
    
    %% Leemos la imagen
    I = imread(rutaFicheroImagen);
    
    %% Obtenemos el umbral de la imagen
    umbral = graythresh(I);
    
    %% Obtenemos la imagen binaria
    Ibin = I < 255*umbral;
    
    %% Eliminamos el ruido
    Ibin_filt = funcion_elimina_regiones_ruidosas(Ibin);
    
    %% Comprobamos que queden objetos en la imagen, en caso contrario no devolvemos nada
    
    if sum(sum(Ibin_filt)) > 0
        
        %% Obtenemos la imagen etiquetada
        [Ietiq,N] = bwlabel(Ibin_filt);
        
        %% Por cada objeto de la imagen, calculamos sus descriptores 
        XImagen = funcion_calcula_descriptores_imagen(Ietiq,N);
        
        %% Estandarizamos los descriptores
        Z = XImagen;
        for i=1:size(XImagen,2) - 1
            Z(:,i) = (XImagen(:,i)-medias(i))/desviaciones(i);
        end
        ZRed = Z(:,espacioCcas);
        
        %% Por cada objeto de la imagen, vamos a ir comprobando de que tipo es usando las funciones de clasificación
        for i=1:N
          funcion_visualiza(I,Ietiq == i,[255,255,0]);
          
          % Comprobamos el numero de euler 
          if(Z(i,23) == -1) % B
              title("B");
          else
              k = 5;
              YTest = funcion_knn (ZRed(i,:), XoIRed, YoIRed, k, "Mahalanobis");
              if YTest == 1
                title("A");
              elseif YTest == 2
                title("C");
              elseif YTest == 3
                title("D");
              elseif YTest == 4
                title("E");
              end
              funcion_representa_muestras_clasificacion_binaria(XoIRed,YoIRed)
              hold on
              plot3(ZRed(i,1),ZRed(i,2),ZRed(i,3),'oy');
              hold off
          end

        end
        
    end
end