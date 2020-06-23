function funcion_imagenes_calibracion(imagenes,datosEsfera)
    
    % Sacamos los datos de datosEsfera
    Rc = datosEsfera(1);
    Gc = datosEsfera(2);
    Bc = datosEsfera(3);
    radios = datosEsfera(4:6);
    
    % Lanzamos un nuevo figure
    FigH = figure;
    
    for i=1:size(imagenes,4)
        
        % Establecemos el titulo al figure
        set(FigH,'NumberTitle', 'off', 'Name', num2str(i));
        
        % Cargamos la imagen
        imagen = imagenes(:,:,:,i);
        
        % Mostramos la primera imagen
        subplot(2,2,1),imshow(imagen),title('Original');
        
        % Calculamos las distancias
        R = double(imagen(:,:,1));
        G = double(imagen(:,:,2));
        B = double(imagen(:,:,3));
        MD = sqrt( (R-Rc).^2 + (G-Gc).^2 + (B-Bc).^2 );

        % Mostramos la segunda imagen
        Ib = MD <= radios(1);
        subplot(2,2,2),imshow(funcion_visualiza(imagen,Ib,[255,0,0])),title('Radio total');
        
        % Mostramos la tercera imagen
        Ib = MD <= radios(2);
        subplot(2,2,3),imshow(funcion_visualiza(imagen,Ib,[255,0,0])),title('Radio minimo');
        
        % Mostramos la tercera imagen
        Ib = MD <= radios(3);
        subplot(2,2,4),imshow(funcion_visualiza(imagen,Ib,[255,0,0])),title('Radio de compromiso');
        
        pause
    end
    
end