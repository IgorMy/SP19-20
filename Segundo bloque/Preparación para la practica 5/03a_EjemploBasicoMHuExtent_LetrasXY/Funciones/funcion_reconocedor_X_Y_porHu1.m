function funcion_reconocedor_X_Y_porHu1(nombreImagen)

    addpath('Funciones')
    addpath('Imagenes')
    addpath('DatosGenerales')
    
    umbralHu1 = 1.1;
    load nombresProblema.mat;
    
    nombreClases = nombreProblema.clases;
    
    I = imread(nombreImagen);
    
    umbral = graythresh(I); % obtiene umbral en rango 0-1
    Ibin = I < 255*umbral;
    
    if sum(Ibin(:)) > 0
        IbinFilt = funcion_elimina_regiones_ruidosas(Ibin);
        
        [Ietiq, N] = bwlabel(IbinFilt);
        
        XTest = funcion_calcula_Hu_objetos_imagen(Ietiq,N);
        
        for i=1:N
        
            Iobjeto = Ietiq == i;
            
            figure, funcion_visualiza(I,Iobjeto,[255 255 0])
            
            if XTest(i,1) > umbralHu1
                
                title(nombreClases{1})
            else
                title(nombreClases{2})
            end
            
        end
        
    end

end