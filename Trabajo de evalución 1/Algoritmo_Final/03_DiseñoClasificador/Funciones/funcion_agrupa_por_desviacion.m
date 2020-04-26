function idx = funcion_agrupa_por_desviacion(X,k)
    
    X = double(X);
    [~,indice] = max(std(X));
    valoresX = X(:,indice);
    
    minimo = min(valoresX)-0.1;
    maximo = max(valoresX)+0.1;
    amplitud_del_intervalo = (maximo-minimo)/k;
    
    idx = zeros(size(X,1),1);
    for i=1:size(X,1)
        muestra = X(i,indice)-minimo;
        idx(i) = ceil(muestra/amplitud_del_intervalo);
    end
end