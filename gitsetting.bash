#! /bin/bash
function back () {
    if [[ $1 == "back" ]];then
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
}
function check_name () {
    cd ~/Desktop/.gitprocess/gitprocessof${name}

    if [[ $? -eq 0 ]];then
       echo "project existed cannot create !,go delete to create"
       exit 88
    fi
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
}
function create_info () {

    #mkdir
    cd ~/Desktop/   
    mkdir -p .gitprocess
    cd .gitprocess/ 
    mkdir -p gitprocessof${name}
    cd gitprocessof${name}/

    #create info txt
    echo "url:${url}" >> ginfo_${name}.txt
    echo "repn:${rname}" >> ginfo_${name}.txt
    echo "route:${route}" >> ginfo_${name}.txt
    echo "prevo:_nobranch" >> ginfo_${name}.txt #written into file is disable when using echo to a bash document
    echo "prevt:_nobranch" >> ginfo_${name}.txt

}

echo "start creating....."

read_info
create_info

echo "finished settings" 



