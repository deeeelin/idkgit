#! /bin/bash
function back () {
    if [[ $1 == "b/" ]];then
        exit 88
    fi
    return 
}
function check_route () {

    read -p "please enter your project directory path : "  route ;  back ${route}

    cd ${route} 2>/dev/null

    while [[ $? -eq 1 || ${route} == '' ]]
    do
        echo "please enter valid path!!"
        read -p "please enter your project directory path : "  route ; back $route
        cd ${route} 2>/dev/null
    done 
    return 
}
function check_name () {
    read -p "please enter your project name: " name ; back ${name}

    cd ${IDKDIR}/gitprocess/gitprocessof${name} 2>/dev/null

    while [[ $? -eq 0 || ${name} == ''  ]]
    do
       echo "error , project name invalid !"
       back ${name}
       cd ${IDKDIR}/gitprocess/gitprocessof${name} 2>/dev/null
    done

    return 
}
function check_rname () {
    
    read -p "please enter the remote repository name: " rname ; back ${rname}

    while [[ ${rname} == ''  ]]
    do
       echo "error , can't be empty !"
       read -p "please enter the remote repository name: " rname ; back ${rname}
    done
    return 

}
function check_url () {
    
    read -p "please enter the remote repository url: " url ; back ${url}

    while [[ ${url} == ''  ]]
    do
       echo "error , can't be empty !"
       read -p "please enter the remote repository url: " url ; back ${url}
    done
    return 

}
function read_info () {

    check_url

    check_rname

    check_route

    check_name

    return
}
function create_info () {

    cd ${IDKDIR}
    mkdir -p gitprocess
    cd ${IDKDIR}/gitprocess/

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



