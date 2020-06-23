function varLogica = funcion_compara_matrices(matriz1,matriz2)
    buffer = matriz1-matriz2;
    if( sum(sum(buffer)) == 0)
        varLogica = true;
    else
        varLogica = false;
    end
end