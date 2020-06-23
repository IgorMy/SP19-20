function Funcion_Reconoce_Formas(rutaFicheroImagen, Tipo)

    %% Cargamos los datos de estandarización
    load("../01_GeneracionDatos/DatosGenerados/datos_estandarizados");
    
    %A-D
    rutaFichero = '../02_KNN_A_D/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'C_KNN_A_D.mat';
    load([rutaFichero nombreFichero]);
    
    %Renombramos los datos
    espacioCcasAD = espacioCcas;
    XoIRedAD = XoIRed;
    YoIRedAD = YoIRed;
    nombresProblemaIORedAD = nombresProblemaIORed;
    
    % C-E
     rutaFichero = '../03_MD_C_E/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'C_MD_C_E.mat';
    load([rutaFichero nombreFichero]);
    
    % Renombramos los datos
    espacioCcasCE = espacioCcas;
    XoIRedCE = XoIRed;
    YoIRedCE = YoIRed;
    nombresProblemaIORedCE = nombresProblemaIORed;
    d12MDECE = d12MDE;
    d12MDMCE = d12MDM;
    coeficientes_d12MDECE = coeficientes_d12MDE;
    coeficientes_d12MDMCE = coeficientes_d12MDM;
    
    clear rutaFichero nombreFichero espacioCcas XoIRed YoIRed nombresProblemasIORed rutaParcial
    
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
        ZRedAD = Z(:,espacioCcasAD);
        ZRedCE = Z(:,espacioCcasCE);
        
        %% Por cada objeto de la imagen, vamos a ir comprobando de que tipo es usando las funciones de clasificación
        for i=1:N
          funcion_visualiza(I,Ietiq == i,[255,255,0]);
          
          % Comprobamos el numero de euler 
          if(Z(i,23) == -1) % B
              title("B");
          elseif (Z(i,23) == 0) % A y D
              k = 9;
              YTest = funcion_knn (ZRedAD(i,:), XoIRedAD, YoIRedAD, k, Tipo);
              if YTest == 1
                title("A");
              else
                title("D");
              end
              funcion_representa_muestras_clasificacion_binaria(XoIRedAD,YoIRedAD)
              hold on
              plot3(ZRedAD(i,1),ZRedAD(i,2),ZRedAD(i,3),'oy');
              hold off
          else % La unica posibilidad restante esque sea una clasificación entre C y E
              x1 = ZRedCE(i,1);
              x2 = ZRedCE(i,2);
              x3 = ZRedCE(i,3);
              if Tipo == "Euclidea"
                d12_evaluada = eval(d12MDECE);
              else
                d12_evaluada = eval(d12MDMCE);
              end
              
              if d12_evaluada > 0
                title("C");
              else
                title("E"); 
              end
              
              if Tipo == "Euclidea"
                funcion_representacion_clasificacion_binaria_con_frontera(XoIRedCE,YoIRedCE,coeficientes_d12MDE);
              else
                funcion_representacion_clasificacion_binaria_con_frontera(XoIRedCE,YoIRedCE,coeficientes_d12MDM);
              end
              hold on
              plot3(x1,x2,x3,'oy');
              hold off
              pause
          end

        end
        
    end
end