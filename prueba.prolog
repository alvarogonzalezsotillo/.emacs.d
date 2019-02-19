

:- use_module(library(clpfd)).

coordenadas_desde_orden([X,Y,Z],O) :-
    O < 27,
    X is O//9,
    Y is (O-X*9)//3,
    Z is O mod 3.


aplica_a_todos(F,[E|L]) :-
    call(F,E),
    aplica_a_todos(F,L).

aplica_a_todos(_,[]) :-
    true.

%aplica_a_todos(F,L) :-   maplist(F,L).

%% distintos(A,B) :-
%%     A \= B.

%% todos_distintos([]) :-
%%     true.
%% todos_distintos([_]) :-
%%     true.

%% todos_distintos([A|L]) :-
%%     todos_distintos(L),
%%     aplica_a_todos(distintos(A),L).

todos_distintos(A) :- all_distinct(A).


color(C) :-
    C in 0..9.

coordenada(X) :-
    X in 0..2 .

coordenadas([X,Y,Z]) :-
    aplica_a_todos(coordenada,[X,Y,Z]).

celda([XYZ,C]) :-
    color(C),
    coordenadas(XYZ).              

coordenadas_de_celda(C,XYZ) :-
    [XYZ,_] = C.

color_de_celda(CELDA,COLOR) :-
    [_,COLOR] = CELDA.


colores_de_celdas(CELDAS,COLORES) :-
    maplist(color_de_celda,CELDAS,COLORES).

colores_de_celdas_distintos(CELDAS) :-
    colores_de_celdas(CELDAS,COLORES),
    todos_distintos(COLORES).

secuencia(MIN,MAX,L) :-
    MIN #< MAX,
    M is MIN+1,
    L = [MIN|LL],
    secuencia(M,MAX,LL).

secuencia(A,A,L) :-
    L = [A].

cubo(L) :-
    secuencia(0,26,SEQ),
    include(dif(12), SEQ, SEQSINCENTRO),
    maplist(coordenadas_desde_orden,COORS,SEQSINCENTRO),
    maplist(coordenadas_de_celda,L,COORS),
    aplica_a_todos(celda,L).


coordenadas_de_celdaZ(Z,C) :-
    coordenadas_de_celda(C,[_,_,Z]).


coordenadas_de_celdaX(X,C) :-
    coordenadas_de_celda(C,[X,_,_]).



coordenadas_de_celdaY(Y,C) :-
    coordenadas_de_celda(C,[_,Y,_]).





caraXY(CUBO,Z,CARA) :-
    include(coordenadas_de_celdaZ(Z),CUBO,CARA).


caraXZ(CUBO,Y,CARA) :-
    include(coordenadas_de_celdaY(Y),CUBO,CARA).


caraYZ(CUBO,X,CARA) :-
    include(coordenadas_de_celdaX(X),CUBO,CARA).


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

    
contar([E|L],PATRON,X) :-
    E == PATRON,
    contar(L,PATRON,X1),
    X is X1+1.

contar([E|L],PATRON,X) :-
    not(E == patron),
    contar(L,PATRON,X).

contar([],_,0).

esquina(CELDA) :-
    coordenadas_de_celda(CELDA,[X,Y,Z]),
    contar([X,Y,Z],1,0).

esquinas(CUBO,ESQUINAS) :-
    include(esquina,CUBO,ESQUINAS).

arista(CELDA) :-
    coordenadas_de_celda(CELDA,[X,Y,Z]),
    contar([X,Y,Z],1,1).
         
aristas(CUBO,ARISTAS) :-
    include(arista,CUBO,ARISTAS).



instancia_valores(L) :-
    label(L).

%% | color    | vértices | aristas | indice |
%% |----------+----------+---------+--------|
%% | blanco   |        1 |       1 |0
%% | azul     |        1 |       1 |1
%% | rosa     |        0 |       3 |2
%% | morado   |        1 |       1 |3
%% | amarillo |        1 |       1 |4
%% | negro    |        1 |       1 |5
%% | rojo     |        0 |       3 |6
%% | naranja  |        1 |       1 |7
%% | verde    |        2 |       2 |8

%% |          | azul   |         |
%% | amarillo | negro  | naranja |
%% |          | morado |         |
%% |          | blanco |         |

restricciones_color_blanco(CUBO,COLORESARISTAS,COLORESESQUINAS,X) :-
    aristas(CUBO,ARISTAS),
    colores_de_celdas(ARISTAS,COLORESARISTAS),
    contar(COLORESARISTAS,1,X),
    esquinas(CUBO,ESQUINAS),
    colores_de_celdas(ESQUINAS,COLORESESQUINAS).
    %contar(COLORESESQUINAS,0,1).

% PRUEBAS
?- not(todos_distintos([1,2,3,1])).
?- coordenadas_desde_orden([1,1,1],13).
?- contar([3,8,4,8,3,8,9],3,2).
?- coordenadas([0,0,0]).
?- cubo(CUBO), restricciones_caras_de_cubo(CUBO), aristas(CUBO,ARISTAS),colores_de_celdas(CUBO,COLORES), colores_de_celdas(ARISTAS,COLORESARISTAS), label(COLORES), contar(COLORESARISTAS,0,X), X #> 0.
