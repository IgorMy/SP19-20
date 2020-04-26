function idx = funcion_calcula_agrupacion(X,centroides)
    matriz = zeros(size(centroides,1),length(X));
    valores = double(X');
    for i=1:size(centroides,1)
        R = centroides(i,1);
        G = centroides(i,2);
        B = centroides(i,3);
        matriz2 = repmat([R;G;B;],1,length(X));
        matriz(i,:,:) = sqrt(sum((valores-matriz2).^2));
    end
    idx = zeros(length(X),1);
    for i=1:length(X)
        [ ~,idx(i)] = min(matriz(:,i));
    end
end