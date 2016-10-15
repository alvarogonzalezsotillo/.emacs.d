STLFILE="poliedro-10.stl";
ANGLE=20;

rotate([ANGLE,0,0]){
     translate([0,0,0]) {
          import(STLFILE);
     }
}
