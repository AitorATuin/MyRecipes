#!/bin/sh

email=$1

[ "${email}EMPTY" = "EMPTY" ] && {
    echo "Usage:"
    echo
    echo ./noemail.sh email
    echo
    echo "Removes all references to email in Recipe files"
    exit 1
}

find -name Recipe | xargs -n 1 GrepReplace " <${email}>" ""
