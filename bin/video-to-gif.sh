# https://superuser.com/questions/556029/how-do-i-convert-a-video-to-gif-using-ffmpeg-with-reasonable-quality
INPUT="$1"
OUTPUT="$2"
WIDTH="$3"
ffmpeg  -i "$INPUT" -vf "fps=10,scale=$WIDTH:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "$OUTPUT"
