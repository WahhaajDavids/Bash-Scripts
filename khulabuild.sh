#!/usr/bin/env bash

# todo: variables
source "${HOME}/Bash-Scripts/templates/config.conf"
khula_dir="${PROJECT_DIR}/khula"
automation_dir="${PROJECT_DIR}/automation"

# todo: base directories for all projects
declare -a base_dir=(
    '${khula_dir}/khula-b2b-library'
    '${khula_dir}/khula-rules-library'
    '${khula_dir}/khula-monolith'
)

# todo: automation directories
declare -a automation_base=(
    'automation-db2'
    'automation-tds'
    'automation-mq'
    'automation-was-base'
    'automation-was-standalone'
)

# todo: automation jobs for more coverage
if [[ ${1} == "--automation" ]]; then
    if [[ ${#} == 1 ]]; then
        for i in {0..4}; do
            echo ">| ${automation_base[${i}]}"
            cd "/home/wahhaaj/Projects/automation/${automation_base[${i}]}"
            echo ">| Undeploying::----------------------------------"
            mvn k8:undeploy
            echo ">| Installing::-----------------------------------"
            mvn clean install
        done
    else
        shift
        for i in {0..4}; do
            for t in $@;do
                if [[ ${automation_base[${i}]} =~ ${t} ]]; then
                    cd "/home/wahhaaj/Projects/automation/${automation_base[${i}]}"
                    echo ">| Undeploying::----------------------------------"
                    mvn k8:undeploy
                    echo ">| Installing::-----------------------------------"
                    mvn clean install
                fi
            done
        done
    fi
    exit 0
fi

# todo: get input through arguments
while getopts "p:b:AaFfh" opt; do
    case ${opt} in
    "p")
        project="${OPTARG}"
        ;;
    "b")
        branch="${OPTARG}"
        ;;
    "A")
        ALL=true; echo hi
        ;;
    "a")
        autodeploy=true
        ;;
    "F")
        full_build=true
        ;;
    "f")
        echo "please use option argument '-F'. for more information use 'khulebuild.sh -h'" && exit 1
        ;;
    "h")
        usage.sh khulabuild.sh
        exit
        ;;
    ":")
        echo ">| ERROR: incorrect arguments" && exit 1
        ;;
    "\?")
        echo ">| ERROR: incorrect arguments" && exit 1
        ;;
    esac
done

# todo: project validation
[[ -z ${project} && ${ALL} != true ]] && {
    echo ">| ERROR: project has not been specified"
    exit 1
}

# todo: build all projects
#if [[ ${ALL} ]]; then
#    echo "Building all projects"
#    cd ${khula_dir}
#    find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && pwd && git fetch -p &&  && git pull && " \
#    exit 0
#fi

# todo: build all dependencies for the project
# ps: make this a function
#if [[ ${full_build} ]]; then
#    echo ">| INFO:: Building full base directory build path"
#
#    for i in {0..2}; do
#        echo "${base_dir[${i}]}"
#        cd "${base_dir[${i}]}"
#        [[ ${branch} ]] && { git checkout ${branch};}
#        mvn clean install -DskipTests=true -Pbuild_for_linux
#    done
#fi


# todo: build the project
if [[ ${project} ]]; then
    echo ${khula_dir}
    cd ${khula_dir}
    cd $(find *${project}* -maxdepth 0) && {
        if [[ ${autodeploy} ]]; then
            mvn clean install -DskipTests=true -Pbuild_for_linux,autodeploy;
        else
            mvn clean install -DskipTests=true -Pbuild_for_linux;
        fi
    }
fi





