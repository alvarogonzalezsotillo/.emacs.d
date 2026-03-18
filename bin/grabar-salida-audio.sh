
pactl list short sources



OUTPUT=output.wav
if [ "$1" != "" ]
then
    OUTPUT="$1"
fi

DEVICE="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink.monitor"

parecord -d  "$DEVICE" "$OUTPUT"
