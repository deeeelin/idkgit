#! /bin/bash

function back () {

    if [[ $1 == "b/" ]];then
        exit 88
    fi
    return 
}
function init () {
    set +e
    read -p "Directory path : " route ; back ${route}

    echo "start initializing....."

    cd ${route} 2>/dev/null

    while [[ $? -eq 1 || ! -n ${route} ]];
    do
        echo "path wrong do again"
        read -p "Directory path : " route
        back ${route}
        
        cd ${route} 2>/dev/null
    done
    set -e

    git init

    echo  "Finished git initialize "
    
    return 
}
init