#! /bin/bash
function back () {
    if [[ $1 == "b/" ]];then
        exit 88
    fi
    return 
}
function check_route () {

    cd ${route} 2>/dev/null

    while [[ $? -eq 1 || ${route} == '' ]]
    do
        echo "please enter valid path!!"
        read -p "please enter your folder path (absolute path): "  route
        back $route
        cd ${route} 2>/dev/null
    done 
    return 
}
function check_name () {

    cd ${IDKDIR}/gitprocess/gitprocessof${name} 2>/dev/null

    if [[ $? -eq 0 ]];then
       echo "project existed cannot create !,go delete to create"
       exit 88
    fi

    return 
}
function read_info () {

    read -p "please enter the remote repository url: " url
    back ${url}

    read -p "please enter repository name: " rname
    back ${rname}

    read -p "please enter your folder path (absolute path): "  route
    back ${route}
    check_route

    read -p "please enter your project name: " name
    back ${name}
    check_name

    return
}
function create_info () {

    #mkdir
    cd ${IDKDIR}
    mkdir -p gitprocess
    cd gitprocess/ 
    mkdir -p gitprocessof${name}
    cd gitprocessof${name}/

    #create info txt
    echo "url:${url}" >> ginfo_${name}.txt
    echo "repn:${rname}" >> ginfo_${name}.txt
    echo "route:${route}" >> ginfo_${name}.txt
    echo "prevo:_nobranch" >> ginfo_${name}.txt 
    echo "prevt:_nobranch" >> ginfo_${name}.txt
    return

}

echo "start creating....."

read_info
create_info

echo "finished settings" 



