

:- use_module(library(clpfd)).


% Algunas funciones de librería, renombradas para recordarlas
aplica_a_todos(F,L) :-  maplist(F,L).
mapea_lista(F,LISTA,LISTAF) :- maplist(F,LISTA,LISTAF).
todos_distintos(A) :- all_distinct(A).
filtra_lista(CONDICION,LISTA,LISTAFILTRADA) :- include(CONDICION,LISTA,LISTAFILTRADA).
instancia_valores(L) :-  label(L).


% Definición de color y coordenada tridimensional, para construir celdas
color(C) :-
    C in 0..8.

coordenada(X) :-
    X in 0..2 .

coordenadas([X,Y,Z]) :-
    aplica_a_todos(coordenada,[X,Y,Z]).

celda([XYZ,C]) :-
    color(C),
    coordenadas(XYZ).

% Utilizo estas reglas como extractores de datos de una celda
coordenadas_de_celda(C,XYZ) :-
    [XYZ,_] = C.

color_de_celda(CELDA,COLOR) :-
    [_,COLOR] = CELDA.


colores_de_celdas(CELDAS,COLORES) :-
    mapea_lista(color_de_celda,CELDAS,COLORES).


% Para construir las 26 celdas utilizo una secuencia 0..26 y las asigno a cada "cubito" del molecube
secuencia(MIN,MAX,L) :-
    MIN #< MAX,
    M is MIN+1,
    L = [MIN|LL],
    secuencia(M,MAX,LL).

secuencia(A,A,L) :-
    L = [A].

coordenadas_desde_orden(ORDEN,[X,Y,Z]) :-
    ORDEN < 27,
    X is ORDEN//9,
    Y is (ORDEN-X*9)//3,
    Z is ORDEN mod 3.



% Un cubo se construye con 26 "cubitos", quitando el cubo interior. Las coordenadas van desde [0,0,0] hasta [2,2,2], saltando la [1,1,1].
cubo(L) :-
    secuencia(0,26,SEQ),
    filtra_lista(dif(13), SEQ, SEQSINCENTRO),
    mapea_lista(coordenadas_desde_orden,SEQSINCENTRO,COORS),
    mapea_lista(coordenadas_de_celda,L,COORS),
    aplica_a_todos(celda,L).



% Extractores para las caras del cubo (secciones con igual X, Y o Z)

coordenadas_de_celdaZ(Z,C) :-
    coordenadas_de_celda(C,[_,_,Z]).

caraXY(CUBO,Z,CARA) :-
    filtra_lista(coordenadas_de_celdaZ(Z),CUBO,CARA).


coordenadas_de_celdaY(Y,C) :-
    coordenadas_de_celda(C,[_,Y,_]).

caraXZ(CUBO,Y,CARA) :-
    filtra_lista(coordenadas_de_celdaY(Y),CUBO,CARA).


coordenadas_de_celdaX(X,C) :-
    coordenadas_de_celda(C,[X,_,_]).


caraYZ(CUBO,X,CARA) :-
    filtra_lista(coordenadas_de_celdaX(X),CUBO,CARA).


% En una cara, todos los colores deben ser distintos
colores_de_celdas_distintos(CELDAS) :-
    colores_de_celdas(CELDAS,COLORES),
    todos_distintos(COLORES).

restricciones_caras_de_cubo(CUBO) :-
    caraXY(CUBO,0,CARAXY0),
    colores_de_celdas_distintos(CARAXY0),
    caraXY(CUBO,2,CARAXY2),
    colores_de_celdas_distintos(CARAXY2),

    caraXZ(CUBO,0,CARAXZ0),
    colores_de_celdas_distintos(CARAXZ0),
    caraXZ(CUBO,2,CARAXZ2),
    colores_de_celdas_distintos(CARAXZ2),

    caraYZ(CUBO,0,CARAYZ0),
    colores_de_celdas_distintos(CARAYZ0),
    caraYZ(CUBO,2,CARAYZ2),
    colores_de_celdas_distintos(CARAYZ2).


% Esta regla cuenta el número de ocurrencias (X) del patron P en la lista pasada como primer argumento
contar([EE|L],P,X) :-
    dif(EE, P),
    contar(L,P,X).

contar([E|L],P,X) :-
   E = P,
   contar(L,P,X1),
   X is X1+1.

contar([],_,0).

% Extractor de esquinas de un cubo. Una esquina no tiene ninguna coordenada a 1
es_esquina(CELDA) :-
    coordenadas_de_celda(CELDA,[X,Y,Z]),
    contar([X,Y,Z],1,0).

esquinas(CUBO,ESQUINAS) :-
    filtra_lista(es_esquina,CUBO,ESQUINAS).

% Extractor de aristas. Una arista tiene una coordenada a 1.
es_arista(CELDA) :-
    coordenadas_de_celda(CELDA,[X,Y,Z]),
    contar([X,Y,Z],1,1).
         
aristas(CUBO,ARISTAS) :-
    filtra_lista(es_arista,CUBO,ARISTAS).


%% | color       | vértices | aristas | indice |
%% | blanco      |        1 |       1 |       0 |
%% | azul        |        1 |       1 |       1 |
%% | rosa        |        0 |       3 |       2 |
%% | azul oscuro |        1 |       1 |       3 |
%% | amarillo    |        1 |       1 |       4 |
%% | negro       |        1 |       1 |       5 |
%% | rojo        |        0 |       3 |       6 |
%% | naranja     |        1 |       1 |       7 |
%% | verde       |        2 |       2 |       8 |

%% | x=0, y=1 | x=1    | x=2,y=1 |              |
%% |          | azul   |         | z = 2, y=1   |
%% | amarillo | negro  | naranja | z = 1        |
%% |          | azul o.|         | z = 0, y = 1 |
%% |          | blanco |         | z = 1, y =2  |


% Limitación de colores. Por ejemplo, de blanco (color 0) hay una arista y una esquina
limita_esquinas_y_aristas(CUBO,COLOR,E,A) :-
    aristas(CUBO,ARISTAS),
    colores_de_celdas(ARISTAS,CA),
    contar(CA,COLOR,A),
    esquinas(CUBO,ESQUINAS),
    colores_de_celdas(ESQUINAS,CE),
    contar(CE,COLOR,E).
    
restricciones_esquinas_aristas(CUBO) :-
    limita_esquinas_y_aristas(CUBO,0,1,1),
    limita_esquinas_y_aristas(CUBO,1,1,1),
    limita_esquinas_y_aristas(CUBO,2,0,3),
    limita_esquinas_y_aristas(CUBO,3,1,1),
    limita_esquinas_y_aristas(CUBO,4,1,1),
    limita_esquinas_y_aristas(CUBO,5,1,1),
    limita_esquinas_y_aristas(CUBO,6,0,3),
    limita_esquinas_y_aristas(CUBO,7,1,1),
    limita_esquinas_y_aristas(CUBO,8,2,0).
   

% Extractor de una celda y su color dadas sus coordenadas
celda_desde_coordenadas(CUBO,COORDENADAS,CELDA) :-
    filtra_lista(=([COORDENADAS,_]),CUBO,[CELDA]).

color_en_coordenadas(CUBO,COORDENADAS,COLOR) :-
    celda_desde_coordenadas(CUBO,COORDENADAS,CELDA),
    CELDA = [_,COLOR].

% Los centros de las caras nunca se mueven, así que sus colores son fijos.
restriciones_colores_centrales_de_caras(CUBO) :-
    % Los centros de las caras tienen dos coordenadas a 1
    color_en_coordenadas(CUBO,[0,1,1], 4),
    color_en_coordenadas(CUBO,[1,1,2], 1),
    color_en_coordenadas(CUBO,[1,0,1], 5),
    color_en_coordenadas(CUBO,[1,1,0], 3),
    color_en_coordenadas(CUBO,[1,2,1], 0),
    color_en_coordenadas(CUBO,[2,1,1], 7).


% Un cubo con restricciones es un cubo con los colores centrales de las caras asignados y limitaciones en caras, vértices y aristas.
cubo_con_restricciones(CUBO) :-
    cubo(CUBO),
    restricciones_caras_de_cubo(CUBO),
    restriciones_colores_centrales_de_caras(CUBO),
    restricciones_esquinas_aristas(CUBO).



color_a_nombre(0, white).
color_a_nombre(1, blue).
color_a_nombre(2, mediumvioletred ). %pink
color_a_nombre(3, navy). %darkblue
color_a_nombre(4, yellow).
color_a_nombre(5, black).
color_a_nombre(6, red).
color_a_nombre(7, orangered).
color_a_nombre(8, green).

imprime_celda(CELDA) :-
    [[X,Y,Z],C] = CELDA,
    color_a_nombre(C,N),
    format("
      <transform translation='~d ~d ~d'>    
        <shape>
          <appearance>
            <material diffuseColor='~a'>
            </material>
          </appearance>
          <sphere></sphere>
        </shape>
      </transform>
    ", [(X-1)*2,(Y-1)*2,(Z-1)*2,N]).

imprime_solucion(CUBO) :-
    write("
	 <x3d height='500px' style='border:none; display:block; width:100%'> 
	   <scene>
    "),
    aplica_a_todos(imprime_celda,CUBO),
    write("
           </scene>
         </x3d> 
    ").

% PRUEBAS
?- not(todos_distintos([1,2,3,1])).
?- coordenadas_desde_orden(13,[1,1,1]).
?- contar([3,8,4,8,3,8,9],3,2).
?- coordenadas([0,0,0]).
?- findall(CUBO, cubo_con_restricciones(CUBO),SOLUCIONES),
   aplica_a_todos(imprime_solucion,SOLUCIONES),
   length(SOLUCIONES,X),
   format("Número de soluciones:~d",X).
