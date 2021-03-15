#!/bin/bash
FILE="$1"
MIMETYPE=$(file --brief --mime-type "$FILE")
echo "data:$MIMETYPE;base64,$(base64 "$FILE" | tr -d '\r\n')"
echo "<img src=\"data:$MIMETYPE;base64,$(base64 "$FILE" | tr -d '\r\n')\">" | xclip -selection clipboard
