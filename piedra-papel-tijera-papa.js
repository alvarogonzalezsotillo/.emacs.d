// https://www.pccomponentes.com/asus-be229qlb-monitor-led-215-negro 139€
// https://www.amazon.es/iiyama-Prolite-XUB2395WSU-B1-Pantalla-WUXGA/dp/B07F5858SR/ref=sr_1_1?hvadid=80814136567603&hvbmt=be&hvdev=c&hvqmt=e&keywords=monitor+ajustable+altura&qid=1575068563&refinements=p_n_feature_ten_browse-bin%3A13051393031%5Cc13051396031%5Cc13051398031%5Cc13051400031%2Cp_n_feature_browse-bin%3A949750031&rnid=949747031&s=computers&sr=1-1
// https://www.amazon.es/BenQ-BL2480T-Profesional-antirreflejos-Flicker-Free/dp/B07DLR7B89/ref=sr_1_5?fst=as%3Aoff&qid=1575294592&refinements=p_n_feature_ten_browse-bin%3A13051396031%5Cc13051398031&rnid=13051390031&s=computers&sr=1-5
const Vacio   = 0;
const Piedra  = 1;
const Papel   = 2;
const Tijera  = 3;
const Lagarto = 4;
const Spock   = 5;

const ColorParticipante = (function(){

    function rgb(r,g,b) {
        var r_ = check(decToHex(r));
        var g_ = check(decToHex(g));
        var b_ = check(decToHex(b));
        return "#"+r_+g_+b_;
    }

    function decToHex(n) {
        if(n<0){
            n = 0xFFFFFFFF + n + 1;
        }
        return Math.round(n).toString(16).toUpperCase();
    }

    function check(n){
        if(n.length>2){
            return "FF";
        }else if (n.length<2){
            return "0"+n;

        }else return n
    }

    return [
        rgb(255,0,255),
        rgb(99,99,99),
        rgb(200,200,200),
        rgb(235, 255, 100),
        rgb(50,200,50),
        rgb(100,100,255)
    ];
})();


function pelea(c1,c2){
    if(c1==c2) return 0;
    if(c1==Vacio) return 2;
    if(c2==Vacio) return 1;
    switch(c1){
    case Tijera:
        switch(c2){
        case Spock: return 2;
        case Lagarto: return 1;
        case Piedra: return 2;
        case Papel: return 1;
        }
    case Spock:
        switch(c2){
        case Tijera: return 1;
        case Lagarto: return 2;
        case Piedra: return 1;
        case Papel: return 2;
        }
    case Lagarto:
        switch(c2){
        case Tijera: return 2;
        case Spock: return 1;
        case Piedra: return 2;
        case Papel: return 1;
        }
    case Piedra:
        switch(c2){
        case Tijera: return 1;
        case Spock: return 2;
        case Lagarto: return 1;
        case Papel: return 2;
        }
    case Papel:
        switch(c2){
        case Tijera: return 2;
        case Spock: return 1;
        case Lagarto: return 2;
        case Piedra: return 1;
        }
    }
    
    console.log("me meurroooo")
}


class CampoDeBatalla{

    constructor(incremental,ancho,alto){
        this._columnas = [];
        this.borraCambios();
        this._incremental = incremental;
        if( ancho && alto ){
            this.reajusta(ancho,alto);
        }
    }

    azar(puntos){
        for(let i = 0 ; i <= 500 ; i++ ){
            const x = Math.floor( Math.random()*this.ancho);
            const y = Math.floor( Math.random()*this.alto);
            this.setCelda(x,y,i%6);
        }

    }
    
    get incremental(){
        return this._incremental;
    }

    get ancho(){
        return this._columnas.length;
    }

    get alto(){
        if( this._columnas[0] ){
            return this._columnas[0].length;
        }
        return 0;
    }

    get cambios(){
        return this._cambios;
    }

    borraCambios(){
        this._cambios = [];
    }

    celda(columna,fila){
        if( columna < 0 || columna >= this.ancho || fila < 0 || fila >= this.alto ){
            return Vacio;
        }
        return this._columnas[columna][fila];
    }

    setCelda(columna,fila,valor){
        if( columna < 0 || columna >= this.ancho || fila < 0 || fila >= this.alto ){
            //console.log(`Escritura fuera: ${columna} ${fila}`);
            return;
        }
        if( this.celda(columna,fila) != valor ){
            if( this._incremental ){
                this._cambios.push( [columna,fila] );
            }
            this._columnas[columna][fila] = valor;
        }
    }

    evoluciona(tableroDestino,opciones){
        const ret = tableroDestino || this.copia();
        ret.borraCambios();
        for( let c = 0 ; c < this.ancho; c++ ){
            for( let f = 0 ; f < this.alto ; f++ ){
                const nuevoValor = this.evolucionaCelda(c,f,opciones);
                ret.setCelda(c,f,nuevoValor);
            }
        }

        return ret;
    }

    
    evolucionaCelda(columna,fila,opciones){

        
        const radioLucha =  opciones.radioLucha || 2;
        const radioEmpate = opciones.radioEmpate || 2;
        const fGanado =  opciones.victoria || 1;
        const fPerdido =  opciones.derrota || 1;
        const fEmpatado =  opciones.empate || 0.5;


        
        const c1 = this.celda(columna,fila);
        let perdidas = [];
        let ganadas = 0;

        const radio = Math.max(radioLucha,radioEmpate);
        
        // PELEA CON LOS ALREDEDORES
        for( let c = -radio ; c <= radio ; c++ ){
            for( let f = -radio ; f <= radio ; f++ ){
                if( c == 0 && f == 0 ){
                    continue;
                }
                const distancia = Math.sqrt(c*c + f*f);
                if( distancia > radio ){
                    continue;
                }
                
                const c2 = this.celda(columna+c,fila+f);
                if( c2 == Vacio ){
                    continue;
                }
                
                const puntos = 1/(distancia*distancia);

                const resultado = pelea(c1,c2);
                if( resultado == 2 && distancia < radioLucha ){
                    if( !perdidas[c2] ){
                        perdidas[c2] = 0;
                    }
                    perdidas[c2] += puntos*fPerdido;
                }
                if( resultado == 1 && distancia < radioLucha ){
                    ganadas += puntos*fGanado;
                }
                if( resultado == 0 && distancia < radioEmpate ){
                    ganadas += puntos*fEmpatado;
                }
            }
        }

        // SI ALGÚN OTRO LE GANA MÁS DE LO QUE HA GANADO, DESAPARECE
        const maximoI = (function(){
            let max = -1;
            let ret = -1;
            for( let i = 0 ; i < perdidas.length ; i++ ){
                if( perdidas[i] > max ){
                    max = perdidas[i];
                    ret = i;
                }
            }
            return ret;
        })();

        if( maximoI <= 0 ){
            return c1;
        }

        const ventaja = ganadas - perdidas[maximoI];
        if( ventaja > 0 ){
            return c1;
        }
        else{
            return maximoI;
        }
    }
    
    vuelca(array, ancho, alto ){
        ancho = ancho || this.ancho;
        alto = alto || this.alto;
        
        array.length = ancho;
        for( let c = 0 ; c < ancho ;c++ ){
            if( !array[c] ){
                array[c] = new Array(alto);
            }
        }
        
        for( let c = 0 ; c < ancho ;c++ ){
            for( let f = 0 ; f < alto ; f++ ){
                array[c][f] = this.celda(c,f);
            }
        }
    }

    reajusta(columnas,filas){
        const nuevoColumnas = [];
        this.vuelca(nuevoColumnas,columnas,filas);
        this._columnas = nuevoColumnas;
    }

    copia(){
        const ret = new CampoDeBatalla(this._incremental);
        this.vuelca(ret._columnas,this.ancho,this.alto);
        return ret;
    }
}


class Canvas{
    constructor(canvas,pixelsCelda){
        this._canvas = canvas;
        this._ctx = this._canvas.getContext("2d");
    }

    get canvas(){
        return this._canvas;
    }

    resolucion(columnas,filas){
        this._canvas.width = columnas;
        this._canvas.height = filas;
    }

    pintaCelda(columna,fila,color){
        // console.log(`pintaCelda ${columna} ${fila} ${color}`);
        this._ctx.fillStyle = color;
        this._ctx.fillRect(columna,fila,1,1);
    }
}


class Entrada{
    constructor(keysElement, mouseElement){
        this._teclas = [];
        this._ratonx = 0;
        this._ratony = 0;
        keysElement.onkeyup = (e) => this._teclas[e.keyCode] = false;
        keysElement.onkeydown = (e) => this._teclas[e.keyCode] = true;

        mouseElement.addEventListener('mousemove', (e) => {
            this._ratonx = e.clientX;
            this._ratony = e.clientY;
        });

    }

    get teclas(){
        return this._teclas;
    }

    get raton(){
        return {x: this._ratonx, y:this._ratony};
    }
}

function campoACanvas(campo,canvas){


    const soloCambios = campo.incremental;

    
    function celdaACanvas(x,y){
        const c = campo.celda(x,y);
        const color = ColorParticipante[c];
        canvas.pintaCelda(x,y,color);
    }

    
    if( soloCambios ){
        for( let cambio of campo.cambios ){
            const x = cambio[0];
            const y = cambio[1];
            celdaACanvas(x,y);
        }            
    }
    else{
        for( let x = 0 ; x < campo.ancho ; x++ ){
            for( let y = 0 ; y < campo.alto; y++){
                celdaACanvas(x,y);
            }
        }
    }
    campo.borraCambios();
}


class Loop{
    constructor(campo,canvas,opciones){
        this._campo = campo;
        this._otroCampo = null;
        this._canvas = canvas;
        this._opciones = opciones;
        
        window.addEventListener("resize",()=>this.onResize(5));
        this.onResize();
    }

    onResize(retries){
        console.log("onResize loop");
        const canvasElement = this._canvas.canvas;

        const size = 8;
        const celdasAncho = Math.floor(canvasElement.clientWidth/size);
        const celdasAlto = Math.floor(canvasElement.clientHeight/size);

        console.log({
            cw : canvasElement.clientWidth,
            ch : canvasElement.clientHeight,
            celdasAncho : celdasAncho,
            celdasAlto : celdasAlto
        });

        if( canvasElement.width != celdasAncho ) canvasElement.width = celdasAncho;
        if( canvasElement.height != celdasAlto ) canvasElement.height = celdasAlto;
        campo.reajusta(celdasAncho,celdasAlto);
        if( this._otroCampo ){
            this._otroCampo.reajusta(celdasAncho,celdasAlto);
        }
        retries = retries || 0;
        if( retries > 0 ){
            setTimeout( ()=> this.onResize(retries-1), 1000);
        }
    }

    get opciones(){
        return  this._opciones.opciones;
    }
    paso(){
        const nuevoCampo = this._campo.evoluciona(this._otroCampo, this.opciones);
        campoACanvas(nuevoCampo,this._canvas);
        this._otroCampo = this._campo;
        this._campo = nuevoCampo;
    }

    loop(millis,countToZero){
        millis = millis || 500;
        if( countToZero == 1 ){
            return;
        }
        const nextCount = countToZero > 0 ? countToZero-1 : 0;
        this.paso();
        setTimeout(()=>this.loop(millis,nextCount),millis);
    }

}

class OpcionesCampoBatalla{


    constructor(element){
        this._element = element;
        this._radioLucha = 3;
        this._radioEmpate = 3;
        this._victoria = 2;
        this._derrota  = 1;
        this._empate   = 0.5;

        const frame = this.create("div",{
            style : {
                background: "rgba(255,255,255,0.5)",
                padding: "1em"
            }
        });

        const minimizable = this.create( "div",{
            className:"minimizable",
            style : {
                transition: "max-width 0.5s ease-in-out, max-height 0.5s ease-in-out",
            }
        });
        
        const grid = this.create( "div", {
            style : {
                display: "grid",
                gridTemplateColumns: "auto auto",
                alignItems: "center",
            }
            
        });

        const boton = this.create( "input",{
            type: "button",
            value : "≋",
            onclick : ()=> {
                minimizable.classList.toggle("minimizado");
            }
        });

        element.appendChild(frame);
        frame.appendChild(boton);
        frame.appendChild(minimizable);
        minimizable.appendChild(grid);
        
        this.creaRango(grid,"Radio lucha", 1, 1, 10, this._radioLucha, (v)=> this._radioLucha = v );
        this.creaRango(grid,"Radio empate", 1, 1, 10, this._radioEmpate, (v)=> this._radioEmpate = v );
        this.creaRango(grid,"Victoria", 0.1, -10, 10, this._victoria,  (v)=> this._victoria = v );
        this.creaRango(grid,"Derrota", 0.1, -10, 10, this._derrota,  (v)=> this._derrota = v );
        this.creaRango(grid,"Empate", 0.1, -10, 10, this._empate,  (v)=> this._empate = v );
    }

    create(tag, attrs){
        function applyStyle(elem,style){
            if( typeof style != "string" ){
                for( var s in style ){
                    elem.style[s] = style[s];
                }
            }
            else{
                elem.style = style;
            }
        }

        
        const ret = document.createElement(tag);
        for( var attr in attrs ){
            if( attr == "style" ){
                applyStyle(ret,attrs["style"]);
            }
            else{
                ret[attr] = attrs[attr];
            }
        }
        return ret;
    }

    
    creaRango(grid, nombre,paso,minimo,maximo,valor,callback){

        const row = 1+grid.childElementCount/2;
        
        const entrada = this.create("input",{
            type: "number",
            min: minimo,
            max: maximo,
            value: valor,
            step: paso,
            className: "opcion-numero",
            onchange : ()=> callback(entrada.value),
            style: {
                gridColumn: 2,
                gridRow: row
            }
        });
        const etiqueta = this.create("label", {
            innerHTML : nombre,
            htmlFor : entrada,
            className: "opcion-etiqueta",
            style: {
                gridColumn: 1,
                gridRow: row
            }
        });

        [etiqueta,entrada].forEach( (e)=> grid.appendChild(e) );
        
        return entrada;
    }

    get opciones(){
        return{
            radioLucha  : this._radioLucha,
            radioEmpate : this._radioEmpate,
            victoria : this._victoria,
            derrota  : this._derrota,
            empate   : this._empate
        };
    }
};


const canvas = new Canvas(document.getElementById("canvas"));
const entrada = new Entrada(window,canvas.canvas);




const campo = new CampoDeBatalla(true,400,200);

campo.azar(500);


const opciones = new OpcionesCampoBatalla(document.getElementById("opciones"));


const loop = new Loop(campo,canvas,opciones);

loop.loop(1);












