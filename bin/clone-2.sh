a33(){
    xrandr

    # OPTOMA
    # HDMI-2 connected 1280x800+1920+0 (normal left inverted right x axis y axis) 0mm x 0mm

    # DELL   
    # HDMI-3 connected 1600x900+3200+0 (normal left inverted right x axis y axis) 443mm x 249mm

    # LG GRANDE
    # DVI-1-0 connected primary 1920x1200+0+0 (normal left inverted right x axis y axis) 520mm x 330mm 
    #
}

clonar_2_de_3(){
    PROYECTOR=$1
    PANTALLACLONADA=$2
    PANTALLAPRIVADA=$3
    xrandr --output $PANTALLAPRIVADA --output $PROYECTOR --output $PANTALLACLONADA --same-as $PROYECTOR
}

#goldstar es el monitor grande DVI

OPTOMA=HDMI-2
MONITORGRANDE=DVI-1-0
MONITORPEQUENO=HDMI-3

xrandr --output $OPTOMA --mode 1280x1024
xrandr --output $MONITORPEQUENO --mode 1280x1024

clonar_2_de_3 $OPTOMA $MONITORPEQUENO $MONITORGRANDE


