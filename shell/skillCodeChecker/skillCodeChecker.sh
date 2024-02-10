#!/bin/bash
#--------------------------
# Program  : skill-utils(skillCodeChecker.sh)
# Language : Bash
# Author   : YEUNGCHIE
#--------------------------

unalias -a
app=$(basename $0)

if [[ -z $CDSHOME ]]; then
    echo "** $app: cannot found virtuoso environment variable CDSHOME" >&2
    exit 1
fi

for a in $@; do
    if [[ $a =~ ^-+h(elp)?$ ]]; then
        cat >&2 <<EOF
Usage: $app [file] [option] [-h]

    <file>                          Skill script file name.

Options:

    -ignore-hint
    -ignore-unused
    -ignore-error
    -ignore-variable <variable>
    -h, --help                      Show this help message and exit

Example:

    $app template_xxx.il
EOF
        exit 1
    fi
done

function main {
    local files
    unset ignores
    unset globals

    while [[ -n $1 ]]; do
        case $1 in
            -ignore-hint)
                ignores+=" hint"
            ;;
            -ignore-unused)
                ignores+=" unused"
            ;;
            -ignore-error)
                ignores+=" error"
            ;;
            -ignore-variable)
                shift
                globals+=" $1"
            ;;
            -*)
                echo "** $app: unknown option $1" >&2
                exit 1
            ;;
            *)
                files+=" $1"
            ;;
        esac
        shift
    done

    if [[ -z $files ]]; then
        echo "** $app: no input, Try '$app -h' for more information." >&2
        exit 1
    fi

    for f in $files; do
        if [[ ! -r $f ]]; then
            echo "** $app: file $f is not readable." >&2
            exit 1
        elif [[ ! -f $f ]]; then
            echo "** $app: file $f is not a regular file." >&2
            exit 1
        fi
    done

    check $files 2>/dev/null
}

function check {
    local files=$1

    $CDSHOME/bin/skill <<EOF
exit(
    sklint(
        ?file       parseString("$files")
        ?ignores    '($ignores)
        ?globals    '($globals)
    ) && 1 || 0
)
EOF
}

main $@ | grep -vP '^INFO\s+\(LoadFile\)'
