function YTest = funcion_knn (XTest, XTrain, YTrain, k, Distancia)
    
    % Recogemos los datos de interes de la muestra de entrenamiento
    valoresClases = unique(YTrain);
    numClases = length(valoresClases);
    [numDatos, numAtributos] = size(XTrain);
    
    % Comprobamos el tipo distancia
    if Distancia == "Euclidea"
        
        % 1.-CALCULO DEL VECTOR DISTANCIAS ENTRE LA INSTANCIA DE TEST Y TODAS LAS% INSTANCIAS DE TRAIN
        A = XTrain';
        B = repmat(XTest',1,length(XTrain'));
        distancia = sqrt(sum((A-B).^2));
        
    else
    
        % Calculamos la matriz de covarianzas de cada clase
        mCov = zeros(numAtributos,numAtributos,numClases);
        for i=1:numClases
            FoI = YTrain == valoresClases(i);
            XClase = XTrain(FoI,:);
            mCov(:,:,i) = cov(XClase,1);
        end
    
        % 1.-CALCULO DEL VECTOR DISTANCIAS ENTRE LA INSTANCIA DE TEST Y TODAS LAS% INSTANCIAS DE TRAIN
        distancia = [];
        for i=1:numDatos
            mCovClase = mCov(:,:,YTrain(i));
            X1 = XTrain(i,:);
            X2 = XTest;
            distancia_calculada = (X1-X2)*pinv(mCovClase)*(X1-X2)';
            distancia = [distancia distancia_calculada];
        end
    
    end
    
    % 2.-LOCALIZAR LAS k INSTANCIAS DE XTrain MAS CERCANAS A LA INSTANCIA DE% TEST BAJO CONSIDERACIÓN
    [~,indices] = sort(distancia);
    k_indices_mas_cercanos = indices(1:k);
    
    % 3.-CREAR UN VECTOR CON LAS CODIFICACIONES DE LAS CLASES DE ESAS% k-INSTANCIAS MÁS CERCANAS
    clasif = zeros(max(YTrain),1);
    for i=1:k
        clasif(YTrain(k_indices_mas_cercanos(i))) = clasif(YTrain(k_indices_mas_cercanos(i))) + 1;
    end
    
    %% Extraemos el valor
    
    [~, YTest] = max(clasif);
    
end