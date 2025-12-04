# https://www.reinefjord.net/notes/buggy-trackpoint.html
echo -n "serio1" | sudo tee /sys/bus/serio/drivers/psmouse/unbind
