function representa_multiples_esferas_espacio_ccas(datosMultiplesEsferas,X,Y)
    close all;
    
    valoresY = unique(Y);
    FoI = Y == valoresY(2); % Filas de la clase de interes - color de seguimiento
    Xcolor = X(FoI,:);
    idx = funcion_kmeans(Xcolor,size(datosMultiplesEsferas,1));
    
    valoresCentros = datosMultiplesEsferas(:,1:3);
    valoresRadios = datosMultiplesEsferas(:,4:6);
    significadoRadios{1} = 'Radio sin perdidas';
    significadoRadios{2} = 'Radio sin ruido';
    significadoRadios{3} = 'Radio compromiso';

    for i = 1:size(valoresRadios,2)
        figure(i),set(i,'Name',significadoRadios{i});
        representa_datos_fondo(X,Y),hold on;
        representa_datos_color_seguimiento_por_agrupaciones(Xcolor,idx);
        for j=1:size(datosMultiplesEsferas,1)
            representa_esfera(valoresCentros(j,:),valoresRadios(j,i));
        end
    end
end