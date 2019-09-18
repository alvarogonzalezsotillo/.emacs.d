// -*- mode: js2; -*-

import {Palabra} from "./rimas.mjs";
import {corpusByFrequency} from "./corpus-by-frequency.mjs";
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

    if( array.length % 10000 == 1 ){
        console.log(p);
    }
    
    return true;
}

for(let p of corpusByFrequency){
    addToCorpus(p);
}

const header = "// -*- mode: fundamental;coding:utf-8 -*-\nexport const corpus = ";

console.log( "WARN: to MJS file...");
fs.writeFile(
    "corpus-by-syllable-full.mjs",
    header + JSON.stringify(corpusBySyllableFull,null,2),
    (error)=>{
    if(error){
        console.log(`ERROR: ${error}`);
    }
    console.log("OK");
} );

fs.writeFile(
    "corpus-by-syllable.mjs",
    header + JSON.stringify(corpusBySyllable,null,2),
    (error)=>{
    if(error){
        console.log(`ERROR: ${error}`);
    }
    console.log("OK");
} );

fs.writeFile(
    "corpus-by-syllable-no-pp.mjs",
    header + JSON.stringify(corpusBySyllable),
    (error)=>{
    if(error){
        console.log(`ERROR: ${error}`);
    }
    console.log("corpus-by-syllable-no-pp.mjs OK");
} );

