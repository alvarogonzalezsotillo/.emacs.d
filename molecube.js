
function cube(style,colorF,cellF){

    style = style || "border:none; display:block; width:100%; height=500px";
    cellF = cellF || function(x,y,z){ return "<sphere radius='.2'></sphere>"; };
    colorF = colorF || function(x,y,z){ return `${x/2.} ${y/2.} ${z/2.}`; };

    let sceneBegin = `<x3d style='${style}'><scene>`
    let sceneEnd = "</scene></x3d>";
    
    let celdas = [];
    for( let x = 0  ; x < 3 ; x++ ){
        for( let y = 0  ; y < 3 ; y++ ){
            for( let z = 0  ; z < 3 ; z++ ){
                if( !(x==1 && y==1 && z==1) ){
                    celdas.push( [x,y,z] );
                }
            }
        }
    }

    

    let ret = sceneBegin;
    for( let i = 0 ; i < celdas.length ; i++ ){
        
        let x = celdas[i][0];
        let y = celdas[i][1];
        let z = celdas[i][2];
        let color = colorF(x,y,z);
        let materialid = `m-${x}-${y}-${z}`;
        let cell = cellF(x,y,z);
        
        
        let shape = `
                   <transform translation='${2*x-2} ${2*y-2} ${2*z-2}'>
                     <shape>
                        <appearance>
                           <material id='${materialid}' diffuseColor='${color}'>
                           </material>
                        </appearance>
                        ${cell}
                     </shape>
                   </transform>  
                 `;
        ret += shape;
    }

    ret += sceneEnd;

    return ret;


}


function cube2(style,colors){

    if( colors.length != 26 ){
        throw "Se esperan 26 colores";
    }
    
    let sceneBegin = `<x3d style='${style}'><scene>`
    let sceneEnd = "</scene></x3d>";
    
    let celdas = [];
    for( let x = 0  ; x < 3 ; x++ ){
        for( let y = 0  ; y < 3 ; y++ ){
            for( let z = 0  ; z < 3 ; z++ ){
                if( !(x==1 && y==1 && z==1) ){
                    celdas.push( [x,y,z] );
                }
            }
        }
    }

    let ret = sceneBegin;
    for( let i = 0 ; i < colors.length ; i++ ){
        
        let x = celdas[i][0];
        let y = celdas[i][1];
        let z = celdas[i][2];
        let color = colors[i];
        let materialid = `m-${x}-${y}-${z}`;
        
        
        let shape = `
                   <transform translation='${2*x-2} ${2*y-2} ${2*z-2}'>
                     <shape>
                        <appearance>
                           <material id='${materialid}' diffuseColor='${color}'>
                           </material>
                        </appearance>
                        <sphere></sphere>
                     </shape>
                   </transform>  
                 `;
        ret += shape;
    }

    ret += sceneEnd;

    return ret;
}
