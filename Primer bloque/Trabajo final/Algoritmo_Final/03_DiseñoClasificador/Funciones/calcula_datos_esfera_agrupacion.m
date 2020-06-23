function datosEsfera = calcula_datos_esfera_agrupacion(Xcolor_agrupacion,X,Y)
    X = double(X);
    valoresY = unique(Y);
    FoI = Y == valoresY(2);
    Xclase = X(FoI,:);
    Xcolor = Xclase(Xcolor_agrupacion,:);
    
    valoresMedios = mean(Xcolor);
    Rc = valoresMedios(1);
    Gc = valoresMedios(2);
    Bc = valoresMedios(3);
    
    A = X';
    B = repmat([Rc;Gc;Bc;],1,length(X'));
    
    
    distanciasX = sqrt(sum((A-B).^2));
    Xcolor = distanciasX(FoI);
    xbuf = Xcolor(Xcolor_agrupacion);
    r1 = max(xbuf);
    
    FoI = Y == valoresY(1);
    Xcolor = distanciasX(FoI);
    r2 = min(Xcolor)-1; % -1 para eliminar ese punto
    
    r12 = (r1+r2)/2;
    
    datosEsfera = [Rc Gc Bc r1 r2 r12];
    
end