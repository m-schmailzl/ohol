#!/bin/bash
# allows navigating to all time based transitions and decide which to disable

OUTPUT_FILE="decayTransitions.txt"
TRANSITIONS_PATH="OneLifeData7/transitions"
OBJECTS_PATH="OneLifeData7/objects"
MIN_TIME=1800
SKIP_IF_IN_LIST=1

get_name() {
    if [ "$1" == 0 ]; then
        echo "Nothing"
        return 0
    fi
    if [ -f "$OBJECTS_PATH/$1.txt" ]; then
        head -2 "$OBJECTS_PATH/$1.txt" | tail -1
        return 0
    fi
    echo "ID $1"
}

OUTPUT_FILE=$(realpath "$OUTPUT_FILE")
OBJECTS_PATH=$(realpath "$OBJECTS_PATH")

cd "$TRANSITIONS_PATH"
for file in -1_*; do
    # ignore files with additional text (animations)
    if ! [[ $file =~ -1_([0-9]+)\.txt ]]; then
        continue
    fi

    from="${BASH_REMATCH[1]}"
    content=$(cat -- "$file" | head -1)
    to=$(echo "$content" | awk '{print $2}')
    time=$(echo "$content" | awk '{print $3}')
    
    # time < 0 is in hours
    if (( time < 0 )); then
        (( time *= -3600 ))
    fi

    # ignore transitions under MIN_TIME seconds
    if (( time < MIN_TIME )); then
        continue
    fi 

    # skip if already in output file
    if [ "$SKIP_IF_IN_LIST" == 1 ] && grep -F -q -- "$file" "$OUTPUT_FILE"; then 
        continue
    fi

    read -p "Change <$(get_name $from)>($from) to <$(get_name $to)>($to) after $time seconds? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "$file" >> "$OUTPUT_FILE"
    fi
done