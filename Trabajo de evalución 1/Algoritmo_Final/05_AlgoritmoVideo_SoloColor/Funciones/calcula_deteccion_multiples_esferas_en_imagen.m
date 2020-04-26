function Ib = calcula_deteccion_multiples_esferas_en_imagen(I, centroides_radios)
    [c1,c2,~] = size(I);
    c4 = size(centroides_radios,1);
    
    R = double(I(:,:,1));
    G = double(I(:,:,2));
    B = double(I(:,:,3));
    
    Ib = false(c1,c2);
    
    for i=1:c4
        Rc = centroides_radios(i,1);
        Gc = centroides_radios(i,2);
        Bc = centroides_radios(i,3);
        MD = sqrt( (R-Rc).^2 + (G-Gc).^2 + (B-Bc).^2 );
        Ibb = MD <= centroides_radios(i,4);
        Ib = Ib | Ibb;
    end
    
end