$fn=5;
$fa=5;

// PINTA UN PALO
module palo(a,b,r){
    hull(){
        translate(a) sphere(r);
        translate(b) sphere(r);
    }
}

// DISTANCIA ENTRE PUNTOS TRIDIMENSIONALES
function distancia(a,b) = 
  let(
    dx = a[0]-b[0],
    dy = a[1]-b[1],
    dz = a[2]-b[2]
  )
  sqrt(dx*dx + dy*dy + dz*dz);

// SUMA UNA LISTA DE PUNTOS
function sumaPuntos(lista) = suma(lista,[0,0,0],0);

//echo( concat( "sumaPuntos:" , sumaPuntos([[0,1,2],[3,4,5]]) ) );

// SUMA UNA LISTA DE COSAS (POR DEFECTO, NÚMEROS)
function suma(lista,retorno=0,i=0) = 
  i>=len(lista) ? 
  retorno : 
  suma(lista,lista[i]+retorno,i+1); 

// LISTA DE DISTANCIAS ENTRE DOS LISTAS DE PUNTOS DE LA MISMA LONGITUD
function distancias(puntos1, puntos2 ) =    [
     for( i =[0:1:len(puntos1)-1] )
         distancia(puntos1[i],puntos2[i])
];

// SUMA DE LAS DISTANCIAS ENTRE DOS LISTAS DE PUNTOS
function errorTotal(puntos1,puntos2) = suma(distancias(puntos1,puntos2));
  
//puntosDePrueba = [
//  [[0,0,0],[0,0,0]],
//  [[0,0,1],[1,1,0]]
//];
  
//echo( distancias(puntosDePrueba[0],puntosDePrueba[1] ) );

//echo( errorTotal(puntosDePrueba[0],puntosDePrueba[1] ) );

// FUERZAS ELECTROSTÁTICAS ENTRE UN PUNTO Y UNA LISTA DE PUNTOS (TODOS SE REPELEN)
function fuerzasParaPunto( p, puntos ) = [
     for( punto = puntos )
       let(
          d = distancia(p,punto)
       )
       if( punto != p )  
            (p - punto)/(d*d)
];

function modulo(vector) = distancia(vector,[0,0,0]);
       
// VECTOR CON LA MISMA DIRECCION, PERO CON UN MÓDULO DADO       
function normaliza( p, radio ) = radio * p / modulo(p);
    
// SUMA A UN PUNTO TODAS LAS FUERZAS DEL RESTO DE PUNTOS, Y LO ENCIERRA EN UNA ESFERA
function nuevoPuntoParaIteracion(p,puntos, radio=100) = 
     let(
        fuerzas = fuerzasParaPunto( p, puntos ),
        factorDeAmpliacion = radio*radio,
        fuerza = sumaPuntos(fuerzas)*factorDeAmpliacion,
        nuevoPunto = p + fuerza
     )
     normaliza(nuevoPunto,radio);

// CREA UN PUNTO TRIDIMENSIONAL ALEATORIO CON COORDENADAS ENTRE -1000 Y 1000
function puntoAleatorio() = rands(-1000,1000,3);

// CREA UNA LISTA DE n PUNTOS ALEATORIOS
function puntosAleatorios(n) = [for( i=[0:n-1] ) puntoAleatorio()];


//puntosIniciales = puntosAleatorios(5);
//echo( concat( "fuerzasParaPunto:", fuerzasParaPunto(puntosIniciales[0],puntosIniciales ) ) );
//echo( concat( "suma fuerzasParaPunto:", sumaPuntos(fuerzasParaPunto(puntosIniciales[0],puntosIniciales )) ) );
//echo( concat( "nuevo punto para iteracion:", nuevoPuntoParaIteracion(puntosIniciales[0],puntosIniciales)));

// CALCULA LA NUEVA POSICIÓN DE UNA LISTA DE CARGAS ELECTROSTÁTICAS ENCERRADAS EN UNA ESFERA
function iteracion(puntos, radio=100) = [
   for( i = puntos) nuevoPuntoParaIteracion(i,puntos,radio)
];

// ITERA EL CÁLCULO DE LA NUEVA POSICIÓN DE LAS CARGAS HASTA UN ERROR O MÁXIMO DE INTERACIONES
function iteraCalculoDePuntos( puntos, radio=100, errorMaximo=0.01, contador=0, iteracionesMaximas=1000 ) =
  let( 
    siguientesPuntos = iteracion(puntos,radio), 
    error = errorTotal(siguientesPuntos, puntos)
  )
  error <= errorMaximo || contador >= iteracionesMaximas ? 
        siguientesPuntos : 
        iteraCalculoDePuntos(siguientesPuntos, radio, errorMaximo, contador+1,iteracionesMaximas);


//echo( concat("iteracion:" , iteracion(puntosIniciales)));




//echo( concat( "itera", iteraCalculoDePuntos(puntosIniciales)));

//puntos = iteraCalculoDePuntos(puntosIniciales);

// CALCULA LOS VERTICES DE UN POLIEDRO ELECTROSTÁTICO ITERANDO n PUNTOS ALEATORIOS
function verticesPoliedroElectrostatico(n) = iteraCalculoDePuntos(puntosAleatorios(n));

// GENERA LA UNIÓN DE TODOS CON TODOS LOS VÉRTICES DE UN GRUPO DE PUNTOS
// NOTA: INCLUYE LOS PALOS INTERNOS QUE QUEREMOS QUITAR
module todosLosPalosDePuntos(puntos){
    for( p1 = puntos, p2 = puntos ){
        palo(p1,p2,10);
    }
}

// VER LA WIKIPEDIA
function productoEscalar(v1,v2) =
  suma( [ 
    for(i=[0:len(v1)-1]) v1[i]*v2[i] 
  ] );

// VER LA WIKIPEDIA
function productoVectorial(v1,v2) = 
[
    v1[1]*v2[2] - v1[2]*v2[1],
    - v1[0]*v2[2] + v1[2]*v2[0],
    v1[0]*v2[1] - v1[1]*v2[0]
];

//echo( concat( "CROSS1:", productoVectorial([1,-5,1],[10,1,0])));
//echo( concat( "CROSS2:",             cross([1,-5,1],[10,1,0])));

    
// ECUACION DEL PLANO ax+by+cz+d=0
// SI DA 0, ES DEL PLANO
// SI DA >0, ES DE UN LADO DEL PLANO
// SI DA <0, ES DEL OTRO LADO
// SE DEVUELVE [[a,b,c],d] VECTOR NORMAL Y CONSTANTE
function ecuacionDePlanoPorTresPuntos(p1,p2,p3) =
  let(
    puntoEnElPlano = p1,
    vector1 = p2-p1,
    vector2 = p3-p1,
    normal = productoVectorial(vector1,vector2),
    d = -productoEscalar(puntoEnElPlano,normal)
  )
  [normal,d];

// ECUACION DEL PLANO, PERO LOS TRES PUNTOS VIENEN EN UNA LISTA  
function ecuacionDePlanoPorTresPuntosEnLista(lista) =
   ecuacionDePlanoPorTresPuntos(lista[0],lista[1],lista[2]);


// RECIBE EL PLANO [[a,b,c],d] Y SUSTITUYE UN PUNTO
// DARÁ CERO SI EL PUNTO ES DEL PLANO
// DARA >0 O <0 SI ESTÁ EN UN LADO U OTRO DEL PLANO
function sustituyeEcuacionPlano(ecuacion,punto) =
    productoEscalar(ecuacion[0],punto) + ecuacion[1];
    
    
// PARA UNA LISTA DE VALORES, DECIDE SI SON TODOS MAYORES QUE UN UMBRAL    
function todosMayoresOIgualesQue(valores,umbral) =
    let(
        comprobaciones = [
            for( v=valores )
                v - umbral >= 0 ?
                1 :
                0
        ]
    )
    suma(comprobaciones) == len(valores);
            
            
    
// TODOS LOS TRIPLETES (SIN REPETICION) DE LOS NÚMEROS 0 ... HASTA n-1
function todosLosTripletesHasta(n) = [
      for( i=[0:n-3] , j=[i+1:n-2] , k=[j+1:n-1] ) [i,j,k]
];
  
// LISTA CON LOS TRES PUNTOS TRIDIMENSIONALES DEL TRIÁNGULO DEFINIDO POR
// LOS VERTICES INDICADOS EN LOS ÍNDICES    
function trianguloConIndicesDeVertices(indices,vertices) =
  [vertices[indices[0]], vertices[indices[1]], vertices[indices[2]]];
  
// ARISTAS (LISTA DE DOS PUNTOS) QUE HAY EN UN TRIANGULO (O TRIPLETE)    
function aristasDeTriangulo(triplete) = [
      [triplete[0],triplete[1]],
      [triplete[1],triplete[2]],
      [triplete[2],triplete[0]]
];    
  
// SI UNA LISTA ES [[a,b],[c,d],[e,f]] la deja en [a,b,c,d,e,f]    
// SI UNA LISTA ES [[[a,b],[c,d]],[[e,f],[g,h]]] la deja en [[a,b],[c,d],[e,f],[g,h]]
function aplanaUnNivel(lista) = [
      for( a = lista , b = a ) b
];
      
     
// DECIDE SI UN VALOR YA ESTA EN UNA LISTA
function contenidoEnLista(v,lista,indice=0) =
  lista[indice] == v ? 
  true : (
    indice>=len(lista) ?
    false :
    contenidoEnLista(v,lista,indice+1)
  );
     
// AGREAGA UN VALOR A UNA LISTA
function agregarALista(lista,valor) = [
      for(i=[0:len(lista)])
          i < len(lista) ? lista[i] : valor
];
      
// QUITA ARISTAS DUPLICADAS
// LAS ARISTAS [A,B] Y [B,A] SON LA MISMA      
function quitarAristasDuplicadas(aristas,ret=[],indice=0) = 
  indice >= len(aristas) ?
  ret : 
  (
      let( 
        a1 = aristas[indice],
        a2 = [a1[1],a1[0]]
      )
      contenidoEnLista(a1,ret) || contenidoEnLista(a2,ret) ?
      quitarAristasDuplicadas(aristas,ret,indice+1) :
      quitarAristasDuplicadas(aristas,agregarALista(ret,a1),indice+1)
  );
      
// DEVUELVE UNA LISTA DE ARISTAS EXTERIORES
// UNA ARISTA SON DOS ÍNDICES QUE INDICAN LOS PUNTOS DENTRO DE
// LA LISTA DE vertices
function aristasExteriores(vertices) =
    let(
      n = len(vertices),
      indicesTriangulos = todosLosTripletesHasta(n)
    )
    aplanaUnNivel([
        for( indices = indicesTriangulos )
            if( todosLosPuntosAlMismoLado(indices,vertices) )
                aristasDeTriangulo(indices)
    ]);      
    
    
// DECIDE SI TODOS LOS PUNTOS ESTÁN EN EL MISMO LADO
// DEL PLANO QUE DEFINE UN TRIÁNGULO
function todosLosPuntosAlMismoLado(triangulo,puntos,tolerancia=1) = 
   let(
      ecuacionPlano = ecuacionDePlanoPorTresPuntosEnLista(trianguloConIndicesDeVertices(triangulo,puntos)),
      lados = [
        for(punto=puntos)
            sustituyeEcuacionPlano(ecuacionPlano,punto)
      ],
      ladosNegados = [for(lado=lados) -lado]
   )
   todosMayoresOIgualesQue(lados,-tolerancia) ||
        todosMayoresOIgualesQue(ladosNegados,-tolerancia);
        
N = 4;      
vertices = verticesPoliedroElectrostatico(N);

//tripletes = todosLosTripletesHasta(N);
//triplete0 = tripletes[0];      
//triangulo0 = trianguloConIndicesDeVertices(triplete0,vertices);
//ecuacion0 = ecuacionDePlanoPorTresPuntosEnLista(trianguloConIndicesDeVertices(triplete0,vertices));

//echo( concat( "tripletes:", tripletes));
//echo( concat( "triangulos:", [ for(t=tripletes) trianguloConIndicesDeVertices(t, vertices) ] ) ); 
    
//echo( concat( "vectorial:", productoVectorial(
//    triangulo0[1]-triangulo0[0],
//    triangulo0[2]-triangulo0[0]
//)));

//echo( concat( "ecuacion 0 0:", ecuacionDePlanoPorTresPuntos(triangulo0[0],triangulo0[1], triangulo0[2])));

//echo( concat( "ecuacion 0:", ecuacion0));

//echo( concat( "valores ecuacion", [
//    for( v=vertices ) [sustituyeEcuacionPlano(ecuacion0,v)]
//]));
    
//echo( concat( "mayores que 1:", todosMayoresOIgualesQue(
//    [for( v=vertices ) sustituyeEcuacionPlano(ecuacion0,v)],
//    -100
//)));

//echo( concat( "mayores que 2:", todosMayoresOIgualesQue(
//    [for( v=vertices ) -sustituyeEcuacionPlano(ecuacion0,v)],
//    -100
//)));


//echo( concat( "mismo lado:", todosLosPuntosAlMismoLado(triplete0,vertices)));

aristas = aristasExteriores(vertices);

//echo( concat( "exteriores:" , aristas ) );

aristasSinDuplicados = quitarAristasDuplicadas(aristas);
echo( concat( "sin duplicar aristas:" , aristasSinDuplicados ) );
        
        
//translate([300,300,0]) todosLosPalosDePuntos(vertices);
    
    
module aristasAPalos(aristas,vertices,ancho=10){
    for( i=aristas )
        palo(vertices[i[0]],vertices[i[1]],ancho);
}    
    
aristasAPalos(aristasSinDuplicados,vertices,5);
