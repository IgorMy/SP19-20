function Funcion_Reconoce_Formas(rutaFicheroImagen)

    %% Cargamos los datos de estandarización
    
    load("../../01_GeneracionDatos/DatosGenerados/datos_estandarizados");
    
    %% Añadimos la ruta al fichero de entrenamiento
    rutaParcial = '../../02_FaseEntrenamiento/Ejemplo1/';
    
    %knn entre CirculosTriangulos_Cuadrados
    rutaFichero = '01_MDE_CC_T/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'C_MDE_CC_T.mat';
    load([rutaParcial rutaFichero nombreFichero]);
    
    %Renombramos los datos
    espacioCcasCCT = espacioCcas;
    XoIRedCCT = XoIRed;
    YoIRedCCT = YoIRed;
    nombresProblemaIORedCCT = nombresProblemaIORed;
    d12CCT = d12;
    coeficientes_d12CCT = coeficientes_d12;
    
    % MD entre circulos y triangulos
    rutaFichero = '02_MDM_C_C/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'MDM_circ_cuad.mat';
    load([rutaParcial rutaFichero nombreFichero]);
    
    % Renombramos los datos
    espacioCcasCC = espacioCcas;
    XoIRedCC = XoIRed;
    YoIRedCC = YoIRed;
    nombresProblemaIORedCC = nombresProblemaIORed;
    d12CC = d12;
    coeficientes_d12CC = coeficientes_d12;
    
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
        ZRedCCT = Z(:,espacioCcasCCT);
        ZRedCC = Z(:,espacioCcasCC);
        
        %% Por cada objeto de la imagen, vamos a ir comprobando de que tipo es usando las funciones de clasificación
        for i=1:N
          funcion_visualiza(I,Ietiq == i,[255,255,0]);
          
          x1 = ZRedCCT(i,1);
          x2 = ZRedCCT(i,2);
          x3 = ZRedCCT(i,3);
          
          d12_CCT_evaluada = eval(d12CCT);
          
          if d12_CCT_evaluada > 0
              
                x1 = ZRedCC(i,1);
                x2 = ZRedCC(i,2);
                x3 = ZRedCC(i,3);
              
                d12_evaluada = eval(d12CC);
              
              if d12_evaluada > 0
                  title("Circulo");
              else
                  title("Cuadrado");
              end
              
          else
              title("Triangulo");
          end
          
        end
        
    end
end