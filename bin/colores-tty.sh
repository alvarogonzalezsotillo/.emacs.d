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

fuentes_centos(){
cat <<EOF
/usr/lib/kbd/consolefonts
/usr/lib/kbd/consolefonts/161.cp.gz
/usr/lib/kbd/consolefonts/162.cp.gz
/usr/lib/kbd/consolefonts/163.cp.gz
/usr/lib/kbd/consolefonts/164.cp.gz
/usr/lib/kbd/consolefonts/165.cp.gz
/usr/lib/kbd/consolefonts/737.cp.gz
/usr/lib/kbd/consolefonts/880.cp.gz
/usr/lib/kbd/consolefonts/928.cp.gz
/usr/lib/kbd/consolefonts/972.cp.gz
/usr/lib/kbd/consolefonts/Agafari-12.psfu.gz
/usr/lib/kbd/consolefonts/Agafari-14.psfu.gz
/usr/lib/kbd/consolefonts/Agafari-16.psfu.gz
/usr/lib/kbd/consolefonts/Cyr_a8x14.psfu.gz
/usr/lib/kbd/consolefonts/Cyr_a8x16.psfu.gz
/usr/lib/kbd/consolefonts/Cyr_a8x8.psfu.gz
/usr/lib/kbd/consolefonts/ERRORS
/usr/lib/kbd/consolefonts/Goha-12.psfu.gz
/usr/lib/kbd/consolefonts/Goha-14.psfu.gz
/usr/lib/kbd/consolefonts/Goha-16.psfu.gz
/usr/lib/kbd/consolefonts/GohaClassic-12.psfu.gz
/usr/lib/kbd/consolefonts/GohaClassic-14.psfu.gz
/usr/lib/kbd/consolefonts/GohaClassic-16.psfu.gz
/usr/lib/kbd/consolefonts/Lat2-Terminus16.psfu.gz
/usr/lib/kbd/consolefonts/LatArCyrHeb-08.psfu.gz
/usr/lib/kbd/consolefonts/LatArCyrHeb-14.psfu.gz
/usr/lib/kbd/consolefonts/LatArCyrHeb-16+.psfu.gz
/usr/lib/kbd/consolefonts/LatArCyrHeb-16.psfu.gz
/usr/lib/kbd/consolefonts/LatArCyrHeb-19.psfu.gz
/usr/lib/kbd/consolefonts/LatGrkCyr-12x22.psfu.gz
/usr/lib/kbd/consolefonts/LatGrkCyr-8x16.psfu.gz
/usr/lib/kbd/consolefonts/LatKaCyrHeb-14.psfu.gz
/usr/lib/kbd/consolefonts/Mik_8x16.gz
/usr/lib/kbd/consolefonts/README.12x22
/usr/lib/kbd/consolefonts/README.Arabic
/usr/lib/kbd/consolefonts/README.Cyrillic
/usr/lib/kbd/consolefonts/README.Ethiopic
/usr/lib/kbd/consolefonts/README.Greek
/usr/lib/kbd/consolefonts/README.Hebrew
/usr/lib/kbd/consolefonts/README.Lat2-Terminus16
/usr/lib/kbd/consolefonts/README.LatGrkCyr
/usr/lib/kbd/consolefonts/README.cp1250
/usr/lib/kbd/consolefonts/README.cybercafe
/usr/lib/kbd/consolefonts/README.drdos
/usr/lib/kbd/consolefonts/README.lat0
/usr/lib/kbd/consolefonts/README.lat7
/usr/lib/kbd/consolefonts/README.lat9
/usr/lib/kbd/consolefonts/README.psfu
/usr/lib/kbd/consolefonts/UniCyrExt_8x16.psf.gz
/usr/lib/kbd/consolefonts/UniCyr_8x14.psf.gz
/usr/lib/kbd/consolefonts/UniCyr_8x16.psf.gz
/usr/lib/kbd/consolefonts/UniCyr_8x8.psf.gz
/usr/lib/kbd/consolefonts/alt-8x14.gz
/usr/lib/kbd/consolefonts/alt-8x16.gz
/usr/lib/kbd/consolefonts/alt-8x8.gz
/usr/lib/kbd/consolefonts/altc-8x16.gz
/usr/lib/kbd/consolefonts/aply16.psf.gz
/usr/lib/kbd/consolefonts/arm8.fnt.gz
/usr/lib/kbd/consolefonts/cp1250.psfu.gz
/usr/lib/kbd/consolefonts/cp850-8x14.psfu.gz
/usr/lib/kbd/consolefonts/cp850-8x16.psfu.gz
/usr/lib/kbd/consolefonts/cp850-8x8.psfu.gz
/usr/lib/kbd/consolefonts/cp857.08.gz
/usr/lib/kbd/consolefonts/cp857.14.gz
/usr/lib/kbd/consolefonts/cp857.16.gz
/usr/lib/kbd/consolefonts/cp865-8x14.psfu.gz
/usr/lib/kbd/consolefonts/cp865-8x16.psfu.gz
/usr/lib/kbd/consolefonts/cp865-8x8.psfu.gz
/usr/lib/kbd/consolefonts/cp866-8x14.psf.gz
/usr/lib/kbd/consolefonts/cp866-8x16.psf.gz
/usr/lib/kbd/consolefonts/cp866-8x8.psf.gz
/usr/lib/kbd/consolefonts/cybercafe.fnt.gz
/usr/lib/kbd/consolefonts/cyr-sun16.psfu.gz
/usr/lib/kbd/consolefonts/default8x16.psfu.gz
/usr/lib/kbd/consolefonts/default8x9.psfu.gz
/usr/lib/kbd/consolefonts/drdos8x14.psfu.gz
/usr/lib/kbd/consolefonts/drdos8x16.psfu.gz
/usr/lib/kbd/consolefonts/drdos8x6.psfu.gz
/usr/lib/kbd/consolefonts/drdos8x8.psfu.gz
/usr/lib/kbd/consolefonts/eurlatgr.psfu.gz
/usr/lib/kbd/consolefonts/gr737a-8x8.psfu.gz
/usr/lib/kbd/consolefonts/gr737a-9x14.psfu.gz
/usr/lib/kbd/consolefonts/gr737a-9x16.psfu.gz
/usr/lib/kbd/consolefonts/gr737b-8x11.psfu.gz
/usr/lib/kbd/consolefonts/gr737b-9x16-medieval.psfu.gz
/usr/lib/kbd/consolefonts/gr737c-8x14.psfu.gz
/usr/lib/kbd/consolefonts/gr737c-8x16.psfu.gz
/usr/lib/kbd/consolefonts/gr737c-8x6.psfu.gz
/usr/lib/kbd/consolefonts/gr737c-8x7.psfu.gz
/usr/lib/kbd/consolefonts/gr737c-8x8.psfu.gz
/usr/lib/kbd/consolefonts/gr737d-8x16.psfu.gz
/usr/lib/kbd/consolefonts/gr928-8x16-thin.psfu.gz
/usr/lib/kbd/consolefonts/gr928-9x14.psfu.gz
/usr/lib/kbd/consolefonts/gr928-9x16.psfu.gz
/usr/lib/kbd/consolefonts/gr928a-8x14.psfu.gz
/usr/lib/kbd/consolefonts/gr928a-8x16.psfu.gz
/usr/lib/kbd/consolefonts/gr928b-8x14.psfu.gz
/usr/lib/kbd/consolefonts/gr928b-8x16.psfu.gz
/usr/lib/kbd/consolefonts/greek-polytonic.psfu.gz
/usr/lib/kbd/consolefonts/iso01-12x22.psfu.gz
/usr/lib/kbd/consolefonts/iso01.08.gz
/usr/lib/kbd/consolefonts/iso01.14.gz
/usr/lib/kbd/consolefonts/iso01.16.gz
/usr/lib/kbd/consolefonts/iso02-12x22.psfu.gz
/usr/lib/kbd/consolefonts/iso02.08.gz
/usr/lib/kbd/consolefonts/iso02.14.gz
/usr/lib/kbd/consolefonts/iso02.16.gz
/usr/lib/kbd/consolefonts/iso03.08.gz
/usr/lib/kbd/consolefonts/iso03.14.gz
/usr/lib/kbd/consolefonts/iso03.16.gz
/usr/lib/kbd/consolefonts/iso04.08.gz
/usr/lib/kbd/consolefonts/iso04.14.gz
/usr/lib/kbd/consolefonts/iso04.16.gz
/usr/lib/kbd/consolefonts/iso05.08.gz
/usr/lib/kbd/consolefonts/iso05.14.gz
/usr/lib/kbd/consolefonts/iso05.16.gz
/usr/lib/kbd/consolefonts/iso06.08.gz
/usr/lib/kbd/consolefonts/iso06.14.gz
/usr/lib/kbd/consolefonts/iso06.16.gz
/usr/lib/kbd/consolefonts/iso07.14.gz
/usr/lib/kbd/consolefonts/iso07.16.gz
/usr/lib/kbd/consolefonts/iso07u-16.psfu.gz
/usr/lib/kbd/consolefonts/iso08.08.gz
/usr/lib/kbd/consolefonts/iso08.14.gz
/usr/lib/kbd/consolefonts/iso08.16.gz
/usr/lib/kbd/consolefonts/iso09.08.gz
/usr/lib/kbd/consolefonts/iso09.14.gz
/usr/lib/kbd/consolefonts/iso09.16.gz
/usr/lib/kbd/consolefonts/iso10.08.gz
/usr/lib/kbd/consolefonts/iso10.14.gz
/usr/lib/kbd/consolefonts/iso10.16.gz
/usr/lib/kbd/consolefonts/koi8-14.psf.gz
/usr/lib/kbd/consolefonts/koi8c-8x16.gz
/usr/lib/kbd/consolefonts/koi8r-8x14.gz
/usr/lib/kbd/consolefonts/koi8r-8x16.gz
/usr/lib/kbd/consolefonts/koi8r-8x8.gz
/usr/lib/kbd/consolefonts/koi8r.8x8.psfu.gz
/usr/lib/kbd/consolefonts/koi8u_8x14.psfu.gz
/usr/lib/kbd/consolefonts/koi8u_8x16.psfu.gz
/usr/lib/kbd/consolefonts/koi8u_8x8.psfu.gz
/usr/lib/kbd/consolefonts/lat0-08.psfu.gz
/usr/lib/kbd/consolefonts/lat0-10.psfu.gz
/usr/lib/kbd/consolefonts/lat0-12.psfu.gz
/usr/lib/kbd/consolefonts/lat0-14.psfu.gz
/usr/lib/kbd/consolefonts/lat0-16.psfu.gz
/usr/lib/kbd/consolefonts/lat0-sun16.psfu.gz
/usr/lib/kbd/consolefonts/lat1-08.psfu.gz
/usr/lib/kbd/consolefonts/lat1-10.psfu.gz
/usr/lib/kbd/consolefonts/lat1-12.psfu.gz
/usr/lib/kbd/consolefonts/lat1-14.psfu.gz
/usr/lib/kbd/consolefonts/lat1-16.psfu.gz
/usr/lib/kbd/consolefonts/lat2-08.psfu.gz
/usr/lib/kbd/consolefonts/lat2-10.psfu.gz
/usr/lib/kbd/consolefonts/lat2-12.psfu.gz
/usr/lib/kbd/consolefonts/lat2-14.psfu.gz
/usr/lib/kbd/consolefonts/lat2-16.psfu.gz
/usr/lib/kbd/consolefonts/lat2-sun16.psfu.gz
/usr/lib/kbd/consolefonts/lat2a-16.psfu.gz
/usr/lib/kbd/consolefonts/lat4-08.psfu.gz
/usr/lib/kbd/consolefonts/lat4-10.psfu.gz
/usr/lib/kbd/consolefonts/lat4-12.psfu.gz
/usr/lib/kbd/consolefonts/lat4-14.psfu.gz
/usr/lib/kbd/consolefonts/lat4-16+.psfu.gz
/usr/lib/kbd/consolefonts/lat4-16.psfu.gz
/usr/lib/kbd/consolefonts/lat4-19.psfu.gz
/usr/lib/kbd/consolefonts/lat4a-08.psfu.gz
/usr/lib/kbd/consolefonts/lat4a-10.psfu.gz
/usr/lib/kbd/consolefonts/lat4a-12.psfu.gz
/usr/lib/kbd/consolefonts/lat4a-14.psfu.gz
/usr/lib/kbd/consolefonts/lat4a-16+.psfu.gz
/usr/lib/kbd/consolefonts/lat4a-16.psfu.gz
/usr/lib/kbd/consolefonts/lat4a-19.psfu.gz
/usr/lib/kbd/consolefonts/lat5-12.psfu.gz
/usr/lib/kbd/consolefonts/lat5-14.psfu.gz
/usr/lib/kbd/consolefonts/lat5-16.psfu.gz
/usr/lib/kbd/consolefonts/lat7-14.psfu.gz
/usr/lib/kbd/consolefonts/lat7a-14.psfu.gz
/usr/lib/kbd/consolefonts/lat7a-16.psf.gz
/usr/lib/kbd/consolefonts/lat9-08.psf.gz
/usr/lib/kbd/consolefonts/lat9-10.psf.gz
/usr/lib/kbd/consolefonts/lat9-12.psf.gz
/usr/lib/kbd/consolefonts/lat9-14.psf.gz
/usr/lib/kbd/consolefonts/lat9-16.psf.gz
/usr/lib/kbd/consolefonts/lat9u-08.psfu.gz
/usr/lib/kbd/consolefonts/lat9u-10.psfu.gz
/usr/lib/kbd/consolefonts/lat9u-12.psfu.gz
/usr/lib/kbd/consolefonts/lat9u-14.psfu.gz
/usr/lib/kbd/consolefonts/lat9u-16.psfu.gz
/usr/lib/kbd/consolefonts/lat9v-08.psfu.gz
/usr/lib/kbd/consolefonts/lat9v-10.psfu.gz
/usr/lib/kbd/consolefonts/lat9v-12.psfu.gz
/usr/lib/kbd/consolefonts/lat9v-14.psfu.gz
/usr/lib/kbd/consolefonts/lat9v-16.psfu.gz
/usr/lib/kbd/consolefonts/lat9w-08.psfu.gz
/usr/lib/kbd/consolefonts/lat9w-10.psfu.gz
/usr/lib/kbd/consolefonts/lat9w-12.psfu.gz
/usr/lib/kbd/consolefonts/lat9w-14.psfu.gz
/usr/lib/kbd/consolefonts/lat9w-16.psfu.gz
/usr/lib/kbd/consolefonts/latarcyrheb-sun16.psfu.gz
/usr/lib/kbd/consolefonts/latarcyrheb-sun32.psfu.gz
/usr/lib/kbd/consolefonts/partialfonts
/usr/lib/kbd/consolefonts/ruscii_8x16.psfu.gz
/usr/lib/kbd/consolefonts/ruscii_8x8.psfu.gz
/usr/lib/kbd/consolefonts/sun12x22.psfu.gz
/usr/lib/kbd/consolefonts/t.fnt.gz
/usr/lib/kbd/consolefonts/t850b.fnt.gz
/usr/lib/kbd/consolefonts/tcvn8x16.psf.gz
/usr/lib/kbd/consolefonts/viscii10-8x16.psfu.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-1.a0-ff.08.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-1.a0-ff.14.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-1.a0-ff.16.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-10.a0-ff.08.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-10.a0-ff.14.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-10.a0-ff.16.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-2.a0-ff.08.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-2.a0-ff.14.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-2.a0-ff.16.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-3.a0-ff.08.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-3.a0-ff.14.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-3.a0-ff.16.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-4.a0-ff.08.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-4.a0-ff.14.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-4.a0-ff.16.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-5.a0-ff.08.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-5.a0-ff.14.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-5.a0-ff.16.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-6.a0-ff.08.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-6.a0-ff.14.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-6.a0-ff.16.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-7.a0-ff.08.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-7.a0-ff.14.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-7.a0-ff.16.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-8.a0-ff.08.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-8.a0-ff.14.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-8.a0-ff.16.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-9.a0-ff.08.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-9.a0-ff.14.gz
/usr/lib/kbd/consolefonts/partialfonts/8859-9.a0-ff.16.gz
/usr/lib/kbd/consolefonts/partialfonts/ascii.20-7f.08.gz
/usr/lib/kbd/consolefonts/partialfonts/ascii.20-7f.14.gz
/usr/lib/kbd/consolefonts/partialfonts/ascii.20-7f.16.gz
/usr/lib/kbd/consolefonts/partialfonts/cp437.00-1f.08.gz
/usr/lib/kbd/consolefonts/partialfonts/cp437.00-1f.14.gz
/usr/lib/kbd/consolefonts/partialfonts/cp437.00-1f.16.gz
/usr/lib/kbd/consolefonts/partialfonts/none.00-17.08.gz
/usr/lib/kbd/consolefonts/partialfonts/none.00-17.14.gz
/usr/lib/kbd/consolefonts/partialfonts/none.00-17.16.gz
EOF
}

fuente_big(){
  sudo setfont /usr/share/consolefonts/Lat2-TerminusBold28x14.psf.gz
  sudo setfont /usr/lib/kbd/consolefonts/lat2-16.psfu.gz
}

fuente_small(){
  sudo setfont /usr/share/consolefonts/Lat2-Terminus12x6.psf.gz
  sudo setfont /usr/lib/kbd/consolefonts/lat4-08.psfu.gz
}


fondo_claro
fuente_big
