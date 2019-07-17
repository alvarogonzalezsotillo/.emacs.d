// -*- mode: js2; -*-

// http://tulengua.es/es/separar-en-silabas

const vocales = ["a","e","i","o","u","á","é","í","ó","ú","ü"];
const trasVocales = ["b","c","d","f","l","m","n","ns","r","rs","s","t"];
const consonantes = ["b","c", "d", "f", "g", "h", "j", "k", "l", "m", "n","ñ","p","q","r","s","t","v","w","x","y","z"];
const doblesConsonantes = ["ch", "rr","ll","dr","tr","ps"].
      concat(["b","c","f","g","p"].map(l=>l+"l")).
      concat(["b","c","f","g","p"].map(l=>l+"r"));

const silabasEspeciales = ["trans"];

function busca(array, s){



    const ret = array.find(a=>s.startsWith(a));
    if(ret) {
        const resto = s.substr(ret.length);
        return [ret,resto];
    }
    else{
        return null;
    }


}


function primero(array,s){
    for(let a of array){
        const r = a(s);
        if(r) return r;
    }
    return null;
}






const vocal = s => busca(vocales,s);
const consonante = s => busca(consonantes,s);
const dobleConsonante = s => busca(doblesConsonantes,s);
const trasVocal = s => busca(trasVocales,s);
   

const grupoConsonanticoInicial =
      s =>primero([dobleConsonante,consonante],s);

function grupoVocalico(s){
    const log = ()=>null;
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
          [s.substring(0,i),s.substring(i)] :
          null;
    log(`grupoVocalico: ${s} i:${i} ret:${ret}`);
    return ret;
    

    
 
}
grupoVocalico.toString = ()=> "grupoVocalico";

const silabas = [

    [s=>busca(silabasEspeciales,s)],
    [grupoVocalico],
    [grupoConsonanticoInicial,grupoVocalico],




    [grupoVocalico,trasVocal],    
    [grupoConsonanticoInicial,grupoVocalico,trasVocal],

 
];


function silaba(str){
    log(`silaba: str:${str}`);
    
    const ret = silabas.map(s=> secuencia(s,str)).
          filter(e=> e);
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
            const newSilabas = silabas.concat([s[0]]);
            const ret = palabraR(newSilabas, s[1]);
            if(ret){
                return ret;
            }
        }
        
        return null;
    }
    return palabraR([],str);
}

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


const log = (s)=> {
    console.log(s);;
};

const assert = (b) => {
    if(!b) {
        console.trace();
        throw("error");
    }
};


function secuencia(buscas,str){
    const log = ()=>null;
    log(`secuencia: str:${str}`);
    if(!str && buscas.length > 0){
        return null;
    }
    let resto = str;
    let ret = "";
    for(let b of buscas){
        log(`secuencia: str:${str} b:${b}`);
        const r = b(resto);
        if(!r){
            return null;
        }
        ret +=r[0];
        resto = r[1];
        
    }
    return [ret,resto];
}





function tests(){
    assert(vocal("abd")[0]=="a");
    assert(vocal("abd")[1]=="bd");

    assert(!vocal("cabd"));

    assert(secuencia([vocal,vocal],"aej")[1]=="j");
    assert(secuencia([vocal,vocal],"aej")[0]=="ae");
    assert(silaba("pepe").find(s=>s[0]=="pe"));

    assert(grupoVocalico("ab")[0]=="a");
    assert(grupoVocalico("aob")[0]=="ao");
    assert(grupoVocalico("baob")==null);


    
    function pruebaPalabra(array){
        const p = array.join("");
        const s = palabra(p);
        log(`pruebaPalabra: s:${s}`);
        console.log(`pruebaPalabra: ${p} -> ${s.join("-")}`);
        if(!arrayIgual(array,s)){
	    throw(s);
	}
    }

    
    pruebaPalabra(["pa","la", "bra"]);
    pruebaPalabra(["pe","pe"]);
    pruebaPalabra(["sal","chi","chón"]);
    pruebaPalabra(["ca","mión"]);
    pruebaPalabra(["con","se","guir"]);
    pruebaPalabra(["a","dic","ción"]);
    pruebaPalabra(["trans","por","te"]);
    pruebaPalabra(["trans", "at","lán","ti","co"]);
    pruebaPalabra(["ci","güe","ña"]);
    pruebaPalabra(["ahue","va","do"]);
    pruebaPalabra(["pers","pi","caz"]);
}



tests();
