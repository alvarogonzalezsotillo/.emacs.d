// -*- mode: js2; -*-

// http://tulengua.es/es/separar-en-silabas

function log(s){
    //console.log(s);
}

function warn(s){
//    console.log(`WARN: ${s}` );
}

import {corpus} from "./corpus-by-syllable-no-pp.mjs";


const acentuadas = "áéíóú".split("");
const abiertas = "aáeéoó".split("");
const cerradas = "iíuúü".split("");
const vocales = abiertas.concat(cerradas);
const trasVocales = ["b","c","d","f","g","l","m","n","ns","p","r","rs","s","t","x","y","z"];
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







function addObjectLazyProp(o,p,evaluator){
    const internalName = `_private_${p}_`;
    Object.defineProperty(o,p, {
        enumerable: true,
        get: function(){
            log("DefineProperty:");
            if(!this[internalName]){
                Object.defineProperty(this,internalName,{
                    writable: false,
                    enumerable: false,
                    value: evaluator.call(this,this)
                });
            }
            return this[internalName];
        }
    });
}

function addClassLazyProp(clazz,p,evaluator){
    addObjectLazyProp(clazz.prototype,p,evaluator);
}

class Palabra{
    constructor(texto){
        this.texto = texto;
    }

    toString(){
        return `${this.texto} ${this.silabasConTonica}`;
    }
}

addClassLazyProp(
    Palabra,
    "silabas",
    (o) => palabraConHiatos(o.texto)
);

addClassLazyProp(
    Palabra,
    "silabaTonica",
    (o) => silabaTonica(o.silabas)
);

addClassLazyProp(
    Palabra,
    "letraTonica",
    (o) => letraTonica(o.silabas)
);

addClassLazyProp(
    Palabra,
    "silabasConTonica",
    (o) => {
        const ret = o.silabas.slice();
        const i = o.silabaTonica;
        ret[i] = ret[i].toUpperCase();
        return ret;

    }
);

addClassLazyProp(
    Palabra,
    "asPlainObject",
    (o) => {
        const ret = {};
        for( let p in o ){
            if( p != "asPlainObject" ){
                ret[p] = o[p];
            }
        }
        Object.freeze(ret);
        return ret;
    }
);


function acentuaSilabas(silabas){
    let i = silabaTonica(silabas);
    log(`acentuaSilabas ${silabas} i:${i}`);
    const ret = silabas.slice();
    ret[i] = ret[i].toUpperCase();
    return ret;

}


function vocalTonicaDeSilaba(silaba){
    const ls = silaba.split("");
    const acento = ls.findIndex( l=> acentuadas.includes(l) );

    // si hay una vocal acentuada, es esa
    if( acento >= 0 ){
        return acento;
    }

    // el acento estará en la última vocal abierta
    for( let i = ls.length -1 ; i >= 0 ; i-- ){
        if( abiertas.includes(ls[i]) ){
            return i;
        }
    }

    // en otro caso, en la última vocal
    for( let i = ls.length -1 ; i >= 0 ; i-- ){
        if( vocales.includes(ls[i]) ){
            return i;
        }
    }

    return null;
}

function letraTonica(silabas){
    const t = silabaTonica(silabas);
    if( t == null ){
        return null;
    }
    const s = silabas[t];
    const i = vocalTonicaDeSilaba(s);

    log(`letraTonica: ${silabas} t:${t} s:${s} i:${i}`);
    return silabas.slice(0,t).join("").length + i;
}

function silabaTonica(silabas){
    // https://lengualdia.blogspot.com/2012/02/excepciones-de-la-rima-los-diptongos-y.html?m=1
    // https://www.poemas-del-alma.com/blog/taller/hiatos-diptongos-y-triptongos 
    
    function posicionAcentoGrafico(){
        for(let i in silabas){
            if( silabas[i].split("").find(l=>acentuadas.includes(l))){
                return parseInt(i);
            }
            
        }
        return null;
    }

    if(silabas.length < 2){
        // monosílabo
        return 0;
    }

    const acento = posicionAcentoGrafico();
    if( acento != null ){
        return acento;
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
        return silabaTonica(raiz);
    }

    const ultimaL = ultima.charAt(ultima.length-1);
    const acabaNSVocal =
          ultimaL == "n" ||
          ultimaL == "s" ||
          vocales.includes(ultimaL);

    log( `silabaTonica: ${silabas} ${ultimaL} ${acabaNSVocal}`);
    
    let i = -1;
    if( acabaNSVocal ){
        // acaba en nsa sin acento gráfico, es llana
        log( `silabaTonica: llana` );
        i = silabas.length-2;
    }
    else{
        // no acaba en nsa ni acento gráfico, es aguda
        log( `silabaTonica: aguda` );
        i = silabas.length-1;
    }

    log( `silabaTonica: ${i}` );
    return i;
}

function palabraConHiatos(str){
    const condiptongos = palabraSinHiatos(str);
    if( !condiptongos ){
        warn(`condiptongos es null:${str}`);
        return null;
    }
    let ret = [];
    log(`palabraConHiatos:  ${str} condiptongos:${condiptongos}`);
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
                return null; //throw "imposible"; // áé
            } 
            if( !c1 && a1 && c2 && !a2){
                return false; // ái
            }
            if( !c1 && a1 && c2 && a2){
                return null; //throw "imposible"; // áí
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
                return null; //throw "imposible"; // íá
            }
            if( c1 && a1 && c2 && !a2){
                return true; // íu
            }
            if( c1 && a1 && c2 && a2){
                return null; //throw "imposible"; // íú
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
        if(separables(silabas[i1],silabas[i2]) == true){
            let [ret,resto] = separaPor(i1);
            log(`separaHiato: ret:${ret} resto:${resto}`);
            let recursion = separaHiato(resto);
            log(`separaHiato: recursion:${recursion}`);
            return [ret].concat(recursion);
        }
        return [silabaS];
    }    
    
}


function rimaConsonanteCon(p1,p2){
    const silabas1 = palabraConHiatos(p1);
    const silabas2 = palabraConHiatos(p2);
    if( silabas1 == null || silabas2 == null ){
        return false;
    }
    const i1 = letraTonica(silabas1);
    const i2 = letraTonica(silabas2);
    const fin1 = p1.substring(i1);
    const fin2 = p2.substring(i2);
    return fin1 == fin2;
}

function* rimasConsonantesCon(palabra,numeroSilabas){
    console.log("rimasConsonantesCon");
    const silabas = palabraConHiatos(palabra);
    const tonica = silabaTonica(silabas);

    console.log(`tonica:${tonica} numeroSilabas:${numeroSilabas}`);
    console.log(`tonica+1:${tonica+1} numeroSilabas:${numeroSilabas}`);
    if( tonica+1 >= numeroSilabas){
        console.log("tonica+1 >= numeroSilabas");
        return;
    }
    
    if( !corpus[numeroSilabas-1] ){
        console.log("!corpus[numeroSilabas-1]");
        return;
    }
    const candidatas = corpus[numeroSilabas-1];

    for( let c of candidatas ){
        if( rimaConsonanteCon(palabra,c) ){
            yield c;
        }
    }
}

function* rimaAsonsonanteCon(palabra,numeroSilabas){
    if( !corpus[numeroSilabas+1] ){
        return;
    }

    const silabas = palabraConHiatos(palabra);
    const tonica = silabaTonica(silabas);
    if( tonica+1 >= numeroSilabas){
        return;
    }

    function silabaRimaCon(s1,s2,esTonica){
        if( !esTonica){
            return s1 == s2;
        }
        const ls1 = s1.split("").filter(l=>l!="h");
        const ls2 = s2.split("").filter(l=>l!="h");

        const i1 = ls1.findIndex(l=>vocales.includes(l));
        const i2 = ls2.findIndex(l=>vocales.includes(l));

        if(i1==-1 || i2==-1){
            return false;
        }

        return s1.substr(i1)==s2.substr(i2);
    }
    
    function palabraRimaCon(p){
        const ss = palabraConHiatos(p);
        if(ss.length != numeroSilabas ){
            return false;
        }
        const t = silabaTonica(ss);
        if( silabas.length - tonica != ss.length - t){
            return false;
        }

        for(let i = 0 ; i < ss.length-tonica ; i++){
            const iPalabra = silabas.length - i - 1;
            const iP = ss.length - i - 1;
            const esTonica = iPalabra == tonica;
            if(!silabaRimaCon(silabas[iPalabra], ss[iP], esTonica)){
                return false;
            }
        }
        return true;
    }

    
    const candidatas = corpus[numeroSilabas+1];
    for(c of candidatas){
        yield c;
    }
}

function normalizaPronunciacion(silaba){
    /*
      GUI -> GI
      GÜI -> GUI
      GI  -> JI
      HA  -> A
      VI  -> BI
      QUI -> KI
      CA  -> KA
      CI  -> ZI
      
    */

    const map = [
        ["gue", "ge"],
        ["gué", "gé"],
        ["gui", "gi"],
        ["guí", "gí"],
        ["güe", "gue"],
        ["güé", "gué"],
        ["güi", "gui"],
        ["güí", "guí"],
        ["que", "ke"],
        ["qué", "ké"],
        ["qui", "ki"],
        ["quí", "kí"],
        ["ce", "ze"],
        ["cé", "zé"],
        ["ci", "zi"],
        ["cí", "zí"],
        ["ge", "je"],
        ["gé", "jé"],
        ["gi", "ji"],
        ["gí", "jí"],
        ["ch", "ch"],
        ["h", ""],
        ["v", "b"],
        ["c", "k"],
    ];

    function match(restoDeSilaba){
        if( restoDeSilaba.length == 0 ){
            return {
                traduccion : "",
                restoDeSilaba : ""
            };
        }
        
        for( let i = 0 ; i < map.length ; i++ ){
            if( restoDeSilaba.startsWith(map[i][0]) ){
                return {
                    traduccion : map[i][1],
                    restoDeSilaba : restoDeSilaba.substring( map[i][0].length )
                };
            }
        }
        
        return {
            traduccion : restoDeSilaba.substring(0,1),
            restoDeSilaba : restoDeSilaba.substring(1)
        };
    }
    
    let ret = "";
    let restoDeSilaba = silaba;
    while( restoDeSilaba != "" ){
        
        const m = match(restoDeSilaba);
        restoDeSilaba = m.restoDeSilaba;
        ret += m.traduccion;
    }

    return ret;
}

const testExport = {
    vocalTonicaDeSilaba: vocalTonicaDeSilaba,
};

export {
    palabraConHiatos,
    silabaTonica,
    Palabra,
    rimaConsonanteCon,
    rimasConsonantesCon,
    normalizaPronunciacion,
    testExport
};

