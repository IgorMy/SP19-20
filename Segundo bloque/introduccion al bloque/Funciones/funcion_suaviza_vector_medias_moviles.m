function hs = funcion_suaviza_vector_medias_moviles(h,pesos)

    amp = floor(length(pesos)/2);
    
    pesos = (1/sum(pesos))*pesos;
    
    pesos = pesos(:)'; % vector fila siempre
    hc = h(:); % vector columna siempre
    hamp = [hc(amp+1:-1:2) ; hc ; hc(end-1:-1:end-amp)];
    
    hs = zeros(size(h));
    
    for i=1:length(h)
        ind_hamp = i+amp;
        hs(i) = pesos*hamp(ind_hamp-amp:ind_hamp+amp); % producto matricial
    end
end