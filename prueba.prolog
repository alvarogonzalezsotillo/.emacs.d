

:- use_module(library(clpfd)).

%% aplica_a_todos(F,[E|L]) :-
%%     call(F,E),
%%     aplica_a_todos(F,L).

%% aplica_a_todos(_,[]) :-
%%     true.
aplica_a_todos(F,L) :-
    maplist(F,L).

distintos(A,B) :-
    not(A = B).

todos_distintos([]) :-
    true.

todos_distintos([_]) :-
    true.

todos_distintos([A|L]) :-
    todos_distintos(L),
    aplica_a_todos(distintos(A),L).


color(C) :-
    C in 0..8.

coordenada(X) :-
    X in 1..3 .

coordenadas([X,Y,Z]) :-
    aplica_a_todos(coordenada,[X,Y,Z]).

celda([XYZ,C]) :-
    color(C),
    coordenadas(XYZ).              

coordenadas_de_celda(C,XYZ) :-
    [XYZ,_] = C. 
    %nth0(0,C,XYZ).


secuencia(MIN,MAX,L) :-
    MIN #< MAX,
    M is MIN+1,
    L = [MIN|LL],
    secuencia(M,MAX,LL).

secuencia(A,A,L) :-
    L = [A].

cubo(L) :-
    secuencia(0,26,S),
    maplist(coordenadas_desde_orden,C,S),
    maplist(coordenadas_de_celda,L,C).

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


modulo(A,B,M) :-
    M is A - (A // B)*B.

coordenadas_desde_orden([X,Y,Z],O) :-
    O < 27,
    X is O//9,
    Y is (O-X*9)//3,
    Z is O mod 3.

suma(A,B,S) :-
    S is A+B.



?- todos_distintos([a,b,c]).
?- not(todos_distintos([a,b,c,b])).
?- not(todos_distintos([1,2,3,1])).
?- modulo(10,4,2).
?- coordenadas_desde_orden([1,1,1],13).
?- contar([3,8,4,8,3,8,9],3,2).
