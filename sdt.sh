if [ $# -eq 0 ] || [ "$1" = "help" ]; then
    echo "Options: "
    echo " help: Show this help message"
    echo " mksv <version>: Create a new server instance on the fly"
    echo " cln, clone <url> [profile]: Clones a plugin repository to your current location"
    echo " vsc [project]: Opens in VSCode the project given or the latest cloned one"
    echo " start <version>: Starts the server instance of the given version"

    exit 1
fi

## Everything relating to the mksv command

if [ "$1" = "mksv" ]; then
    if [ $# -eq 1 ]; then
        echo "Usage: $0 mksv <version>"
        exit 1
    fi

    ./mksv.sh $2
    exit 1 
fi

if [ "$1" = "cln" ] || [ "$1" = "clone" ]; then
    if [ $# -eq 1 ]; then
        echo "Usage: $0 clone <url> [profile]"
        exit 1
    fi

    url=$2
    if [[ $url == */ ]]
    then
        url=${url::-1}
    fi
    url=${url##*/}

    if [ $# -eq 2 ]; then
        profile="generic"
    else
        profile=$3
    fi

    result="projects/$profile/$url"

    if [ -d "$result" ]; then
        echo "Project already exists!"
        exit 1
    fi


    { git clone $2 $result; } || { echo "Failed to clone repository!"; exit 1; }

fi

if [ "$1" = "vsc" ]; then
    project=$(find projects/ -maxdepth 2 -mindepth 2 | grep $2 | head -n 1)
    code $project
fi


if [ "$1" = "start" ]; then
    if [ $# -eq 1 ]; then
        echo "Usage: $0 start <version>"
        exit 1
    fi

    cd instances/$2
    ./start.sh
fi