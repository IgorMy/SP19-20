function Funcion_Reconoce_Formas(rutaFicheroImagen, Tipo)

    %% Cargamos los datos de estandarización
    load("../01_GeneracionDatos/DatosGenerados/datos_estandarizados");
    
    % MDE AR-TU
    rutaFichero = '../02_MDE_AR_TU/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'C_MDE_AR_TU.mat';
    load([rutaFichero nombreFichero]);
    
        %Renombramos los datos
        espacioCcasAR_TU = espacioCcas;
        XoIRedAR_TU = XoIRed;
        YoIRedAR_TU = YoIRed;
        nombresProblemaIORedAR_TU = nombresProblemaIORed;
    
    % KNN AL-AR-T
     rutaFichero = '../03_KNN_AL_AR_T/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'C_KNN_AL_AR_T.mat';
    load([rutaFichero nombreFichero]);
    
        % Renombramos los datos
        espacioCcasAL_AR_T = espacioCcas;
        XoIRedAL_AR_T = XoIRed;
        YoIRedAL_AR_T = YoIRed;
        nombresProblemaIORedAL_AR_T = nombresProblemaIORed;
    
    % KNN TH-TR
     rutaFichero = '../04_KNN_TH_TR/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'C_KNN_TH_TR.mat';
    load([rutaFichero nombreFichero]);
    
        % Renombramos los datos
        espacioCcasTH_TR = espacioCcas;
        XoIRedTH_TR = XoIRed;
        YoIRedTH_TR = YoIRed;
        nombresProblemaIORedTH_TR = nombresProblemaIORed;
    
    
    
    clear rutaFichero nombreFichero espacioCcas XoIRed YoIRed nombresProblemasIORed rutaParcial
    
    %% Leemos la imagen
    I = imread(rutaFicheroImagen);
    
    %% Obtenemos el umbral de la imagen
    umbral = graythresh(I);
    
    %% Obtenemos la imagen binaria
    Ibin = I > 255*umbral;
    
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
        ZRedAL_AR_T = Z(:,espacioCcasAL_AR_T);
        ZRedAR_TU = Z(:,espacioCcasAR_TU);
        ZRedTH_TR = Z(:,espacioCcasTH_TR);
        
        %% Por cada objeto de la imagen, vamos a ir comprobando de que tipo es usando las funciones de clasificación
        for i=1:N
          figure;
          subplot(2,2,1);
          funcion_visualiza(I,Ietiq == i,[0,0,255]);
          
          % Comprobamos el numero de euler 
          if(Z(i,23) == 0) % estamos en el primer caso y tenemos que diferenciar entre arandelas y tuercas
            x1 = ZRedAR_TU(i,1);
            x2 = ZRedAR_TU(i,2);
            x3 = ZRedAR_TU(i,3);
              
            d12_evaluada = eval(d12);
            
            if(d12_evaluada > 0)
                title("Arandela");
            else
                title("Tuerca");
            end
            
          else % Tenemos que ver de que tipo es segun el knn, entre alcayatas lisas, alcayatas tipo rosca y tornillos 
              YTest = funcion_knn (ZRedAL_AR_T(i,:),XoIRedAL_AR_T  , YoIRedAL_AR_T , 3, "Euclidea");
              if YTest == 3
                  title("alcayatas lisas");
              elseif YTest == 4
                  title("alcayatas tipo rosca");
              else
                  % Estamos con los tornillos, por lo que tendremos que
                  % comprobar de que tipo es el tornillo
                  YTest = funcion_knn( ZRedTH_TR(i,:), XoIRedTH_TR, YoIRedTH_TR, 5, "Mahalanobis");
                  if YTest == 5
                      title("Tornillo hexagonal");
                  else
                      title("Tornillo rosca");
                  end
              end
                  
          end
          
          %% Por ultimo sacamos los distintos subplots para identificar la posición del objeto
          subplot(2,2,2);
          funcion_representacion_clasificacion_binaria_con_frontera(XoIRedAR_TU,YoIRedAR_TU,nombresProblemaIORedAR_TU)
          hold on
          plot3(ZRedAR_TU(i,1),ZRedAR_TU(i,2),ZRedAR_TU(i,3),'om');
          hold off
          title('Comparación entre arandelas y tuercas')
          
          subplot(2,2,3);
          funcion_representacion_clasificacion_binaria_con_frontera(XoIRedAL_AR_T,YoIRedAL_AR_T,nombresProblemaIORedAL_AR_T)
          hold on
          plot3(ZRedAL_AR_T(i,1),ZRedAL_AR_T(i,2),ZRedAL_AR_T(i,3),'om');
          hold off
          title('Comparación entre  alcayatas lisas, alcayatas tipo rosca y tornillos')
          
          subplot(2,2,4);
          funcion_representacion_clasificacion_binaria_con_frontera(XoIRedTH_TR,YoIRedTH_TR,nombresProblemaIORedTH_TR)
          hold on
          plot3(ZRedTH_TR(i,1),ZRedTH_TR(i,2),ZRedTH_TR(i,3),'om');
          hold off
          title('Comparación entre tornillos hexagonals y tornillos con rosca')
          
        end
        
    end
end