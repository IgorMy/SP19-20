function funcion_representacion_clasificacion_binaria_con_frontera(X,Y,coeficientes_d12,nombresProblema)

    funcion_representa_muestras_clasificacion_binaria(X,Y,nombresProblema)
    if nargin == 4 
        hold on
        if size(X,2) == 2
            x1min = min(X(:,1));x1max = max(X(:,1));
            x2min = min(X(:,2));x2max = max(X(:,2));
            axis([x1min x1max x2min x2max]);

            A = coeficientes_d12(1); B = coeficientes_d12(2)+eps; C= coeficientes_d12(3);
            x1Recta = x1min:0.01:x1max;
            x2Recta = -(A*x1Recta+C)/(B+eps); % A*x1+B*x2+C = 0;
            plot(x1Recta,x2Recta,'k');
        else
            x1min = min(X(:,1));x1max = max(X(:,1));
            x2min = min(X(:,2));x2max = max(X(:,2));
            x3min = min(X(:,3));x3max = max(X(:,3));
            axis([x1min x1max x2min x2max x3min x3max]);

            A = coeficientes_d12(1); B = coeficientes_d12(2); C= coeficientes_d12(3);D = coeficientes_d12(4);

            Xmin = min(X(:));
            Xmax = max(X(:));
            paso = (Xmax-Xmin)/100;
            [x1Plano, x2Plano] = meshgrid(Xmin:paso:Xmax);
            x3Plano = -(A*x1Plano + B*x2Plano + D) / (C+eps);
            surf(x1Plano,x2Plano,x3Plano);
        end
        hold off
        problema = [];
        for i=1:size(unique(Y),1)
            problema{i} = nombresProblema.clases{i};
        end
        problema{i + 1} = 'Frontera';
        legend(problema{:});
    else
        legend(nombresProblema.clases{unique(Y)});
    end
end

function funcion_representa_muestras_clasificacion_binaria(X,Y,nombresProblema)
    
    valoresClases = unique(Y);
    numClases = length(valoresClases);
    [~, numAtributos] = size(X);
    
    %% Representacion de los datos

    hold on
    
    if numAtributos == 2
        
        for i=1:numClases
            FoI = Y == valoresClases(i);
            x1 = X(FoI,1);
            x2 = X(FoI,2);
            plot(x1,x2,nombresProblema.simbolos{i});
        end
        
        xlabel(nombresProblema.descriptores{1}), ylabel(nombresProblema.descriptores{2})
        grid on
     
    else
        for i=1:numClases
            FoI = Y == valoresClases(i);
            x1 = X(FoI,1);
            x2 = X(FoI,2);
            x3 = X(FoI,3);
            plot3(x1,x2,x3,nombresProblema.simbolos{i});
        end
        
        xlabel(nombresProblema.descriptores{1}), ylabel(nombresProblema.descriptores{2}), zlabel(nombresProblema.descriptores{3})
        grid on
    end
    
    hold off
end