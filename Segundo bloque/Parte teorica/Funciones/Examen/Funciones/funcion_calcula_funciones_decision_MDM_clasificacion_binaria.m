function [d1_mCov_de_cada_clase,d2_mCov_de_cada_clase,d12,coeficientes_d12] = funcion_calcula_funciones_decision_MDM_clasificacion_binaria(X,Y)
    
    datos = X; %Vamos a dejar la X para la notación del vector de atributos genérico
    
    valoresClases = unique(Y); % Posibles Clases
    numClases = length(valoresClases); % Numero de clases
    [numDatos, numAtributos] = size(X); % Numero de muestras y numero de atributos
    
    % Especificamos x1, x2 y si hace falta x3 como simbolicas para poder
    % crear una funcion que evaluar y las metemos en la matriz X
    x1 = sym('x1','real');
    x2 = sym('x2','real');
    X = [x1;x2];
    if numAtributos == 3
        x3 = sym('x3','real');
        X = [X;x3];
    end
    
    
    % Calculo de las medias y las covarianzas por clases
    M = zeros(numClases,numAtributos); % Matriz de medias
    mCov = zeros(numAtributos,numAtributos,numClases); % Matriz de covarianzas
    for i=1:numClases % Repasamos todas las clases
        FoI = Y == valoresClases(i); % Seleccionamos las muestras de la calse en evaluación
        XClase = datos(FoI,:); % Extraemos los datos de la clase en evaluacion
        M(i,:) = mean(XClase); % Calculamos la media de la clase
        mCov(:,:,i) = cov(XClase,1); % Calculamos la matriz de covarianzas de la clase
    end
    
    % Sacamos aparte las matrices de covarianzas
    mCov1 = mCov(:,:,1);
    mCov2 = mCov(:,:,2);
    
    % Calculamos la matriz de covarianza conjunta
    numDatosClase1 = sum(Y==valoresClases(1)); % Matriz de covarianza de la primera clase
    numDatosClase2 = sum(Y==valoresClases(2)); % Matriz de covarianzade la segunda clase
    mCov = (numDatosClase1*mCov1 + numDatosClase2*mCov2) / (numDatosClase1 + numDatosClase2); % Matriz de covarianza conjunta 
    
    % Calculo de la funciones de decision de cada clase: menos distancia
    % Euclidea por la inversa de la matriz de covarianzas de cada clase
    M1 = M(1,:)';
    d1_mCov_de_cada_clase = expand(-(X-M1)'*pinv(mCov1)*(X-M1));
    
    M2 = M(2,:)';
    d2_mCov_de_cada_clase = expand(-(X-M2)'*pinv(mCov2)*(X-M2));
    
    % Calculo de la funcion lineal: primero se calcula con el mismo metodo
    % que el anterior las funciones cuadraticas, pero esta vez con la
    % matriz de covarianzas conjunta
    d1_mCov_comun = expand(-(X-M1)'*pinv(mCov)*(X-M1));
    d2_mCov_comun = expand(-(X-M2)'*pinv(mCov)*(X-M2));
    
    % Y se resta para obtener la función lineal
    d12 = d1_mCov_comun-d2_mCov_comun; % forma lineal
    
    
    % Calculo de Coeficientes
    if numAtributos == 2
        % Si dimension 2: d12 = A*x1+B*x2+C - forma lineal
        x1=0;x2=0;C = eval(d12); % Sacamos C
        x1=1;x2=0;A = eval(d12)-C; % Sacamos A
        x1=0;x2=1;B = eval(d12)-C; % Sacamos B
        
        coeficientes_d12 = [A B C];
    else
        % SI dimension 3: d12 = A*x1+B*x2+C*x3+D
        x1=0;x2=0;x3=0;D = eval(d12); % Sacamos D
        x1=1;x2=0;x3=0;A = eval(d12)-D; % Sacamos A
        x1=0;x2=1;x3=0;B = eval(d12)-D; % Sacamos B
        x1=0;x2=0;x3=1;C = eval(d12)-D; % Sacamos C
        
        coeficientes_d12 = [A B C D];
    end
    
end