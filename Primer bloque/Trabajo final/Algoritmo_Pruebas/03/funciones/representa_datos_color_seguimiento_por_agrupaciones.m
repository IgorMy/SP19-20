function representa_datos_color_seguimiento_por_agrupaciones(X,idx)
    tam = length(unique(idx));
    colores = [".b",".g",".y",".m"];
    for i=1:tam
        FoI = idx == i;
        Xcolor = X(FoI,:);
        plot3(Xcolor(:,1),Xcolor(:,2),Xcolor(:,3),colores(i));
    end
end