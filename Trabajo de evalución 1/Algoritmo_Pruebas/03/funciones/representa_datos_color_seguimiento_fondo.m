function representa_datos_color_seguimiento_fondo(X,Y)
    
    valoresY = unique(Y);
    numClases = length(valoresY);
    colores = [".b",".r"];
    
    figure,hold on;
    
    for i=1:numClases
    
        filas = Y == valoresY(i);
        ValoresR = X(filas,1);
        ValoresG = X(filas,2);
        ValoresB = X(filas,3);
        
        plot3(ValoresR,ValoresG,ValoresB,colores(i));
        
    end
    
    xlabel("Componente Roja"),ylabel("Componente Verde"),zlabel("Componente Azul");
    ValorMin = 0;
    ValorMax = 255;
    axis([ValorMin ValorMax ValorMin ValorMax ValorMin ValorMax]);
    legend("Datos Fondo","Datos Color");
    
end