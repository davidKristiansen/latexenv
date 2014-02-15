#!/bin/bash

# -----------------------------------------------------------------------------
# Checking for file dependencies
# -----------------------------------------------------------------------------
export conf_dir=$HOME/.config/latexenv
if [ ! -d "$conf_dir" ]; then
    mkdir $conf_dir
fi
export conf_file=$conf_dir/latexenv.conf
if [ ! -f "$conf_file" ]; then
    touch $conf_file
fi
. $conf_file
# -----------------------------------------------------------------------------

# Checking for user name
grep -q USER_NAME $conf_file && echo "User name found, using \"$USER_NAME"\" || (export user_full_name=$(getent passwd $USER | cut -d ':' -f 5 | sed 's/[,].*$//') && echo USER_NAME=\"$user_full_name\" >> $conf_file)

# -----------------------------------------------------------------------------
# Choose environment
# -----------------------------------------------------------------------------
env=$(zenity --list \
  --title="Choose the environment you want to use" \
  --column="Environment" --column="Description" \
    Homework "A homework environment" \
    Article "An article environment")

# Quit if canceled
if [ "$?" -ne 0 ]; then
    exit 0
fi

case $env in
    Homework*)
        sh homework/homework.sh
    ;;

    Article*)
        zenity --error \
            --text="Currently not in use!"
    ;;
esac

exit 0
