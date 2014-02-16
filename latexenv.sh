#!/bin/bash

quit_if_canceled () {
    # Quit if canceled
    if [ "$1" -ne 0 ]; then
        echo "Canceled!"
        exit 0
    fi
}

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

sed -i '/SCRIPT_DIR/ d' $conf_file
echo SCRIPT_DIR=\"$PWD\" >> $conf_file
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
# -----------------------------------------------------------------------------

quit_if_canceled $?

# Asking for user name, with default entry
USER_NAME=$(zenity --entry \
    --title="Your name" \
    --text="Enter your name" \
    --entry-text="$USER_NAME")

quit_if_canceled $?

# Substitute stored user name
sed -i '/USER_NAME/ d' $conf_file
echo USER_NAME=\"$USER_NAME\" >> $conf_file

# -----------------------------------------------------------------------------
case $env in
    Homework*)
        sh homework/homework.sh
    ;;

    Article*)
        zenity --error \
            --text="Currently not in use!"
    ;;
esac
# -----------------------------------------------------------------------------
exit 0
