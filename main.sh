#!/bin/zsh

# Henry's Director Experiment Shell Interface
# By SirHenricus On Github, 10/2-3/26
# My second attempt at making a Shockwave extraction UI
# No AI was used
# MacOS, Wine and Zsh required

autoload -Uz colors && colors

echo " "
echo "***Henry's Director Experiment CLI***"
echo " "

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INPUT_DIR="$SCRIPT_DIR/input"
OUTPUT_DIR="$SCRIPT_DIR/output"
TANGSOUND="$SCRIPT_DIR/prog/TANG.WAV"

FILE=$2

filename="${FILE##*/}"
truncname="${filename%.*}"
filedir="${FILE:h}"

if [[ -z $FILE ]]; then
 echo "YOU DIDNT ENTER A FILE!"
 echo "Usage <option> <file>"
 echo "The options are 1 = director-files-extract, and 2 = projectorrays"
 return 0
else
 chmod +x $FILE
fi

# --- do the commands

if [[ $1 -eq 1 ]]; then
 # Director Files Extract
 echo "Director File Extract with $FILE"

 echo "${bg[red]}"
 python3 $SCRIPT_DIR/prog/shock.py $FILE
 echo "${reset_color}"

 # since shock.py doesn't automatically move whatever its output is to somewhere else like projectorrays does, I have to move the file myself.

 if mv "$filedir/$truncname"_out/ "$OUTPUT_DIR/"; then
   echo "Moved $filedir/$truncname_out To Output!"
 else
   echo "OOPS! Could not move to output"
   open $FILE
   return 0
 fi

 afplay "$TANGSOUND"
 open $OUTPUT_DIR
 return 1
elif [[ $1 -eq 2 ]]; then
 # Projector Rays
 echo "Projector Rays with $FILE"
 echo "May need to wait a bit..."
 
 echo "${bg[red]}"
 /usr/local/bin/wine $SCRIPT_DIR/prog/projectorrays.exe decompile $FILE -o $OUTPUT_DIR -v
 echo "${reset_color}"

 afplay "$TANGSOUND"
 open $OUTPUT_DIR
 return 1
else
 echo "Usage <option> <file>"
 echo "The options are 1 = director-files-extract, and 2 = projectorrays"
fi

 


