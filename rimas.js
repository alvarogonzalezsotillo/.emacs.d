// -*- mode: js2; -*-

// http://tulengua.es/es/separar-en-silabas

const log = (s)=> {
    //console.log(s);
    null;
};


const acentuadas = "aéíóú".split("");
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



function palabra(str){
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

    
    function PP(silabeado){
        const array = silabeado.split("-");
        const p = array.join("");
        const s = palabra(p);
        const test = s.join("-");
        log(`PP: s:${s}`);
        console.log(`pruebaPalabra: ${p} -> ${test}`);
        if(silabeado != test){
	    throw(s);
	}
    }

    
    PP("pa-la-bra");
    PP("pe-pe");
    PP("sal-chi-chón");
    PP("ca-mión");
    PP("con-se-guir");
    PP("a-dic-ción");
    PP("trans-por-te");
    PP("trans-at-lán-ti-co");
    PP("ci-güe-ña");
    PP("ahue-va-do");
    PP("es-pec-ta-cu-lar");
    PP("pers-pi-caz");
    PP("e-rror");
    PP("her-mo-su-ra");
    PP("con-ver-sa-ción");
    PP("per-se-gui-réis");
    PP("ma-ría");
    PP("rey");
    PP("es-toy");
    PP("pla-ya");
    PP("pa-yo-yo");
    PP("a-lla-nar");
}


function separaDiptongo(silabaS){

    
    // https://www.ejemplos.co/50-ejemplos-de-palabras-con-hiato/
    const esAbierta = v => abiertas.includes(v);
    const esAcentuada = v => acentuadas.includes(v);


    function separables(v1,v2){
        const c1 = !esAbierta(v1);
        const c2 = !esAbierta(v2);
        const a1 = esAcentuada(v1);
        const a2 = esAcentuada(v2);

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
    
    
}



tests();
