function funcion_imagenes_calibracion_multiples_esferas(imagenes,datosMultiplesEsferas)
    % Lanzamos un nuevo figure
    FigH = figure;
    for i=1:size(imagenes,4)
        
        % Establecemos el titulo al figure
        set(FigH,'NumberTitle', 'off', 'Name', num2str(i));
        
        % Cargamos la imagen
        imagen = imagenes(:,:,:,i);
        
        % Mostramos la primera imagen
        subplot(2,2,1),imshow(imagen),title('Original');
       
        % Mostramos la segunda imagen
        centroides_radios = datosMultiplesEsferas(:,1:4);
        Ib = calcula_deteccion_multiples_esferas_en_imagen(imagen,centroides_radios);
        subplot(2,2,2),imshow(funcion_visualiza(imagen,Ib,[255,0,0])),title('Radio total');
        
        % Mostramos la tercera imagen
        centroides_radios(:,4) = datosMultiplesEsferas(:,5);
        Ib = calcula_deteccion_multiples_esferas_en_imagen(imagen,centroides_radios);
        subplot(2,2,3),imshow(funcion_visualiza(imagen,Ib,[255,0,0])),title('Radio minimo');
        
        % Mostramos la tercera imagen
        centroides_radios(:,4) = datosMultiplesEsferas(:,6);
        Ib = calcula_deteccion_multiples_esferas_en_imagen(imagen,centroides_radios);
        subplot(2,2,4),imshow(funcion_visualiza(imagen,Ib,[255,0,0])),title('Radio de compromiso');
        
        pause
    end
end