#!/bin/bash

. $conf_file

quit_if_canceled () {
    # Quit if canceled
    if [ "$1" -ne 0 ]; then
        echo "Canceled!"
        exit 0
    fi
}

# -----------------------------------------------------------------------------
# Setting up variables
# -----------------------------------------------------------------------------
build_dir=build
inc_dir=include
res_dir=res
src_dir=src
latexmkrc_file=latexmkrc
main_file=main.tex
preamble_file="$inc_dir/preamble.tex"
tikz_file="$inc_dir/tikz.tex"
problem_file="$src_dir/problem.tex"
solution_file="$src_dir/solution.tex"
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
#
# -----------------------------------------------------------------------------
HOMEWORK_DIR=$(zenity --file-selection --directory --filename="$HOMEWORK_DIR" --title="Choose where to set up homework environment")

quit_if_canceled $?

# Substitute stored last dir
sed -i '/HOMEWORK_DIR/ d' $conf_file
echo HOMEWORK_DIR="\"$HOMEWORK_DIR\"" >> "$conf_file"
cd "$HOMEWORK_DIR"
# -----------------------------------------------------------------------------
HOMEWORK_ASSIGEMENT=$(zenity --entry --entry-text="$HOMEWORK_ASSIGEMENT" --text="Input name of the assigment")

quit_if_canceled $?

# Substitute stored last dir
sed -i '/HOMEWORK_ASSIGEMENT/ d' "$conf_file"
echo HOMEWORK_ASSIGEMENT="\"$HOMEWORK_ASSIGEMENT\"" >> "$conf_file"
mkdir -p "$HOMEWORK_ASSIGEMENT"
cd "$HOMEWORK_ASSIGEMENT"
# -----------------------------------------------------------------------------
HOMEWORK_NR=$(zenity --entry --text="Number of questions")

quit_if_canceled $?
# -----------------------------------------------------------------------------
HOMEWORK_DUEDATE=$(zenity --calendar --title="Due date")

quit_if_canceled $?
# -----------------------------------------------------------------------------
# Setting up root dir
# -----------------------------------------------------------------------------
mkdir -p "$build_dir"

mkdir -p "$inc_dir"

mkdir -p "$src_dir"
mkdir -p "$src_dir/tikz"

mkdir -p "$res_dir"
mkdir -p "$res_dir/pictures"
# -----------------------------------------------------------------------------
cd $inc_dir
