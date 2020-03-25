function  Centroides = Calcula_Centroides(Matriz_Etiquetada)
    Areas = Calcular_Area(Matriz_Etiquetada);
    N = size(Areas,1);
    Centroides = zeros(N,2);
    for i=1:N
        [x,y] = find(Matriz_Etiquetada==i);
        Centroides(i,1) = sum(y)/Areas(i);
        Centroides(i,2) = sum(x)/Areas(i);
    end
end