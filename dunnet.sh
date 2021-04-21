#!/bin/bash

DUNNETOUT=dunnet.out
DUNNETLOG=dunnet.log

PAUSE_FACTOR=1
PAUSE_BEFORE_TYPING=$(echo "2.0 * $PAUSE_FACTOR" | bc )
PAUSE_BETWEN_KEYSTROKES=$(echo "0.05 * $PAUSE_FACTOR" | bc )
PAUSE_BEFORE_ENTER_KEY=$(echo "1.0 * $PAUSE_FACTOR" | bc )
PAUSE_BETWEEN_LINES=$(echo "10 * 0.2 * $PAUSE_FACTOR" | bc )
LINE_JUST_PRINTED=true


init_tput(){
    bgBlack=$(tput setab 0) # black
    bgRed=$(tput setab 1) # red
    bgGreen=$(tput setab 2) # green
    bgYellow=$(tput setab 3) # yellow
    bgBlue=$(tput setab 4) # blue
    bgMagenta=$(tput setab 5) # magenta
    bgCyan=$(tput setab 6) # cyan
    bgWhite=$(tput setab 7) # white

    # foreground color using ANSI escape

    fgBLack=$(tput setaf 0) # black
    fgRed=$(tput setaf 1) # red
    fgGreen=$(tput setaf 2) # green
    fgYellow=$(tput setaf 3) # yellow
    fgBlue=$(tput setaf 4) # blue
    fgMagenta=$(tput setaf 5) # magenta
    fgCyan=$(tput setaf 6) # cyan
    fgWhite=$(tput setaf 7) # white

    # text editing options

    txBold=$(tput bold)   # bold
    txHalf=$(tput dim)    # half-bright
    txUnderline=$(tput smul)   # underline
    txEndUnder=$(tput rmul)   # exit underline
    txReverse=$(tput rev)    # reverse
    txStandout=$(tput smso)   # standout
    txEndStand=$(tput rmso)   # exit standout
    txReset=$(tput sgr0)   # reset attributes
}

log(){
    echo $* >> "$DUNNETLOG"
}

clean_up(){
    log Finalizando script
    rm dunnet.in
    kill $(jobs -p)
}

set_up_fifo(){
    rm dunnet.in
    mkfifo dunnet.in
    sleep 60m > dunnet.in & #keep fifo open
}

send_to_fifo(){
    log "Enviando a dunnet: $*" 
    printf "%s\n" "$*" > dunnet.in
}

set_up(){
    echo > "$DUNNETLOG"
    log "Comienza script"
    trap clean_up EXIT
    set_line_just_printed    
}


last_output_line(){
    tail -n 2 "$DUNNETOUT" | head -n 2
}

get_pc_combination(){
    local msg=$(last_output_line)
    #The combination is XXX.
    log msg es $msg
    if [[ $msg == "The combination is"* ]]
    then
        combination=${msg:19:3}
        log Voy a leer la combinacion: $msg : $combination
    fi
}

string_contains(){
    local STR="$1"
    local PATTERN="$2"
    if echo "$STR" | grep -i "$PATTERN"
    then
        return 0
    else
        return 1
    fi
}

get_egg(){
    #if last_output_line | grep -i "egg"
    if string_contains "$(last_output_line)"  "There is a jewel-encrusted egg here"
    then
        log He encontrado el huevo enjoyado
        send_to_fifo_with_echo "take egg" "EGG FOUND!: "
    fi
}

responde_pregunta(){
    local pregunta=$(last_output_line)
    
    if [[ $pregunta == "What is your login name on the ‘endgame’ machine?"*  ]]
    then
        send_to_fifo_with_echo "answer toukmond" 
    fi
    if [[ $pregunta == "What type of bear was hiding your key?"* ]]
    then
        send_to_fifo_with_echo "answer grizzly"
    fi

    if [[ $pregunta == "How many corners are there in town (excluding the one with the Post Office)?"* ]]
    then
        send_to_fifo_with_echo "answer 24"
    fi

    if [[ $pregunta == "What is the last name of the author of EMACS?"* ]]
    then
        send_to_fifo_with_echo "answer Stallman"
    fi

    if [[ $pregunta == "treasures for points?"* ]]
    then
        send_to_fifo_with_echo "answer 4"
    fi
    if [[ $pregunta == "What is the nearest whole dollar to the price of the shovel?"* ]]
    then
        send_to_fifo_with_echo "answer 20"
    fi
    if [[ $pregunta == "Which street in town is named after a U.S. state?"* ]]
    then
        send_to_fifo_with_echo "answer Vermont"
    fi
    if [[ $pregunta == "What network protocol is used between pokey and gamma?"* ]]
    then
        send_to_fifo_with_echo "answer tcp"
    fi
    if [[ $pregunta == "How many pounds did the weight weigh?"* ]]
    then
        send_to_fifo_with_echo "answer 10"
    fi
    if [[ $pregunta == "What cartoon character is on the towel?"* ]]
    then
        send_to_fifo_with_echo "answer snoopy"
    fi
    if [[ $pregunta == "What is the name of the bus company serving the town?"* ]]
    then
        send_to_fifo_with_echo "answer mobytours"
    fi
    if [[ $pregunta == "What password did you use during anonymous ftp to gamma?"* ]]
    then
        send_to_fifo_with_echo "answer toukmond@pockey"
    fi
    if [[ $pregunta == "Name either of the two objects you found by digging."* ]]
    then
        send_to_fifo_with_echo "answer cpu"
    fi
    if [[ $pregunta == "Give either of the two last names in the mailroom, other than your own."* ]]
    then
        send_to_fifo_with_echo "answer Collier"
    fi
    if [[ $pregunta == "What is your password on the machine called ‘pokey’?"* ]]
    then
        send_to_fifo_with_echo "answer robert"
    fi
    if [[ $pregunta == "How many megabytes of memory is on the CPU board for the Vax?"* ]]
    then
        send_to_fifo_with_echo "answer 2"
    fi
    if [[ $pregunta == "Name the STREET which runs right over the subway stop."* ]]
    then
        send_to_fifo_with_echo "answer fourth"
    fi


}

wait_until_dunnet_start(){
    local pattern="Dead end"
    log "Esperando a que dunnet empiece... " $pattern
    (tail -f "$DUNNETOUT" &) | grep -q "$pattern"
    log "Dunnet ha empezado"
}


start_dunnet(){
    unalias emacs

    log "Deshabilito sleep-for usado para dar realismo al PC con floppy"
    lisp="(progn
      (defun sleep-for (seconds &optional millis)
         ;(message \"ignoro sleep-for\")
         nil)
      (dunnet))"

    emacs --no-init-file --batch --eval "$lisp" < dunnet.in | line_by_line_as_teletype | tee "$DUNNETOUT" &

    wait_until_dunnet_start
}


letter_by_letter_as_teletype(){
    local string="$*"
    sleep $PAUSE_BEFORE_TYPING
    for (( i=0; i<${#string}; i++ ))
    do
        printf "$txReverse$txBold"
        echo -n "${string:$i:1}"
        printf "$txReset"
        sleep $PAUSE_BETWEN_KEYSTROKES
    done
    sleep $PAUSE_BEFORE_ENTER_KEY
}

line_by_line_as_teletype(){
    while IFS='' read -r line || [[ -n "$line" ]]
    do
        printf "%s\n" "$line" 
        set_line_just_printed "true"
        sleep $PAUSE_BETWEEN_LINES
    done
}

set_line_just_printed(){
    if [ "$1" == "true" ]
    then
        touch line-just-printed-file
    else
        rm line-just-printed-file
    fi
}

is_line_just_printed(){
    test -e line-just-printed-file
}

wait_until_pause_in_line_by_line(){
    while is_line_just_printed
    do
        printf "ESPERO................"
        set_line_just_printed "false"
        sleep $PAUSE_BETWEEN_LINES
        sleep $PAUSE_BETWEEN_LINES
    done
}

send_to_fifo_with_echo(){
    local TO_FIFO=$1
    local PROMPT=${2:-""}
    letter_by_letter_as_teletype "$PROMPT" "$TO_FIFO"
    printf "$txReset\n\n\n"
    #sleep 1
    send_to_fifo $TO_FIFO
}

linea_a_linea(){
    while IFS='' read -r line || [[ -n "$line" ]]
    do

        
        #sleep 1
        
        if [[ $line == \>* ]]
        then  
            local ordenalpc=${line:1}
            send_to_fifo_with_echo "$ordenalpc" "I TYPE:"
            get_pc_combination
        elif [[ $line == \#* ]]
        then
            printf " ${fgBlue}COMMENT TO MYSELF: %s$txReset\n" "$line"
            printf ">"
        elif [[ "$line" != "" ]]
        then
            send_to_fifo_with_echo " $line"
            get_egg
            responde_pregunta
        fi

        wait_until_pause_in_line_by_line
    done 
}


init_tput

set_up

set_up_fifo

start_dunnet


linea_a_linea <<ENDOFGAME
take shovel
look shovel
east
east
dig
look
take cpu
look cpu
southeast
take food
southeast
look bear
drop food
look
take key
northwest
northwest
look
northeast
look
northeast
in
east
look bin
west
west
insert cpu into vax
type
toukmond
robert
ls
cd ..
ls
cd ..
ls
cd rooms
ls
cd hidden-area
ls
cat description
exit
e
s
look
sw
sw
se
se
sw
take bracelet
ne
nw
nw
ne
ne
in
w
look
type
cd /usr/toukmond
ls
uncompress paper.o.Z
exit
inventory
look paper
type
ftp gamma
anonymous
toukmond@pockey
help
type binary
send bracelet.o
send paper.o
send shovel.o
send key.o
send lamp.o
quit
ls
rlogin gamma
worms
take bracelet
take paper
take shovel
take key
take lamp
look bracelet
look lamp
look shovel
look key
east
east
look dial
turn dial counterclockwise
look
turn dial counterclockwise
look
turn dial counterclockwise
look
west
north
east
take weight
look weight
take life preserver
look life preserver
down
look button
press button

drop life preserver
drop bracelet
drop paper
drop shovel
drop key
up
take weight
down
put weight on button

nw
up
take floppy
take statuette
look statuette
# TENGO QUE VOLVER A LA SAUNA A FUNDIR LA STATUETTE
s
# ESTOY EN Maze little twisty passages
look
up
look
# ESTOY EN Maze thirsty little passages, al south little twisty, al se twenty little
se
look
# estoy en twenty little
down
look
# estoy en daze of twisty little, twisty little cabbages al nw
nw
look
# estoy en twisty little cabbages, reception area al nw
ne
# vuelvo a Weight room
w
s
drop floppy
e
# estoy en la sauna, a fundir la estatua
drop statuette
turn dial clockwise
turn dial clockwise
turn dial clockwise
take diamond
turn dial counterclockwise
turn dial counterclockwise
turn dial counterclockwise
turn dial counterclockwise
w
take floppy
look
north
east
down
look


# DESPUES DE ABRIR EL maze PILLO EL INVENTARIO
take life preserver
take bracelet
take paper
take shovel
take key

# ESTOY EN Maze button room
nw
up
s
up
se
down
nw
nw
# DEBERÍA ESTAR EN reception area


s
s
s
s
# PONGO TESOROS
put bracelet on chute
put diamond on chute

s
take gold bar
e
e
n
down
look painting
down
sw
e
up
look boulder


d
w
look
w
look
d
#empty room
n
e
s
n
e
s
look towel
take towel
down
n
n
u
look box
put key on box
look

# stair landing, box has exploded
u
u
ne
ne
get axe
look axe
d

#N/S/W Junction
n
look
d
sleep
# HAY QUE IR A LA HERRADURA Y ENTERRAR ALGO
d
sw
e
u
look
dig
look
take platinum bar
look platinum bar

# vuelvo a la habitación, creo que hay un baño
d
w
ne
u
s

# no sé que hacer con el urinal, lo he mirado en las pistas
put gold into urinal
flush urinal
put platinum into urinal
flush urinal  

# voy a mirar lo que me falta: long ns hallway
n
d
sw
w
d
e
d
look
s
s
s
look pc
insert floppy into pc

ENDOFGAME

linea_a_linea <<ENDOFGAME
# me pongo a teclear en el pc
>reset
>
>dir
>type foo.txt
>exit

look
# Dentro del bucle la combinación es: $combination
# Así que tengo que hacer otro bucle, porque la variable ya está sustituida
look
ENDOFGAME

echo aqui tengo la combinación: $combination
linea_a_linea <<ENDOFGAME
look
n
n
n
look
n
n
u
u
u
ne
ne
d
n
w
$combination
look ibm
cut cable with axe
ls 
exit
look
take key
e
look
n
take silver bar
take license
take lamp
w
put silver into mail drop
n

# estoy en las calles: main-maple
e
e
e
e
e
# he recorrido Maple

#empiezo en rejilla, nnnnn w sssss w nnnnn .....
#el huevo estará en algún sitio, se recogerá automáticamente cuando se vea
n
take coins

# miro el barranco
look cliff





n
n
# he llegado a sycamore con la quinta

w

s
s
s
s
s
s
w
n
n
n
n
n
n
w
s
s
s
s
s
s
w
n
n
n
n
w
s
s
s
w
w
n
n
n
n
n
# Estoy en main-sycamore, voy al inicio
s
s
s

# He recorrido todas las calles, ya debo tener en el huevo
# voy a por el autobús, a ver si entro por la reja de main-maple
e
e
e
e
e
n
n
n
look bus
in
s
s
s
w
w
w
w
w

# contra la valla
nw
out
n
take bone
look skeleton
e
e
take acid
push switch
n
take glycerine
w
get jar
take ruby
look jar
look ruby
look coins
look bone
look egg
s
w
look
# Estoy en la entrada del museo otra vez
inventory
# Voy a fourth and vermont
s 
se 
n
n
e
e
e
e
put acid in jar
put glycerine in jar
drop jar
in
n
n
put coins in garbage
put ruby in garbage
put egg in garbage
up
# Si entro a la puerta, vuelvo a la clase
down
down
take amethyst
up
put amethyst in garbage
down
ne
# Encuentro otro ordenador: endgame
# Voy a pokey a ver si hago ssh
sw
up
up
w
w
s
w
s
se
s
e
s
w
type
ssh endgame
take bracelet
take diamond
take gold
take platinum
take coins
take ruby
take egg
take amethyst
n
# aqui empiezan las preguntas
n

# Ya he respondido una pregunta
n

# Ya he respondido 2 preguntas
n
get bill
drop bill
drop bracelet
drop diamond
drop gold

n
take mona lisa
s
drop mona lisa

# voy a por los tesoros que faltan
s
s
s

s
take silver
take amethyst
take egg
n
n
n
n

drop silver
drop amethyst
drop egg

inventory
score
drop brass key
drop license
drop lamp
DROP bone
drop platinum bar
drop coins
drop ruby





quit
ENDOFGAME



exit

