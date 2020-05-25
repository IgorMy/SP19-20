function coeficientes = funcion_calcular_coeficiente_correlacion_XY(X,Y)
    valoresClases = unique(Y);
    coeficientes = zeros(1,size(unique(Y),1));
    for i=1:size(unique(Y),1)
        FoI = Y == valoresClases(i);
        XClase = X(FoI,:);
        coeficientes(1,i) = funcion_calula_coeficiente_correlacion_lineal_2_variables(cov(XClase,1));
        disp(['Coeficiente de la clase ',num2str(i),' : ',num2str(coeficientes(1,i))]); 
    end
    
end