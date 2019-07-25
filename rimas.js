// -*- mode: js2; -*-

// http://tulengua.es/es/separar-en-silabas

function log(s){
    // console.log(s);
}


const acentuadas = "áéíóú".split("");
const abiertas = "aáeéoó".split("");
const cerradas = "iíuúü".split("");
const vocales = abiertas.concat(cerradas);
const trasVocales = ["b","c","d","f","l","m","n","ns","r","rs","s","t","y","z"];
const consonantes = ["b","c", "d", "f", "g", "h", "j", "k", "l", "m", "n","ñ","p","q","r","s","t","v","w","x","y","z"];
const doblesConsonantes = ["ch", "rr","ll","dr","tr","ps"].
      concat(["b","c","f","g","p"].map(l=>l+"l")).
      concat(["b","c","f","g","p"].map(l=>l+"r"));

const silabasEspeciales = ["trans"];


class Extraccion{
    constructor(extraido,resto){
        this.extraido = extraido;
        this.resto = resto;
    }

    toString(){
        return `${this.extraido}:${this.resto}`;
    }
}

function E(e,r){
    return new Extraccion(e,r);
}


function buscaSubstr(array,s){
    // extrae todos los prefijos posibles, en orden
    return array.
        filter(a=>s.startsWith(a)).
        map(r=>E(r,s.substr(r.length)));
    
}


function primero(array,s){
    // resultado del primer extractor valido
    for(let a of array){
        const r = a(s);
        if(r.length) {
            return r;
        }
    }
    return [];
}






const vocal = s => buscaSubstr(vocales,s);
const consonante = s => buscaSubstr(consonantes,s);
const dobleConsonante = s => buscaSubstr(doblesConsonantes,s);
const trasVocal = s => buscaSubstr(trasVocales,s);


const grupoConsonanticoInicial =
      s =>primero([dobleConsonante,consonante],s);

function grupoVocalico(s){
    const log = ()=>null;
    log(`grupoVocalico: ${s}`);
    const a = s.split("");
    let i = 0;
    for( i = 0 ; i < a.length ; i++){
        const c = a[i];
        log(`grupoVocalico: ${s} i:${i} c:${c}`);
        if(vocales.find(v=> v==c)){
            log(`grupoVocalico: ${s} es vocal`);
            continue;
        }
        if(i>0 &&
           a[i-1]!="h" &&
           a[i]=="h" &&
           i < a.length-1 &&
           a[i+1] &&
           vocales.find(v=>v==a[i+1]) ){
            log(`grupoVocalico: ${s} es h intercalada`);
            continue;
        }
        log(`grupoVocalico: ${s} es consonante`);
        break;
    }
    const ret = i ?
          [E(s.substring(0,i),s.substring(i))] :
          [];
    log(`grupoVocalico: ${s} i:${i} ret:${ret}`);
    return ret;
    

    
    
}
grupoVocalico.toString = ()=> "grupoVocalico";


function silabaTodoDiptongo(str){
    // extrae todas las siguientes posibles sílabas, dejando primero la que debe ser explorada primero
    const silabas = [
        [s=>buscaSubstr(silabasEspeciales,s)],
        [grupoVocalico],
        [grupoConsonanticoInicial,grupoVocalico],
        [grupoVocalico,trasVocal],    
        [grupoConsonanticoInicial,grupoVocalico,trasVocal],
    ];

    log(`silaba: str:${str}`);
    
    const ret = silabas.
          map(s=> secuencia(s,str)).
          filter(e=> e.length).
          flat();
    log(`silaba: str:${str} ret:${ret.join("  ")}`);
    return ret;
}



function palabraSinHiatos(str){
    // extrae sílabas de forma recursiva, devielve el primer éxito
    function palabraR(silabas,resto){
        if(!resto){
            return silabas;
        }

        log(`palabraR: silabas:${silabas}  resto:${resto}`);
        
        const ss = silabaTodoDiptongo(resto);
        log(`palabraR: resto:${resto} ss:${ss}`);
        for(let s of ss){
            const newSilabas = silabas.concat(s.extraido);
            const ret = palabraR(newSilabas, s.resto);
            if(ret){
                return ret;
            }
        }
        
        return null;
    }
    return palabraR([],str);
}

function secuencia(buscas,str){
    // aplica varios extractores uno tras otro, y devuelve todas las posibilidades
    const log = ()=>null;
    log(`secuencia: str:${str}`);
    if(!str && buscas.length > 0){
        return [];
    }
    
    let ret = [E("",str)];
    for(let b of buscas){
        log(`secuencia: str:${str} b:${b}`);

        ret = ret.map( r =>{
            const nrs = b(r.resto);
            return nrs.map(
                nr => E(r.extraido + nr.extraido, nr.resto)   
            );
        }).flat();
        

        log(`secuencia: str:${str} b:${b} ret:${ret}`);
        
    }
    return ret;
}





function tests(){


    function arrayIgual(a,b){
        if(a.length != b.length){
            return false;
        }
        for (let i = 0; i < a.length; i++) {
            if( a[i] != b[i]){
                return false;
            }
        }
        return true;
    }



    
    const assert = (b,s) => {
        if(!b) {
            console.trace();
            throw(s || "error");
        }
    };

    const assertEQ = (a,b) => assert(a==b,`${a} != ${b}`);



    assertEQ(vocal("abd")[0].extraido,"a");
    assertEQ(vocal("abd")[0].resto,"bd");


    assertEQ(secuencia([vocal,vocal],"aej")[0].resto,"j");
    assertEQ(secuencia([vocal,vocal],"aej")[0].extraido,"ae");
    assertEQ(silabaTodoDiptongo("pepa")[0].extraido,"pe");
    assertEQ(silabaTodoDiptongo("pepa")[0].resto,"pa");


    
    assertEQ(grupoVocalico("ab")[0].extraido,"a");
    assertEQ(grupoVocalico("aob")[0].extraido,"ao");
    assertEQ(grupoVocalico("baob").length,0);

    
    function PP(silabeado,separador){
        const array = silabeado.split("-");
        const p = array.join("");
        const s = separador(p);
        const test = s.join("-");
        const acentuada = acentuaSilabas(s);
        log(`PP: s:${s}`);
        console.log(`pruebaPalabra: ${p} -> ${test}  ${acentuada}`);
        if(silabeado != test){
	    throw(s);
	}
    }

    function PPD(silabeado){
        PP(silabeado,palabraSinHiatos);
    }


    function PPH(silabeado){
        PP(silabeado,palabraConHiatos);
    }
    
    PPH("pa-la-bra");
    PPH("pe-pe");
    PPH("sal-chi-chón");
    PPH("ca-mión");
    PPH("con-se-guir");
    PPH("a-dic-ción");
    PPH("trans-por-te");
    PPH("trans-at-lán-ti-co");
    PPH("ci-güe-ña");
    PPH("ahue-va-do");
    PPH("es-pec-ta-cu-lar");
    PPH("pers-pi-caz");
    PPH("e-rror");
    PPH("her-mo-su-ra");
    PPH("con-ver-sa-ción");
    PPH("per-se-gui-réis");
    PPH("ma-rí-a");
    PPH("rey");
    PPH("es-toy");
    PPH("pla-ya");
    PPH("pa-yo-yo");
    PPH("a-lla-nar");

  
    PPH("ca-mión");
    PPH("ci-güe-ña");
    PPH("quie-tud");
    PPH("re-yer-ta");
    PPH("a-pa-re-ce-réis");
    PPH("hia-to");
    PPH("bien");
    PPH("dié-re-sis");
    PPH("i-gual-dad");

  
}

function acentuaSilabas(silabas){

    function posicionAcentoGrafico(){
        for(let i in silabas){
            if( silabas[i].split("").find(l=>acentuadas.includes(l))){
                return i;
            }
            
        }
        return null;
    }

    if(silabas.length < 2){
        // monosílabo
        return silabas.map(s=>s.toUpperCase());
    }

    const acento = posicionAcentoGrafico();
    if( acento != null ){
        const ret = silabas.slice();
        ret[acento] = ret[acento].toUpperCase();
        return ret;
    }

 


    const ultima = silabas[silabas.length-1].toLowerCase();
    const penultima = silabas[silabas.length-2].toLowerCase();
    const mente =
          silabas.length > 2 &&
          ultima == "te" &&
          penultima == "men";

    if(mente){
        // adverbio a partir de adjetivo
        const raiz = silabas.slice(0,-2);
        return acentuaSilabas(raiz).concat(["men","te"]);
    }

    const ultimaL = ultima.charAt(ultima.length-1);
    const acabaNSVocal =
          ultimaL == "n" ||
          ultimaL == "s" ||
          vocales.includes(ultimaL);

    log( `acentuaSilabas: ${silabas} ${ultimaL} ${acabaNSVocal}`);
    
    let i = -1;
    if( acabaNSVocal ){
        // acaba en nsa sin acento gráfico, es llana
        i = silabas.length-2;
    }
    else{
        // no acaba en nsa ni acento gráfico, es aguda
        i = silabas.length-1;
    }
    const ret = silabas.slice();
    ret[i] = ret[i].toUpperCase();
    return ret;
}

function palabraConHiatos(str){
    const condiptongos = palabraSinHiatos
    (str);
    let ret = [];
    for(let s of condiptongos){
        ret = ret.concat(separaHiato(s));
    }
    return ret;
    


    function separaHiato(silabaS){

        // la silabaS proviene de palabra()
        // las y pueden aparecer al principio como consonante o al final como vocal. Si es vocal es siempre diptongo.
        // Puede haber h intercalada, si se separa va en la segunda sílaba
        // https://www.ejemplos.co/50-ejemplos-de-palabras-con-hiato/
        const esAbierta = v => abiertas.includes(v);
        const esAcentuada = v => acentuadas.includes(v);
        const esVocal = v => vocales.includes(v);


        function separables(v1,v2){
            log(`separables:  v1:${v1} v2:${v2}`);
            const c1 = !esAbierta(v1);
            const c2 = !esAbierta(v2);
            const a1 = esAcentuada(v1);
            const a2 = esAcentuada(v2);

            log(`separables: c1:${c1}  a1:${a1} c2:${c2} a2:${a2}`);

            if( !c1 && !a1 && !c2 && !a2){
                return true; // ae
            }
            if( !c1 && !a1 && !c2 && a2){
                return true; // aé
            }
            if( !c1 && !a1 && c2 && !a2){
                return false; // ai
            }
            if( !c1 && !a1 && c2 && a2){
                return true; // aí
            }
            if( !c1 && a1 && !c2 && !a2){
                return true; // áe
            }
            if( !c1 && a1 && !c2 && a2){
                throw "imposible"; // áé
            } 
            if( !c1 && a1 && c2 && !a2){
                return false; // ái
            }
            if( !c1 && a1 && c2 && a2){
                throw "imposible"; // áí
            }
            if( c1 && !a1 && !c2 && !a2){
                return false; // ia
            }
            if( c1 && !a1 && !c2 && a2){
                return false; // iá
            }
            if( c1 && !a1 && c2 && !a2 ){
                return false; // iu
            }
            if( c1 && !a1 && c2 && a2){
                return false; // iú
            }
            if( c1 && a1 && !c2 && !a2){
                return true; // ía
            }
            if( c1 && a1 && !c2 && a2){
                throw "imposible"; // íá
            }
            if( c1 && a1 && c2 && !a2){
                return true; // íu
            }
            if( c1 && a1 && c2 && a2){
                throw "imposible"; // íú
            }
            throw "inesperado";
        }
        

        function separaPor(i){
            return [
                silabaS.substr(0,i+1),
                silabaS.substr(i+1)
            ];
        }
        
        const silabas = silabaS.split("");


        
        function buscaVocal(desde){
            // log(`buscaVocal: ${vocales} ${silabas} desde:${desde}`);
            for( let i = desde; i < silabas.length ; i++ ){
                if( esVocal(silabas[i]) ){
                    return i;
                }
            }
            return null;
        }
        
        let i1 = buscaVocal(0);
        if(i1==null){
            throw "esperaba vocal";
        }
        let i2 = buscaVocal(i1+1);
        if(i2==null){
            return [silabaS];
        }
        
        log(`separaHiato: ${silabaS}: i1:${i1} i2:${i2}`);
        if(separables(silabas[i1],silabas[i2])){
            let [ret,resto] = separaPor(i1);
            log(`separaHiato: ret:${ret} resto:${resto}`);
            let recursion = separaHiato(resto);
            log(`separaHiato: recursion:${recursion}`);
            return [ret].concat(recursion);
        }
        return [silabaS];
    }    
    
}



tests();
