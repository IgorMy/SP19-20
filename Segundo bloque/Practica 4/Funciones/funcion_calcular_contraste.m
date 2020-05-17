function contraste = funcion_calcular_contraste(Imagen,brillo)
    if(size(Imagen,3) == 1)
        h = imhist(Imagen);
        numPix = sum(h);
        contraste = 0;
        for g=0:255
            ind = g + 1;
            contraste = contraste + h(ind)*(g-brillo)^2;
        end
        contraste = contraste/numPix;
    else
        if(size(Imagen,3) == 3)
            Imagen = rgb2gray(Imagen);
            h = imhist(Imagen);
            numPix = sum(h);
            contraste = 0;
            for g=0:255
                ind = g + 1;
                contraste = contraste + h(ind)*(g-brillo)^2;
            end
            contraste = contraste/numPix;
        else
             disp("Imagen tiene que ser o una imagen de intensidad o de color");
        end    
    end
end