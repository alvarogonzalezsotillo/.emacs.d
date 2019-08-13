// -*- mode: js2; -*-

import{
    palabraConHiatos,
    silabaTonica,
    Palabra,
    rimaConsonanteCon,
    rimasConsonantesCon,
    testExport

} from "./rimas.mjs";

function log(s){
    // console.log(s);
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




const assert = (b,s) => {
    if(!b) {
        console.log(`Assert failed:${s}`);
        console.trace();
        throw(s || "error");
    }
};

const assertEQ = (a,b) => assert(a==b,`${a} != ${b}`);



function PP(silabeado,separador,tonica){
    const array = silabeado.split("-");
    const p = array.join("");
    const s = separador(p);
    const test = s.join("-");
    log(`PP: s:${s}`);
    const t = silabaTonica(s);
    log(`pruebaPalabra: ${p} -> ${test} t:${t}`);
    if(silabeado != test){
	throw(s);
    }
    if(tonica >= 0 ){
        assertEQ(t,tonica);
    }
}


function PPT(silabeado,tonica){
    PP(silabeado,palabraConHiatos,tonica);
}

function testPalabra(){
    const P = (s)=>new Palabra(s);
    assertEQ(P("marrón").letraTonica,4);
    assertEQ(P("transporte").letraTonica,6);
    assertEQ(P("américa").letraTonica,2);
    assertEQ(P("armario").letraTonica,3);
    assertEQ(P("reinos").letraTonica,1);

    assert(rimaConsonanteCon("manolo","bolo"));
    assert(rimaConsonanteCon("manoló","voló"));
}

function testSilabeado(){

    PPT("ma-no-lo",1);
    PPT("pa-la-bra",1);
    PPT("pe-pe",0);
    PPT("sal-chi-chón",2);
    PPT("ca-mión",1);
    PPT("con-se-guir",2);
    PPT("a-dic-ción",2);
    PPT("trans-por-te",1);
    PPT("trans-at-lán-ti-co",2);
    PPT("ci-güe-ña",1);
    PPT("ahue-va-do",1);
    PPT("es-pec-ta-cu-lar",4);
    PPT("pers-pi-caz",2);
    PPT("e-rror",1);
    PPT("her-mo-su-ra",2);
    PPT("con-ver-sa-ción",3);
    PPT("per-se-gui-réis",3);
    PPT("ma-rí-a",1);
    PPT("rey",0);
    PPT("es-toy",1);
    PPT("pla-ya",0);
    PPT("pa-yo-yo",1);
    PPT("a-lla-nar",2);
    PPT("ca-mión",1);
    PPT("quie-tud",1);
    PPT("re-yer-ta",1);
    PPT("a-pa-re-ce-réis",4);
    PPT("hia-to",0);
    PPT("bien",0);
    PPT("dié-re-sis",0);
    PPT("i-gual-dad",2);
    PPT("co-me-rí-ais",2);
    PPT("pa-ra-guay", 2);
}

function testVocalTonica(){
    const vocalTonicaDeSilaba = testExport.vocalTonicaDeSilaba;

    assertEQ( vocalTonicaDeSilaba("a"), 0 );
    assertEQ( vocalTonicaDeSilaba("trans"), 2 );
    assertEQ( vocalTonicaDeSilaba("ciu"), 2 );
    assertEQ( vocalTonicaDeSilaba("coe"), 2 );
    assertEQ( vocalTonicaDeSilaba("cíe"), 1 );
}

testSilabeado();
testPalabra();

testVocalTonica();

console.log("Probando generator");
for( let p of rimasConsonantesCon("reinos",5) ){
    console.log(p);
}
console.log("Probado generator");

