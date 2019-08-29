#!/usr/bin/env bash

# todo: validation

[[ $# < 1 ]] && { echo ">| ERROR: one argument required"; exit 1; }
[[ $# > 1 ]] && { echo ">| ERROR: too many arguments"; exit 1; }

# todo: usage of script
declare -A usage=(
########################################
["usage"]="*** USAGE ***

%%% DESCRIPTION
  - used to find the usage of custom scripts
  - can only search one script usage at a time
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
["khulabuild"]="*** KHULABUILD ***

%%% DESCRIPTION
  - build khula projects for quicker deployment
  - makes builds easier

%%% ARGUMENT
  - '-p' = project name
  - '-b' = branch
  - '-a' = autodeploy project
  - '-F' = build full dependency
  - '-A' = builds all projects
  - '-h' = gives usages
"
########################################
["jetbrainsreset"]="*** JETBRAINSRESET ***

%%% DESCRIPTION
  - Reset Testing period for jetbrains IDE's

%%% ARGUMENT
  - '--intellij' = resets IntelliJ
  - '--goland'   = resets GoLand
  - '--webstorm' = resets WebStorm
  - '--pycharm'  = resets PyCharm
"
########################################
#[""]=""
########################################
#[""]=""
########################################
#[""]=""
########################################
#[""]=""
########################################
#[""]=""
########################################
#[""]=""
########################################
#[""]=""
########################################
#[""]=""
########################################
#[""]=""
########################################
#[""]=""
########################################
#[""]=""
########################################
)
# todo: find usage
for script in "${!usage[@]}"; do
    [[ "${script}" == $1 || "${script}.sh" == $1 ]] && {
    echo -e "${usage[$script]}"
    exit 0
    }
done

echo ">| ERROR: invalid script name"
