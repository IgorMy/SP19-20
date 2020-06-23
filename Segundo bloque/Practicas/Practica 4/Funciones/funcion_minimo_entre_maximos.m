function minimo = funcion_minimo_entre_maximos(max1,max2,numPixMax,h)
    % aumentamos los valores a maximo posible a los lados de los maximos
    % dependiendo de cual sea el primero se establece a su derecha todo los
    % pixeles a la izquierda del otro igual
    if(max1<max2)
        h(1:max1) = numPixMax;
        h(max2:256) = numPixMax;
        gmax1 = max1 - 1;
        gmax2 = max2 - 1;
    else
        h(1:max2) = numPixMax;
        h(max1:256) = numPixMax;
        gmax1 = max2 - 1;
        gmax2 = max1 - 1;
    end
    
    % Ahora simplemente cogemos el minimo
    [~,minimo] = min(h);
    minimo = minimo - 1;
end