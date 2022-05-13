#! /bin/bash
function back () {
    if [[ $1 == "back" ]];then
        exit 88
    fi
    return 
}
function init () {
    read -p "give me a path: " route


    echo "start initializing....."

    while ! [[ -n ${route} ]] 
    do
            echo "path wrong do again"
            read -p "give me a path: " route
    done
    back ${route}
    cd ${route} 2>/dev/null
    while [[ $? -eq 1 ]];
    do
        echo "path wrong do again"
        read -p "give me a path: " route
        back ${route}
        
        cd ${route} 2>/dev/null
    done

    git init

    git add  --all 
    set -e
    git commit -m "first commit on $(date)"
    echo  "finished git initialize and commit"
    return 
}
init