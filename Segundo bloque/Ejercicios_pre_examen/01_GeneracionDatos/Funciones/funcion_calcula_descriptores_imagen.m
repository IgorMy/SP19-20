function XImagen = funcion_calcula_descriptores_imagen(Ietiq,N)
    
    % Establecemos el tamaño inicial de XImagen
    XImagen = zeros(N,23); % N muestras x 23 descriptores

    % Sacamos todos los datos de regionprops
    stats = regionprops(Ietiq,'Area','Perimeter','Eccentricity','Solidity','Extent','EulerNumber');
    
    % Calculamos la compacticidad
    areas = cat(1,stats.Area);
    perimetros = cat(1,stats.Perimeter);
    XImagen(:,1) = (perimetros.^2)./areas;
    
    % Establecemos la Excentricidad
    XImagen(:,2) = cat(1,stats.Eccentricity);
    
    % Establecemos la Solidez_CHull
    XImagen(:,3) = cat(1,stats.Solidity);
    
    % Establecemos la Extension_BBox sin rotación
    XImagen(:,4) = cat(1,stats.Extent);
    
    % Calculamos la Extension_BBox con rotación (Invariable Rotacion) y los
    % momentos de Hu y los 10 DF
    X = [];
    
    for i=1:N
        
        Ibin_i = Ietiq == i;
        extentIR = Funcion_Calcula_Extent(Ibin_i);
        m = Funcion_Calcula_Hu(Ibin_i);
        DF = Funcion_Calcula_DF(Ibin_i,10);
        X(i,:) = [extentIR m' DF'];
        
    end
    
    XImagen(:,5:22) = X;
    
    % Establecemos el numero de euler
    XImagen(:,23) = cat(1,stats.EulerNumber);
end