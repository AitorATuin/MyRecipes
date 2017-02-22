#!/bin/bash

#
# Small script to review recipes
#

function error() {
    local message=$1
    echo "Error: $1"
    exit 1
}

#
# $1 <- Program name
# $2 <- Program version
function main() {
    [ $# -eq 2 ] || {
        error "Usage: $0 program version"
    }
    local program=$1
    local version=$2
    local reviewed_recipe=Reviewed/${program}/${version}
    local local_recipe=LocalRecipes/${program}/${version}

    echo "Reviewing ${program} ${version}"

    # Local recipe does not exists!
    [ -d ${local_recipe} ] || {
        error "Program ${program} ${version} is not a local recipe"
    }

    # Recipe version already reviewed
    [ -d ${reviewed_recipe} ] && {
        error "Program ${program} ${version} has been already reviewed"
    }

    # We have another reviewed version for the same recipe
    local reviewed_recipe_program_dir=$(dirname ${reviewed_recipe})
    if [ ! -d ${reviewed_recipe_program_dir} ]
    then
        mkdir ${reviewed_recipe_program_dir}
    fi
    git mv ${local_recipe} ${reviewed_recipe_program_dir}
    git commit -m \"Review ${program} ${version}\"
    echo "Review done"
}

main $@
