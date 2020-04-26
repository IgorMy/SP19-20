function datosEsfera = calcula_datos_esfera(X,Y)
    X = double(X);
    valoresY = unique(Y);
    FoI = Y == valoresY(2);
    Xclase = X(FoI,:);
    valoresMedios = mean(Xclase);
    Rc = valoresMedios(1);
    Gc = valoresMedios(2);
    Bc = valoresMedios(3);
    
    A = X';
    B = repmat([Rc;Gc;Bc;],1,length(X'));
    
    
    distanciasX = sqrt(sum((A-B).^2));
    Xclase = distanciasX(FoI);
    r1 = max(Xclase);
    
    FoI = Y == valoresY(1);
    Xclase = distanciasX(FoI);
    r2 = min(Xclase)-1; % -1 para eliminar ese punto
    
    r12 = (r1+r2)/2;
    
    datosEsfera = [Rc Gc Bc r1 r2 r12];
    
end