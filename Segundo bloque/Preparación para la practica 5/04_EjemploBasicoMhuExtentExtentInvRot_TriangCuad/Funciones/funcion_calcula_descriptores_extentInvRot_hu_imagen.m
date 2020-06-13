function Ximagen = funcion_calcula_descriptores_extentInvRot_hu_imagen(Ietiq,N)
    
    stats = regionprops(Ietiq,'Extent');
    
    ExtentImagen = cat(1,stats.Extent);
    HuImagen = funcion_calcula_ExtentIR_Hu_objetos_imagen(Ietiq,N);
    Ximagen = [ExtentImagen HuImagen];

end