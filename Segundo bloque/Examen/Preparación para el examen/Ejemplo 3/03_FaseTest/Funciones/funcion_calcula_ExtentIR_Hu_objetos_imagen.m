function X = funcion_calcula_ExtentIR_Hu_objetos_imagen(Ietiq,N)
    
    X = [];
    
    for i=1:N
        
        Ibin_i = Ietiq == i;
        extentIR = Funcion_Calcula_Extent(Ibin_i);
        m = Funcion_Calcula_Hu(Ibin_i);
        X(i,:) = [extentIR m'];
        
    end

end