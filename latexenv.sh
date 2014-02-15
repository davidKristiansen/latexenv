#!/bin/bash

env=$(zenity --list \
  --title="Choose the enviroment you want to use" \
  --column="Enviroment" --column="Description" \
    Homework "A homework enviroment" \
    Article "An article enviroment")

if [ "$?" -ne 0 ]; then
    exit 0
fi

case $env in
    Homework*)
        echo "chose Homework"
    ;;

    Article*)
        zenity --error \
            --text="Currently not in use yet!"
    ;;
esac

exit 0
