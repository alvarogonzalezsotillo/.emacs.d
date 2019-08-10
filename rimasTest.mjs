// -*- mode: js2; -*-

import{
    acentuaSilabas,
    palabraConHiatos,
    palabraSinHiatos,
    Palabra

} from "./rimas.mjs";

function tests(){

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
            console.trace();
            throw(s || "error");
        }
    };

    const assertEQ = (a,b) => assert(a==b,`${a} != ${b}`);


    
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
    PPH("co-me-rí-ais");


    console.log(new Palabra("marrón").silabas);
    console.log(new Palabra("marrón").acento);
    console.log(new Palabra("marrón").toString());
}

tests();
