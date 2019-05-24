#!/usr/bin/env bash

#variables
source "${HOME}/Bash-Scripts/templates/config.conf"
khula_dir="${PROJECT_DIR}/khula"

declare -a base_dir=(
    '${khula_dir}/khula-b2b-library'
    '${khula_dir}/khula-rules-library'
    '${khula_dir}/khula-monolith'
)


# get input through arguments
while getopts "p:b:aFfh" opt; do
    case ${opt} in
    "p")
        project="${OPTARG}"
        ;;
    "b")
        branch="${OPTARG}"
        ;;
    "a")
        autodeploy=true
        ;;
    "F")
        full_build=true
        ;;
    "h")
        usage.sh khulabuild.sh
        exit
        ;;
    "f")
        echo "please use option argument '-F'. for more information use 'khulebuild.sh -h'" && exit 1
        ;;
    ":")
        echo ">| ERROR: incorrect arguments" && exit 1
        ;;
    "\?")
        echo ">| ERROR: incorrect arguments" && exit 1
        ;;
    esac
done

# project validation
[[ -z ${project} ]] && {
    echo ">| ERROR: project has not been specified"
    exit 1
}

# full build of dependency projects
if [[ ${full_build} ]]; then
    echo ">| INFO:: Building full base directory build path"

    for i in {0..2}; do
        echo "${base_dir[${i}]}"
        cd "${base_dir[${i}]}"
        [[ ${branch} ]] && { git checkout ${branch};}
        mvn clean install -DskipTests=true -Pbuild_for_linux
    done
fi

# build project
cd ${khula_dir}/$(find *communication* -maxdepth 0) && {
    if [[ ${autodeploy} ]]; then
        mvn clean install -DskipTests=true -Pbuild_for_linux,autodeploy;
    else
        mvn clean install -DskipTests=true -Pbuild_for_linux;
    fi
}




