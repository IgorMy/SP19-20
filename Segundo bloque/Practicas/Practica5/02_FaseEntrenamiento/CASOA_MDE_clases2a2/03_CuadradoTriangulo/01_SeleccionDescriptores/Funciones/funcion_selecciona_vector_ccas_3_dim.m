function [espacioCcas, JespacioCcas]=funcion_selecciona_vector_ccas_3_dim(X,Y,numDescriptoresOI)

    % Sacamos los datos de interes
    
        [~, numDescriptores] = size(X);

    % 1. Ranking de caracteristicas
        outputs = Y';
        valoresJ = zeros(1,numDescriptores);
        for j=1:numDescriptores
            inputs = X(:,j)';
            valoresJ(1,j) = indiceJ(inputs,outputs);
        end
        [~,indices] = sort (valoresJ,'descend');

    % 2. Preseleccion de caracteristicas
        mejoresDInd = indices(1:numDescriptoresOI);        
        
    % 3. Seleccionamos la mejor combinatoria
    
        comb = combnk(mejoresDInd,3);
        numComb = size(comb,1);

        outputs = Y';
        valoresJ = zeros(numComb,1);
        for i=1:numComb
            inputs = X(:,comb(i,:))';
            valoresJ(i) = indiceJ(inputs,outputs);
        end
        [valoresJord,indices] = sort (valoresJ,'descend');

        espacioCcas = comb(indices(1),:);
        JespacioCcas = valoresJord(1);
        
end