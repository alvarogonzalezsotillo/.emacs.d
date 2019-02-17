

:- use_module(library(clpfd)).

coordenadas_desde_orden([X,Y,Z],O) :-
    O < 27,
    X is O//9,
    Y is (O-X*9)//3,
    Z is O mod 3.


%% aplica_a_todos(F,[E|L]) :-
%%     call(F,E),
%%     aplica_a_todos(F,L).

%% aplica_a_todos(_,[]) :-
%%     true.
aplica_a_todos(F,L) :-
    maplist(F,L).

distintos(A,B) :-
    A \= B.

todos_distintos([]) :-
    true.

todos_distintos([_]) :-
    true.

%todos_distintos([A|L]) :-
%todos_distintos(L),
%aplica_a_todos(distintos(A),L).
todos_distintos(A) :-
    all_distinct(A).


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
    secuencia(0,26,S),
    maplist(coordenadas_desde_orden,COORS,S),
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


caras_de_cubo(CUBO) :-
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

    
contar([E|L],E,X) :-
    contar(L,E,X1),
    X is X1+1.

contar([EE|L],E,X) :-
    EE \= E,
    contar(L,E,X).

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
    aplica_a_todos(indomain,L).



% PRUEBAS
?- not(todos_distintos([1,2,3,1])).
?- coordenadas_desde_orden([1,1,1],13).
?- contar([3,8,4,8,3,8,9],3,2).
?- coordenadas([0,0,0]).
