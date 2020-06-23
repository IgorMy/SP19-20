function Ximagen = funcion_calcula_descriptores_extent_hu_imagen(Ietiq,N)
    
    stats = regionprops(Ietiq,'Extent');
    
    ExtentImagen = cat(1,stats.Extent);
    HuImagen = funcion_calcula_hu_objetos_imagen(Ietiq,N);
    Ximagen = [ExtentImagen HuImagen];

end