

:- use_module(library(clpfd)).

coordenadas_desde_orden(O,[X,Y,Z]) :-
    O < 27,
    X is O//9,
    Y is (O-X*9)//3,
    Z is O mod 3.

aplica_a_todos(F,L) :-   maplist(F,L).

todos_distintos(A) :- all_distinct(A).


color(C) :-
    C in 0..8.

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


secuencia(MIN,MAX,L) :-
    MIN #< MAX,
    M is MIN+1,
    L = [MIN|LL],
    secuencia(M,MAX,LL).

secuencia(A,A,L) :-
    L = [A].

cubo(L) :-
    secuencia(0,26,SEQ),
    include(dif(13), SEQ, SEQSINCENTRO),
    maplist(coordenadas_desde_orden,SEQSINCENTRO,COORS),
    maplist(coordenadas_de_celda,L,COORS),
    aplica_a_todos(celda,L).










coordenadas_de_celdaZ(Z,C) :-
    coordenadas_de_celda(C,[_,_,Z]).

caraXY(CUBO,Z,CARA) :-
    include(coordenadas_de_celdaZ(Z),CUBO,CARA).


coordenadas_de_celdaY(Y,C) :-
    coordenadas_de_celda(C,[_,Y,_]).

caraXZ(CUBO,Y,CARA) :-
    include(coordenadas_de_celdaY(Y),CUBO,CARA).


coordenadas_de_celdaX(X,C) :-
    coordenadas_de_celda(C,[X,_,_]).


caraYZ(CUBO,X,CARA) :-
    include(coordenadas_de_celdaX(X),CUBO,CARA).

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

restricciones_caras_de_cubo_jaime(CUBO) :-
    restricciones_caras_de_cubo(CUBO),
    caraXY(CUBO,1,CARAXY),
    colores_de_celdas_distintos(CARAXY),
    caraXZ(CUBO,1,CARAXZ),
    colores_de_celdas_distintos(CARAXZ),
    caraYZ(CUBO,1,CARAYZ),
    colores_de_celdas_distintos(CARAYZ).
    



contar([EE|L],E,X) :-
    dif(EE, E),
    contar(L,E,X).

contar([E|L],P,X) :-
   E = P,
   contar(L,P,X1),
   X is X1+1.

contar([],_,0).

es_esquina(CELDA) :-
    coordenadas_de_celda(CELDA,[X,Y,Z]),
    contar([X,Y,Z],1,0).

esquinas(CUBO,ESQUINAS) :-
    include(es_esquina,CUBO,ESQUINAS).

es_arista(CELDA) :-
    coordenadas_de_celda(CELDA,[X,Y,Z]),
    contar([X,Y,Z],1,1).
         
aristas(CUBO,ARISTAS) :-
    include(es_arista,CUBO,ARISTAS).


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
   

celda_desde_coordenadas(CUBO,COORDENADAS,CELDA) :-
    include(=([COORDENADAS,_]),CUBO,[CELDA]).

color_en_coordenadas(CUBO,COORDENADAS,COLOR) :-
    celda_desde_coordenadas(CUBO,COORDENADAS,CELDA),
    CELDA = [_,COLOR].

restriciones_colores_centrales_de_caras(CUBO) :-
    % Los centros de las caras tienen dos coordenadas a 1
    color_en_coordenadas(CUBO,[0,1,1], 4),
    color_en_coordenadas(CUBO,[1,1,2], 1),
    color_en_coordenadas(CUBO,[1,0,1], 5),
    color_en_coordenadas(CUBO,[1,1,0], 3),
    color_en_coordenadas(CUBO,[1,2,1], 0),
    color_en_coordenadas(CUBO,[2,1,1], 7).


cubo_con_restricciones(CUBO) :-
    cubo(CUBO),
    restricciones_caras_de_cubo_jaime(CUBO),
    restriciones_colores_centrales_de_caras(CUBO),
    restricciones_esquinas_aristas(CUBO).

instancia_valores(L) :-
    label(L).

%% | color    | vértices | aristas | indice |
%% | blanco   |        1 |       1 |       0 |
%% | azul     |        1 |       1 |       1 |
%% | rosa     |        0 |       3 |       2 |
%% | morado   |        1 |       1 |       3 |
%% | amarillo |        1 |       1 |       4 |
%% | negro    |        1 |       1 |       5 |
%% | rojo     |        0 |       3 |       6 |
%% | naranja  |        1 |       1 |       7 |
%% | verde    |        2 |       2 |       8 |

%% | x=0, y=1 | x=1    | x=2,y=1 |              |
%% |          | azul   |         | z = 2, y=1   |
%% | amarillo | negro  | naranja | z = 1        |
%% |          | morado |         | z = 0, y = 1 |
%% |          | blanco |         | z = 1, y =2  |


color_a_nombre(0,"1 1 1" ). % white).
color_a_nombre(1,"0 0 1" ). % blue).
color_a_nombre(2,"1 .5 .5" ). % pink).
color_a_nombre(3,".5 0 .5" ). % purple).
color_a_nombre(4,"1 1 0" ). % yellow).
color_a_nombre(5,"0 0 0" ). % black).
color_a_nombre(6,"1 0 0" ). % red).
color_a_nombre(7,"1 .5 0" ). % orange).
color_a_nombre(8,"0 1 0" ). % green).

celda_con_nombre_de_color(CELDA,CELDAACOLOR) :-
    CELDA = [XYZ,C],
    color_a_nombre(C,N),
    CELDAACOLOR = [XYZ,N].

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
            </transform>\n", [(X-1)*2,(Y-1)*2,(Z-1)*2,N]).

imprime_solucion(CUBO) :-
    write("
	 <x3d height='300px' style='border:none; display:block; width:100%'> 
	   <scene>\n "),
    aplica_a_todos(imprime_celda,CUBO),
    write("
           </scene>
         </x3d> ").

% PRUEBAS
?- not(todos_distintos([1,2,3,1])).
?- coordenadas_desde_orden(13,[1,1,1]).
?- contar([3,8,4,8,3,8,9],3,2).
?- coordenadas([0,0,0]).
?- findall(CUBO, cubo_con_restricciones(CUBO),SOLUCIONES),
   aplica_a_todos(imprime_solucion,SOLUCIONES),
   length(SOLUCIONES,X),
   format("Número de soluciones:~d",X).
