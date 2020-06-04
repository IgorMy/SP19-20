function [precision clasificacion] =  funcion_evalua_precision_clasificador(X,Y,d1,d2,d12)

    precision = zeros(1,2);
    valoresClases = unique(Y);
    Y_clasificador1 = zeros(size(Y));
    Y_clasificador2 = zeros(size(Y));
    clasificacion = zeros(size(Y,1),2);
    
    if size(X,2) == 2
        for i=1:size(X,1)

            XoI = X(i,:);
            x1 = XoI(1);
            x2 = XoI(2);

            valor_d1 = eval(d1);
            valor_d2 = eval(d2);
            valor_d12 = eval(d12);

            if valor_d1 > valor_d2
                Y_clasificador1(i) = valoresClases(1);
            else
                Y_clasificador1(i) = valoresClases(2);
            end

            if valor_d12 > 0
                Y_clasificador2(i) = valoresClases(1);
            else
                Y_clasificador2(i) = valoresClases(2);
            end

        end
    else 
        for i=1:size(X,1)

            XoI = X(i,:);
            x1 = XoI(1);
            x2 = XoI(2);
            x3 = XoI(3);

            valor_d1 = eval(d1);
            valor_d2 = eval(d2);
            valor_d12 = eval(d12);

            if valor_d1 > valor_d2
                Y_clasificador1(i) = valoresClases(1);
            else
                Y_clasificador1(i) = valoresClases(2);
            end

            if valor_d12 > 0
                Y_clasificador2(i) = valoresClases(1);
            else
                Y_clasificador2(i) = valoresClases(2);
            end

        end
    end
    
    Y_modelo = Y_clasificador1;
    error = Y_modelo - Y;
    num_aciertos = sum(error==0);
    precision(1,1) = num_aciertos/size(X,1);
    disp(['Precision usando las funciones cuadraticas: ',num2str(precision(1,1)*100),'%']);


    Y_modelo = Y_clasificador2;
    error = Y_modelo - Y;
    num_aciertos = sum(error==0);
    precision(1,2) = num_aciertos/size(X,1);
    disp(['Precision usando la funcion lineal: ',num2str(precision(1,2)*100),'%']);
    clasificacion(:,1) = Y_clasificador1;
    clasificacion(:,2) = Y_clasificador2;
end