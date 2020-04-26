function representa_datos_fondo(X,Y)
    valoresY = unique(Y);
    FoI = Y == valoresY(1); % Filas de la clase de interes - color de fondo
    Xfondo = X(FoI,:);
    
    plot3(Xfondo(:,1),Xfondo(:,2),Xfondo(:,3),'.r');
    xlabel("Componente Roja"),ylabel("Componente Verde"),zlabel("Componente Azul");
    ValorMin = 0;
    ValorMax = 255;
    axis([ValorMin ValorMax ValorMin ValorMax ValorMin ValorMax]);
    legend("Datos Fondo");
end