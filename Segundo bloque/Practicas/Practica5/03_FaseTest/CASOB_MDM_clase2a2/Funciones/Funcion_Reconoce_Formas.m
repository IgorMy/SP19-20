function Funcion_Reconoce_Formas(rutaFicheroImagen)

    %% Cargamos los datos de estandarización
    
    load("../../01_GeneracionDatos/DatosGenerados/datos_estandarizados");
    
    %% Añadimos la ruta a los ficheros de entrenamiento
    rutaParcialFichero = '../../02_FaseEntrenamiento/CASOB_MDM_clase2a2/';
    % Circulo-Cuadrado
    rutaFichero = '01_CirculoCuadrado/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'MDM_circ_cuad.mat';
    load([rutaParcialFichero rutaFichero nombreFichero]);
    
        % Renombramos los ficheros
        coeficientes_d12cc = coeficientes_d12;
        d12cc = d12;
        espacioCcascc = espacioCcas;
        nombresProblemaIORedcc = nombresProblemaIORed;
        XoIRedcc = XoIRed;
        YoIRedcc = YoIRed;
    
    % Circulo-Triangulo
    rutaFichero = '02_CirucloTriangulo/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'MDM_circ_trian.mat';
    load([rutaParcialFichero rutaFichero nombreFichero]);
    
        % Renombramos los ficheros
        coeficientes_d12ct = coeficientes_d12;
        d12ct = d12;
        espacioCcasct = espacioCcas;
        nombresProblemaIORedct = nombresProblemaIORed;
        XoIRedct = XoIRed;
        YoIRedct = YoIRed;
        
    % Cuadrado-Triangulo
    rutaFichero = '03_CuadradoTriangulo/02_DisegnoClasificador/DatosGenerados/';
    nombreFichero = 'MDM_cuad_trian.mat';
    load([rutaParcialFichero rutaFichero nombreFichero]);
    
        % Renombramos los ficheros
        coeficientes_d12cut = coeficientes_d12;
        d12cut = d12;
        espacioCcascut= espacioCcas;
        nombresProblemaIORedcut = nombresProblemaIORed;
        XoIRedcut = XoIRed;
        YoIRedcut = YoIRed;

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
        
        
        %% Por cada objeto de la imagen, vamos a ir comprobando de que tipo es usando las funciones de clasificación
        for i=1:N
            
           funcion_visualiza(I,Ietiq == i,[255,255,0]);
          
          % Circulo-Cuadrado
            x1 = Z(i,espacioCcascc(1));
            x2 = Z(i,espacioCcascc(2));
            x3 = Z(i,espacioCcascc(3));
            valor_d12_cc = eval(d12cc);
          % Circulo-Triangulo
            x1 = Z(i,espacioCcasct(1));
            x2 = Z(i,espacioCcasct(2));
            x3 = Z(i,espacioCcasct(3));
            valor_d12_ct = eval(d12ct);
          % Cuadrado-Triangulo
            x1 = Z(i,espacioCcascut(1));
            x2 = Z(i,espacioCcascut(2));
            x3 = Z(i,espacioCcascut(3));
            valor_d12_cut = eval(d12cut);
            
          if (valor_d12_cc > 0 && valor_d12_ct > 0 )
            title("Circulo");
          else
              if (valor_d12_cc < 0 && valor_d12_cut > 0 )
                title("Cuadrado");
              else
                title("Triangulo");
              end
          end
            
        end
        
    end
end