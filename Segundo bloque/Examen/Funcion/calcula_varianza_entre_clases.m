function var = calcula_varianza_entre_clases(T,h,numPix,gmedio) 
    
    N1 = 0;
    for g=1:T
        N1 = N1 + h(g);
    end
    
    N2 = 0;
    for g=T+1:256
        N2 = N2 + h(g);
    end
    
    w1 = N1/numPix;
    w2 = N2/numPix;
    
    g1medio = calcula_valor_medio_region_histograma(h,1,T);
    g2medio = calcula_valor_medio_region_histograma(h,T+1,256);
    
    var = w1*((g1medio-gmedio)^2) + w2*((g2medio-gmedio)^2);
    
end