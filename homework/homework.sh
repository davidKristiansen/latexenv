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
# This will become root dir!    assignment
ok=0
until [  $ok -eq 1 ]; do
    HOMEWORK_ASSIGNMENT=$(zenity --entry --entry-text="$HOMEWORK_ASSIGNMENT" --text="Input name of the assigment")
    quit_if_canceled $?

    if [ ! -d "$HOMEWORK_ASSIGNMENT" ]; then
        ok=1
    else
        if zenity --question --text="Assigement $HOMEWORK_ASSIGNMENT already exsists in folder\nContinue?"; then
        ok=1
        fi
    fi
done
# Substitute stored last dir
sed -i '/HOMEWORK_ASSIGNMENT/ d' "$conf_file"
echo HOMEWORK_ASSIGNMENT="\"$HOMEWORK_ASSIGNMENT\"" >> "$conf_file"
mkdir -p "$HOMEWORK_ASSIGNMENT"
cd "$HOMEWORK_ASSIGNMENT"
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
if [ ! -f "$preamble_file" ]; then
    cp $SCRIPT_DIR/homework/preamble.tex $inc_dir/
fi
if [ ! -f "$tikz_file" ]; then
    cp $SCRIPT_DIR/homework/tikz.tex $inc_dir/
fi
