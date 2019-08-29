#!/usr/bin/env bash

## All Reset Functions

IntelliJReset () {
    echo "removing and resetting IntelliJ"
    rm  -rf "~/.IntelliJIdea*"

}

GoLandReset () {
    echo "removing and resetting GoLand"
    rm  -rf "~/.GoLand*"

}

WebStormReset () {
    echo "removing and resetting WebStorm"
    rm  -rf "~/.WebStorm*"

}

PyCharmReset () {
    echo "removing and resetting PyCharm"
    rm  -rf "~/.PyCharm*"

}

## /////////////////////////////////////////////////////

## Argument loop
while (( $# != 0 )); do
    case $1 in
        "--intellij")
            IntelliJReset
        ;;
        "--goland")
            GoLandReset
        ;;
        "--webstorm")
            WebStormReset
        ;;
        "--pycharm")
            PyCharmReset
        ;;
    esac
    shift
done

## /////////////////////////////////////////////////////

# todo: remove eclipes
##rm  -rf ~/.IntelliJIdea*

echo "All Done!!"