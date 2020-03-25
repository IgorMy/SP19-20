TUTORIAL MATLAB

%% ORGANIZACION: CURRENT DIRECTORY, COMMAND WINDOW, WORKSPACE, COMMAND
% HISTORY

% Ejemplo Suma y resta de dos numeros
a =1  
A = 2
suma = a+A, resta = a-A; % Realiza la suma y la resta

% OBSERVACIONES:
% el car�cter �,� para separar comandos
% el s�mbolo �%� para introducir comentarios en el c�digo
% % si no ponemos �;� el resultado se muestra en pantalla


%% Workspace
whos A  % para ver el tipo de variable
% double ; real de punto flotante con 8 bytes
% empleado por Matlab por defecto en la definici�n de variables

save variables A a suma resta  
% Guarda las variables en fichero matlab variables.mat

clear  % elimina las variables del workspace

load variables.mat  
% carga en el Workspace las variables almacenadas en el fichero .mat

clc % borra pantalla del command window.
% Ver ayuda matlab para todas las posibilidades


%% Ayuda matlab
help save  % te ofrece ayuda respecto la funci�n  por el command window
doc load % abre la ayuda Matlab para dar la informaci�n
type imfilter % edita el contenido de la funci�n por command window
edit imfilter % abre fichero .m con la funci�n


%% DEFINICI�N DE MATRICES
a = 1
whos a

% []: Para concatenar informacion
% Definici�n con corchetes 
% Los corchetes se usan para concatenar informacion
% Si la informaci�n va separada por espacios o comas, se a�ade horizontalmente
% Si va seperada por "puntos y coma" se a�ade verticalmente

b = [2 2], whos b
b = [2; 2], whos b
b = [2, 2]

c = [a b 3] 
whos c

d = [2; 2]
whos d

e = [a; d]
whos e

f = [e; d; 3]
whos f

% Operador Transpononer
cTras = c';

% Definicion de matrices
g = [1 2 3; 4 5 6]
whos g

% A�ade a g una �ltima columana con valores 7 y 8


h = [g [7;8]]

% A�ade a h una �ltima fila con los valores del vector c


i = [h; c]
whos i

% Operador : para la definici�n de vectores filas con los valores indicados
ValorInicio = 1; ValorFinal = 6; Paso = 1;
A = ValorInicio:Paso:ValorFinal
A = 1:6

B = 1:2:5
C = 5:-1:1

% Inicializacion de matrices
A = []
B = ones(2)
C = ones(2,3)
D = zeros(3,1)

E = eye(4) % matriz identidad 4x4

F = rand(4,3) % matriz 4x3 de n�meros distribuci�n probabilidad uniforme entre 0-1

G = randn(100,1)  % vector columna de 100 elementos
% generados seg�n distribuci�n gaussiana de media cero y desviaci�n t�pica
% 1



%% ACCESO A LOS ELEMENTOS DE UNA MATRIZ: con par�ntesis
clear
a = [1 4 6 9 -1 ; 2 4 9 11 5 ; 1 3 5 7 2 ; 3 -2 4 7 2]
a11 = a(1,1)
a23 = a(2,3)
UltimoElementoSegundaFila = a(2,end)
UltimoElementoTerceraColumna = a(end,3)

% : hace referencia a todos los elementos (de una fila, de una columna, de
% una matriz)

SegundafilaCompleta = a(2,:);
UltimaColumnaCompleta = a(:,end)

% Para acceder a todos los elementos de una matriz y almacenarlos en un
% vector columna
b = a(:)


%% OPERACIONES CON ELEMENTOS Y MATRICES

clc, clear
A = [1 4 6 9 -1 ; 2 4 9 11 5 ; 1 3 5 7 2 ; 3 -2 4 7 2]

% Cuatro Primeros valores de la segunda fila
f = 2; k = 4; A(2,1:4)

% Intercambiar las dos primeras filas
A = A([1 3 2],:)

% Guardar en B, la segunda fila
B = A(2,:)

% Eliminar de A la segunda fila
A(2,:) = []

% A�adir el contenido de B a A
A = [A ; B]

% A�adir una nueva columna a A con valores 5.5, 10.5 y 15.5
B = [5.5; 10.5; 15.5];
A = [A B]


% Poner el contenido de las tres �ltimas columnas, deabajo de las tres primeras
A1 = A(:,1:3)
A2 = A(:,4:end)
A = [A1; A2]


% Sea a = [1 4 6 9 -1 ; 2 4 9 11 5 ; 1 3 5 7 2 ; 3 -2 4 7 2]
% Accede a los dos primeros elementos de la tercera columna

% Accede a al primer y tercer elemento de la segunda fila    

% Accede a los elementos 1, 2 y 4 de la �ltima fila      

% Accede a la matriz 3x3 centrada en el elemento de la fila 2, columna 3

% Elimina la segunda columna de a

% Intercambia segunda y tercera columna de a



%% OPERACIONES CON ELEMENTOS Y MATRICES

clear
a = [1 4 6 9 -1 ; 2 4 9 11 5 ; 1 3 5 7 2 ; 3 -2 4 7 2]
f = 2; c = 3
[a(1:3,2:4) a(f-1:f+1,c-1:c+1)] ; [a(1:3,2:4) ; a(f-1:f+1,c-1:c+1)] 

A = rand(2)
B = randn(2)

[A B] ; [A;B], C = [A B; A-1 B+1]

clear, clc
% Operaciones con constantes
A = 3*ones(3);
A = A+1
B = 2*eye(3);
C = A + B
D = C/2
D = (C/2)*3
D = A^2

% Operaciones entre matrices
A = [1 0 5]; B = [2 4 1];

A*B  % PRODUCTO MATRICIAL
A, B'
PMatric = A*B'  
PPunto_a_Punto = A.^B

% Ejemplos
A = [4 2; 8 4] ; B = [1 2; 4 2]; [A B]
P = A*B
P = A.*B % MULTIPLICACION ELEMENTO A ELEMENTO
A^2
A.^B

A+B, A-B, A*B, A.*B, A/B, A*inv(B), A./B, A^2 


%% TIPOS DE DATOS
% ? logical ; un bit
% ? int8 ; entero con signo de 8 bits
% ? int16 ; entero con signo de 16 bits
% ? int32 ; entero con signo de 32 bits
% ? int64 ; entero con signo de 64 bits
% ? uint8 ; entero sin signo de 8 bits
% ? uint16 ; entero sin signo de 16 bits
% ? uint32 ; entero sin signo de 32 bits
% ? uint64 ; entero sin signo de 64 bits
% ? single ; real de punto flotante con 4 bytes
% ? double ; real de punto flotante




%% DEFINICION DE VARIABLES TIPO CAR�CTER Y CADENAS DE TEXTO

A = 'Hola'
PrimerCaracter = A(1);

B = 'Como estas';

C = [A; B]

C = [A ; B(1: length(A))]

% Para crear variables tipo celdas {}
   
C = char([]);
C{1} = A;
C{2} = B;
C  % Crea la variable tipo celda en fila

% Si se quiere tener el contenido en columna
C = char([]);
C{1,1} = A;
C{2,1} = B;

% Acceso al contenido
C(1)  % Variable tipo celda con el contenido de la primera celda
C{1}  % Variable tipo car�cter con el contenido de la primera celda

%% DEFINICI�N VARIABLES TIPO ESTRUCTURAS
Campos = [];
Campos.opciones = [];
Campos.valores = [];
Campos.opciones{1} = 'Escalado';
Campos.opciones{2} = 'Normalizacion';
Campos.valores{1} = true;
Campos.valores{2} = [3 2];

Campo.opciones(1)  % tipo cell - as� se declar� opciones. Accede a la primer celda
Campo.opciones{1}  % tipo del contenido de la celda. Accede al contenido
Campos.valores(1)
Campos.valores{1}
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% EJEMPLO REPRESENTACIONES CON PLOT
figure
figure('Name', 'Esta es la Figura Numero 2')
figure(4), set(4, 'Name', 'Esta es la figura 4')

close all

% REPRESENTAR UN SENO ENTRE 0 Y 2PI

 x=0:pi/100:2*pi;
 y=sin(x);
 
 figure % crea una ventana gr�fica y es la actual
 plot(x,y); % dibuja gr�fico en ventana actual (y frente a x)
 
 xlabel('Grados en radii') % texto para el eje x
 ylabel('Seno') % texto para el eje y
 title ('Ejemplo') % texto para el t�tulo
 XMIN = 0; XMAX = 7; YMIN = -1.2; YMAX = 1.2;
 axis([XMIN XMAX YMIN YMAX])
 
 
 % REPRESENTAR EN EL MISMO GR�FICO DOS SENOS DESPLAZADOS DEL ANTERIOR
 
 y1=sin(x-0.25); % otra funci�n
 y2=sin(x-0.5); % otra funci�n
 hold on % mantiene la ventana anterior para que se dibuje en ella el pr�ximo gr�fico sin borrar dicha ventana
 plot(x,y1,'.r', x,y2,'g') % dos curvas
 legend('sen(x)','sen(x-0.25)','sen(x-0.5)') % leyendas
 grid on % para dibujar
 
 
 % EJEMPLO DE REPRESENTACI�N EN 3D
 x = -4*pi:0.1:4*pi;
 figure,
 plot3(sin(x),cos(x),x)
 
 
 %% FAMILIARIZARSE CON ALGUNAS FUNCIONES MATLAB GEN�RICAS
 
%  addpath  
%  ceil, floor, round
%  sum, max, min, mean, std, median
%  length, size
%  abs

% Ejercicio: Crea una matriz 2x3 y calcula la suma, valor maximo, mnimio, media, desviacion t�pica y mediana con las
% funciones matlab sum, max, min, mean, std, median

 
 % FAMILIARIZARE CON OPERADORES RELACIONALES, L�GICOS Y SENTENCIAS DE
 % CONTROL DE FLUJO
% eq - Equal = =
% ne - Not equal ~ =
% lt - Less than <
% gt - Greater than >
% le - Less than or equal < =
% ge - Greater than or equal > =
 
 % FAMILIARIZARE CON OPERADORES L�GICOS 
% and - Logical AND &
% or - Logical OR |
% not - Logical NOT ~
% xor - Logical EXCLUSIVE OR
% any - True if any element of vector is nonzero
% all - True if all elements of vector are nonzero


 % FAMILIARIZARE CON SENTENCIAS DE CONTROL DE FLUJO
% Sentencia if
% if <condici�n>
% <sentencia>
% elseif <condici�n>
% <sentencia>
% else <sentencia>
% end


% Sentencia switch
% switch <expresion>
% case 0 �
% case 1 �
% �
% otherwise �
% end



% Sentencia for
% for i = 1 : 2 :10
% �
% end



% Sentencia while
% while <condici�n>
% �
% end



% Sentencias continue y break
% Para modificar el flujo en bucles
% continue: para saltar al siguiente ciclo del bucle
% break: para salir del bucle
 


%% SCRIPTS Y FUNCIONES

% CREAR FUNCION SUMA DE TRES ELEMENTOS, TIPO UINT8, Y COMPROBAR SU
% FUNCIONAMIENTO. GUARDA LA FUNCION EN UN DIRECTORIO LLAMADO FuncAux, y
% a�ade el path de este directorio para llamarla

addpath('FuncAux')
A = funcion_suma(2,3,4)

A = funcion_suma(200,300,400)

%% Extras

% Mostrar imagen en un contenedor figure
figure,imshow(imagen);

% Otra forma de mostrar la imagen
imtool(imagen);

% Con imtool(I), obtenemos Pixel info: (141,200) 147
I(200,141)

% leer una imagen
imread("directorio de la imagen con el nombre de la imagen y su extension");

% Tamaño de una matriz / imagen
[nfilas,ncolumnas,ncapas] = size(imagen)

% Acceder a un dato especifico
nfilas = size(imagen,1);

% Cerrar todas las ventanas
close all;

% histograma
imhist(imagen);

% mantener el figure
hold on;

% Representacion histograma con stem
stem (0:255, num_pix, '.r'), hold on, imhist(I)

% datos de la imagen, devuelve una estructura
imfinfo("ruta de la imagen");

% numero aleatorio
rand()*numero_maximo;

% juntar matrices en capas
cat(numero_capas,capa1,capa2,...);

% guardar una imagen
imwrite(imagen,"ruta de la imagen");

% cambiar escala de grises
imadjust(imagen,numero);

% valores unicos
unique(imagen);

% separar los 1 conexos en numeros diferentes (función etiquetar)
[imagen_etiquetada numero_de_objetos] = bwlabel(imagen_binaria);

% devuelve una estructura con los centroides y las areas de los distintos
% objetos de la imagen
stats=regionprops(imagen_etiquetada,'Area','Centroid');

% Muestra los objetos igual o mayor de la imagen
bwareaopen(imagen_binaria, limite);

% Añadir direcotrio
addpath("directorio");

% timepo que tarda en ejecutarse una determinada instrucción
tic
% instruccion
toc

% encontrar algo en la imagen
find(matriz_logica)

% Función que devuelve una estructura con información del hardware de 
%adquisición de imágenes% disponible, incluyendo los adaptadores de video 
%instalados
datos=imaqhwinfo;

% Función que devuelve una estructura con información del dispositivo de 
% video instalado 
datos=imaqhwinfo('winvideo');