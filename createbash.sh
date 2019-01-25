#!/usr/bin/env bash

# variables
SCRIPT_DIR="${HOME}/Bash-Scripts"
source "${HOME}/Bash-Scripts/templates/config.conf"


# get input through arguments
while getopts "f:d:prxh" opt; do
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
    "h")
        usage.sh createbash.sh
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

# validation
[[ -z ${filename} ]] && {
    echo ">| ERROR: filename has not been specified"
    exit 1
}

# find if directory exists
if [[ -n ${destination} ]] && [[ ! -d ${destination} ]]; then
 echo ">| ERROR: specified destination does not exist"
 exit 1
# default directory
elif [[ -z  ${destination} ]]; then
    echo ">| reverted to default directory"
    destination="${SCRIPT_DIR}"
fi


# find if file already exists
# create file

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


# write to file
# add password if required
echo "${BASH_SHEBANG}" >> ${file_destination}
[[ ${password} ]] && {
    printf  "\necho ${PASS_FILE}" >> ${file_destination}
}

[[ ${write} ]] && {
    echo "opening terminal text editor..."
    sleep 1
    nano ${file_destination}
}


# make executable
echo "setting as executable..."
chmod +x ${file_destination}


# execute file
if [[ ${execute} ]]; then
    konsole -e "${SCRIPT_DIR}/runcommand.sh '${file_destination}' 'sleep 3'"
fi
echo ">| file located in: ${destination}"
echo ">| filename: ${filename}"
