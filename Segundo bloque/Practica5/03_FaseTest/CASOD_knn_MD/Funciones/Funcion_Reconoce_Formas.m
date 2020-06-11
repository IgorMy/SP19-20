function Funcion_Reconoce_Formas(rutaFicheroImagen,Tipo)

    %% Cargamos los datos de estandarización
    
    load("../../01_GeneracionDatos/DatosGenerados/datos_estandarizados");
    
    %% Añadimos la ruta al fichero de entrenamiento
    rutaParcial = '../../02_FaseEntrenamiento/CASOD_knn_MD/';
    
    %knn entre CirculosTriangulos_Cuadrados
    rutaFichero = '01_knn_CirculosTriangulos_Cuadrados/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'knn_CirculosCuadrados_Triangulos.mat';
    load([rutaParcial rutaFichero nombreFichero]);
    
    %Renombramos los datos
    espacioCcasCTC = espacioCcas;
    XoIRedCTC = XoIRed;
    YoIRedCTC = YoIRed;
    nombresProblemaIORedCTC = nombresProblemaIORed;
    
    % MD entre circulos y triangulos
    rutaFichero = '02_MD_Circulos_Triangulos/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'MD_circ_trian.mat';
    load([rutaParcial rutaFichero nombreFichero]);
    
    % Renombramos los datos
    espacioCcasCC = espacioCcas;
    XoIRedCT = XoIRed;
    YoIRedCT = YoIRed;
    nombresProblemaIORedCT = nombresProblemaIORed;
    
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
        ZRedCTC = Z(:,espacioCcasCTC);
        ZRedCC = Z(:,espacioCcasCC);
        
        %% Por cada objeto de la imagen, vamos a ir comprobando de que tipo es usando las funciones de clasificación
        for i=1:N
          funcion_visualiza(I,Ietiq == i,[255,255,0]);
          
          YTest = funcion_knn (ZRedCTC(i,:), XoIRedCTC, YoIRedCTC, 9, Tipo);
          
          
          if YTest == 1
              
                x1 = ZRedCC(i,1);
                x2 = ZRedCC(i,2);
                x3 = ZRedCC(i,3);
              
              if Tipo == "Euclidea"
                d12_evaluada = eval(d12MDE);
              else
                d12_evaluada = eval(d12MDM);
              end
              
              if d12_evaluada > 0
                  title("Circulo");
              else
                  title("Triangulo");
              end
              
          elseif YTest == 2
              title("Cuadrado");
          end
          
        end
        
    end
end