// -*- mode: js2; -*-

// http://tulengua.es/es/separar-en-silabas

const log = (s)=> {
    //console.log(s);
    null;
};


const vocales = ["a","e","i","o","u","á","é","í","ó","ú","ü"];
const trasVocales = ["b","c","d","f","l","m","n","ns","r","rs","s","t","z"];
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
    return array.
        filter(a=>s.startsWith(a)).
        map(r=>E(r,s.substr(r.length)));
    
}


function primero(array,s){
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


function silaba(str){
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
    function palabraR(silabas,resto){
        if(!resto){
            return silabas;
        }

        log(`palabraR: silabas:${silabas}  resto:${resto}`);
        
        const ss = silaba(resto);
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

    const assertEquals = (a,b) => assert(a==b,`${a} != ${b}`);



    assertEquals(vocal("abd")[0].extraido,"a");
    assertEquals(vocal("abd")[0].resto,"bd");


    assertEquals(secuencia([vocal,vocal],"aej")[0].resto,"j");
    assertEquals(secuencia([vocal,vocal],"aej")[0].extraido,"ae");
    assertEquals(silaba("pepa")[0].extraido,"pe");
    assertEquals(silaba("pepa")[0].resto,"pa");


    
    assertEquals(grupoVocalico("ab")[0].extraido,"a");
    assertEquals(grupoVocalico("aob")[0].extraido,"ao");
    assertEquals(grupoVocalico("baob").length,0);

    
    function PP(array){
        const p = array.join("");
        const s = palabra(p);
        log(`PP: s:${s}`);
        console.log(`PP: ${p} -> ${s.join("-")}`);
        if(!arrayIgual(array,s)){
	    throw(s);
	}
    }

    
    PP(["pa","la", "bra"]);
    PP(["pe","pe"]);
    PP(["sal","chi","chón"]);
    PP(["ca","mión"]);
    PP(["con","se","guir"]);
    PP(["a","dic","ción"]);
    PP(["trans","por","te"]);
    PP(["trans", "at","lán","ti","co"]);
    PP(["ci","güe","ña"]);
    PP(["ahue","va","do"]);
    PP(["es","pec","ta","cu","lar"]);
    PP(["pers","pi","caz"]);
    PP(["e","rror"]);
    PP(["her","mo","su","ra"]);
    PP(["con","ver","sa","ción"]);
    PP(["per","se","gui","réis"]);
    PP(["ma","ría"]);
    
}



tests();
