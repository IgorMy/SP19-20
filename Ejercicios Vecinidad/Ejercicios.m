% find(xondiciones) devuelve las posiciones donde se cumpla la condicion (devuelve un columna con las posiciones)

% 1

A = rand(5);

% 2

fila = 3;
columna = 4;

B = A(fila-1:fila+1,columna-1:columna+1)

% 3 

C = [A(fila-1,columna),A(fila+1,columna),A(fila,columna-1:2:columna+1)];

% 4

D = [A(fila-1,columna-1:columna+1)];

% 5

D = [D,A(fila,columna-1:2:columna+1)];

% 6

E = times(A,round(A)); 

% E = A.*round(A)
% E = A;
% E(A<0.5) = 0

% 7

media = (sum(sum(times(minus(A >= 0.2,A > 0.7),A)))) / (sum(sum(minus(A >= 0.2,A > 0.7))));

% 8

A = rand(5);
B = rand(5);
media = sum(sum(times((B > 0.5),A)))/(sum(sum(B>0.5)));

%9

A = rand(11);
B = zeros(11);
B(1:11,6) = 1;
B(6,1:11) = 1;
color = [255,0,0];
imagenes(A,B,color);


