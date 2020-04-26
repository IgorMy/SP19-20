function [idx,centroides]=funcion_kmeans(X,k)
    X = double(X);
    
    idx = funcion_agrupa_por_desviacion(X,k);
    
    Matrices_iguales = false;
    while not(Matrices_iguales)
       
        centroides = funcion_calcula_centroides(X,idx);
        
        idx_new = funcion_calcula_agrupacion(X,centroides);
        
        Matrices_iguales = funcion_compara_matrices(idx,idx_new);
        
        idx = idx_new;
    end
    
end