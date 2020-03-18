function Area = Calcular_Area(Matriz_Etiquetada)
    N = size(unique(Matriz_Etiquetada),1)-1;
    Area = zeros(N,1);
    for i=1:N
        Area(i)=sum(sum(Matriz_Etiquetada==i));
    end
end