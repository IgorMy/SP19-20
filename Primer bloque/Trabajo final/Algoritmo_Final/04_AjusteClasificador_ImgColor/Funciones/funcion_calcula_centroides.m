function centroides = funcion_calcula_centroides(X,idx)
    centroides = zeros(size(unique(idx),1),3);
    for i=1:size(unique(idx),1)
        FoI = idx == i;
        valores = X(FoI,:);
        centroides(i,:)=mean(valores);
    end
end