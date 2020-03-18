function Matriz_Binaria_Filtrada = Filtra_Objetos(Matriz_Binaria,NumPix)

    [imagen_etiquetada numero] = funcion_etiquetar(Matriz_Binaria);

    Areas = Calcular_Area(imagen_etiquetada);
    
    posiciones = find(Areas>NumPix);
    
    N = size(posiciones,1);
    
    Matriz_Binaria_Filtrada = zeros(size(Matriz_Binaria));
    
    for i=1:N
        Matriz_Binaria_Filtrada(imagen_etiquetada==posiciones(i)) = 1;
    end
end