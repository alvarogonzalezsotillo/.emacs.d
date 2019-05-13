#!/bin/sh

ECHO(){
    /bin/echo $*
}

fondo_oscuro(){
    ECHO -en "\e]P0000000" #black
    ECHO -en "\e]P1D75F5F" #darkred
    ECHO -en "\e]P287AF5F" #darkgreen
    ECHO -en "\e]P3D7AF87" #brown
    ECHO -en "\e]P48787AF" #darkblue
    ECHO -en "\e]P5BD53A5" #darkmagenta
    ECHO -en "\e]P65FAFAF" #darkcyan
    ECHO -en "\e]P7E5E5E5" #lightgrey
    ECHO -en "\e]P82B2B2B" #darkgrey
    ECHO -en "\e]P9E33636" #red
    ECHO -en "\e]PA98E34D" #green
    ECHO -en "\e]PBFFD75F" #yellow
    ECHO -en "\e]PC7373C9" #blue
    ECHO -en "\e]PDD633B2" #magenta
    ECHO -en "\e]PE44C9C9" #cyan
    ECHO -en "\e]PFFFFFFF" #white
}

fondo_claro(){
    ECHO -en "\e]Pf000000" #black
    ECHO -en "\e]P9D75F5F" #darkred
    ECHO -en "\e]Pa87AF5F" #darkgreen
    ECHO -en "\e]PbD7AF87" #brown
    ECHO -en "\e]Pc8787AF" #darkblue
    ECHO -en "\e]PdBD53A5" #darkmagenta
    ECHO -en "\e]Pe5FAFAF" #darkcyan
    ECHO -en "\e]P8E5E5E5" #lightgrey
    ECHO -en "\e]P72B2B2B" #darkgrey
    ECHO -en "\e]P1E33636" #red
    ECHO -en "\e]P298E34D" #green
    ECHO -en "\e]P3FFD75F" #yellow
    ECHO -en "\e]P47373C9" #blue
    ECHO -en "\e]P5D633B2" #magenta
    ECHO -en "\e]P644C9C9" #cyan
    ECHO -en "\e]P0FFFFFF" #white

}

fuente_grande(){
    sudo setfont /usr/share/consolefonts/Lat2-TerminusBold28x14.psf.gz 
}


fondo_claro
fuente_grande
