// -*- mode: js2; -*-

import {Palabra} from "./rimas.mjs";
import {corpus as corpusByLength} from "./corpus-by-length.mjs";
import {default as fs} from "fs";

const corpusBySyllableFull = [];
const corpusBySyllable = [];

function addToCorpus(p){
    const palabra = new Palabra(p);

    if( !palabra.silabas ){
        return false;
    }
    
    const l = palabra.silabas.length;

    let arrayFull = corpusBySyllableFull[l-1];
    if( !arrayFull ){
        arrayFull = [];
        corpusBySyllableFull[l-1] = arrayFull;
    }
    let array = corpusBySyllable[l-1];
    if( !array ){
        array = [];
        corpusBySyllable[l-1] = array;
    }


    arrayFull.push(palabra.asPlainObject);
    array.push(p);
    
    return true;
}

for( let i in corpusByLength ){
    for(let p of corpusByLength[i]){
        addToCorpus(p);
    }
        
    console.log(`WARN: ${i}`);

}

console.log( "WARN: to JSON file...");
fs.writeFile(
    "corpus-by-syllable-full.json",
    "// -*- mode: fundamental; -*-\n" + JSON.stringify(corpusBySyllableFull,null,2),
    (error)=>{
    if(error){
        console.log(`ERROR: ${error}`);
    }
    console.log("OK");
} );

fs.writeFile(
    "corpus-by-syllable.json",
    "// -*- mode: fundamental; -*-\n" + JSON.stringify(corpusBySyllable,null,2),
    (error)=>{
    if(error){
        console.log(`ERROR: ${error}`);
    }
    console.log("OK");
} );

fs.writeFile(
    "corpus-by-syllable-no-pp.json",
    "// -*- mode: fundamental; -*-\n" + JSON.stringify(corpusBySyllable),
    (error)=>{
    if(error){
        console.log(`ERROR: ${error}`);
    }
    console.log("OK");
} );

