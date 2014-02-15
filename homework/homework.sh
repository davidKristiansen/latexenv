#!/bin/bash
. $conf_file

# Asking for user name, with default entry
USER_NAME=$(zenity --entry \
    --title="Your name" \
    --text="Enter your name" \
    --entry-text="$USER_NAME")

# Quit if canceled
if [ "$?" -ne 0 ]; then
    echo "Cancelled"
    exit 0
fi

# Subtitute strored user name
sed -i '/USER_NAME/ d' $conf_file
echo USER_NAME=\"$USER_NAME\" >> $conf_file
