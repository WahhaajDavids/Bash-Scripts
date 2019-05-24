#!/usr/bin/env bash

# todo: validation

[[ $# < 1 ]] && {
    echo ">| ERROR: argument required"
    exit 1
}
[[ $# < 1 ]] && {
    echo ">| ERROR: too many arguments"
    exit 1
}

# todo: usage of script
declare -A usage=(
["usage"]="*** USAGE ***

%%% DESCRIPTION
  - used to find the usage of custom scripts
  - makes it easier to understand what the script are being used for

%%% ARGUMENT
  - '\$1' = searched custom script (e.g script or script.sh)
"
########################################
["createbash"]="*** CREATEBASH ***

%%% DESCRIPTION
  - used to create bash scripts
  - makes it easy to create a bash script from anywhere on the computer

%%% ARGUMENT
  - '-f' = filename
  - '-r' = write to file
  - '-x' = execute file
  - '-d' = destination- place to compile
  - '-p' = adds password protection
  - '-h' = gives usages
"
########################################
["khulabuild"]="*** KHULBUILD ***"
########################################

#[""]=""
#[""]=""
#[""]=""
#[""]=""
#[""]=""
#[""]=""
#[""]=""
#[""]=""
#[""]=""
#[""]=""
#[""]=""
#[""]=""
)
# todo: find usage
for script in "${!usage[@]}"; do
    [[ "${script}" == $1 || "${script}.sh" == $1 ]] && {
    echo -e "${usage[$script]}"
    exit 0
    }
done

echo ">| ERROR: invalid script name"
