function funcion_imagenes_calibracion_numPix(imagenes,datosEsfera,numPix)
    % Lanzamos un nuevo figure
    FigH = figure;
    valoresConectividad{1} = ['numPix = ' num2str(numPix(1))];
    valoresConectividad{2} = ['numPix = ' num2str(numPix(2))];
    valoresConectividad{3} = ['numPix = ' num2str(numPix(3))];
    for i=1:size(imagenes,4)
        
        % Establecemos el titulo al figure
        set(FigH,'NumberTitle', 'off', 'Name', num2str(i));
        
        % Cargamos la imagen
        imagen = imagenes(:,:,:,i);
        
        % Mostramos la primera imagen
        centroides_radios = datosEsfera(:,1:4);
        Ib = calcula_deteccion_multiples_esferas_en_imagen(imagen,centroides_radios);
        subplot(2,2,1),imshow(funcion_visualiza(imagen,Ib,[255,0,0])),title('Original');
        
        % Mostramos la segunda imagen
        Ibb = bwareaopen(Ib,numPix(1));
        subplot(2,2,2),imshow(funcion_visualiza(imagen,Ibb,[255,0,0])),title(valoresConectividad(1));
        
        % Mostramos la tercera imagen
        Ibb = bwareaopen(Ib,numPix(2));
        subplot(2,2,3),imshow(funcion_visualiza(imagen,Ibb,[255,0,0])),title(valoresConectividad(2));
        
        % Mostramos la tercera imagen
        Ibb = bwareaopen(Ib,numPix(3));
        subplot(2,2,4),imshow(funcion_visualiza(imagen,Ibb,[255,0,0])),title(valoresConectividad(3));
        
        pause
    end
end