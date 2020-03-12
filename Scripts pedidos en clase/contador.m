function valor=contador(X)
valor = 0;
[filas co comp] = size(X);
for i=1:filas
    for j=1:co
        if X(i,j) <= 100
           valor=valor+1;
        end
    end
end

% sum(sum(I < 100))
% sum(I(:)<100)

end