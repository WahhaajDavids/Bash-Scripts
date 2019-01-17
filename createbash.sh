#!/usr/bin/env bash

# todo: variables
SCRIPT_DIR="${HOME}/BashScripts"
source "${HOME}/BashScripts/templates/config.conf"


# todo: get input through arguments
while getopts "f:d:prx" opt; do
    case ${opt} in
    "f")
        filename="${OPTARG}.sh"
        ;;
    "d")
        destination="${OPTARG}"
        ;;
    "p")
        password=true
        ;;
    "r")
        write=true
        ;;
    "x")
        execute=true
        ;;
    ":")
        echo ">| ERROR: incorrect arguments" && exit 1
        ;;
    "\?")
        echo ">| ERROR: incorrect arguments" && exit 1
        ;;
    esac
done


# todo: find if directory exists
if [[ -n ${destination} ]] && [[ ! -d ${destination} ]]; then
 echo ">| ERROR: specified destination does not exist"
 exit 1
# default directory
elif [[ -z  ${destination} ]]; then
    echo ">| reverted to default directory"
    destination="${SCRIPT_DIR}"
fi


# todo: find if file already exists
# todo: create file
[[ -z ${filename} ]] && {
    echo ">| ERROR: filename has not been specified"
    exit 1
}

file_destination="${destination}/${filename}"

if [[ -e ${file_destination} ]]; then
    echo ">| WARN: file already exists"
    echo ">| would you like to overwrite this file? [Y/N]"
    read input

    while true; do
        [[ ${input} == [YyNn] ]] && break
        sleep .5
        echo ">| RE: please specify? [Y/N]"
        read input
    done

    if [[ ${input} == [Yy] ]]; then
        echo "removing existing file..."
        rm ${file_destination}
        echo "creating new file..."
        touch ${file_destination}
    else
        echo "exiting..."
        exit 1
    fi
else
    touch ${file_destination}
    echo "creating new file..."
fi


# todo: write to file
# todo: add password if required
echo "${BASH_SHEBANG}" >> ${file_destination}
[[ ${password} ]] && {
    printf  "\necho ${PASS_FILE}" >> ${file_destination}
}

[[ ${write} ]] && {
    echo "opening terminal text editor..."
    sleep 1
    nano ${file_destination}
}


# todo: make executable
echo "setting as executable..."
chmod +x ${file_destination}


# todo: execute file
konsole -e "${TEMPLATE_DIR}/runcommand.sh '${file_destination}' 'sleep 1'"

echo ">| file located in: ${destination}"
echo ">| filename: ${filename}"