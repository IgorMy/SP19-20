function X = funcion_calcula_hu_objetos_imagen(Ietiq,N)
    
    X = [];
    
    for i=1:N
        
        Ibin_i = Ietiq == i;
        m = Funcion_Calcula_Hu(Ibin_i);
        X(i,:) = m';
        
    end

end