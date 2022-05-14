#! /bin/bash 

function start () {

    if [[ $SHLVL -ne 1 ]]; then

    echo "setting alias...." 

    cat >>.bash_profile << Here1234

    alias idk='source $0'
    export IDKDIR="$(dirname $0)"

Here1234
    echo "please reopen your terminal,and use 'idk' to execute"
    exit 0

    fi

    echo "idkgit executed"
}
function do_pp () {

    if [[ $1 == "push" ]];then
        mode="push"
    else
        mode="pull"
    fi

    chmod +x pp.bash
    ./pp.bash ${mode}

    local cond=$?

    if [[ $cond -eq 87 ]];then
        echo "some ${mode} failed" 
        echo "error: no previous reference "

    elif [[ $cond -eq 1 ]];then
        echo "${mode} failed" 
        return
    elif [[ $cond -eq 88 ]];then
        echo "back to mode"
        return
    else
        echo "${mode} process finished" 
    fi

    return
}
function do_init () {

    chmod +x init.bash
    ./init.bash

    cond=$?

    if [[ ${cond} -eq 1 ]];then
        echo "git init finished,commit failed"
    elif [[ $cond -eq 88 ]];then
        echo "back to mode"
    else 
        echo "git init success"
    fi

    return
}
function do_clone () {

    chmod +x clone.bash
    ./clone.bash

    cond=$?

    if [[ ${cond} -eq 1 ]];then
        echo "clone failed"
    elif [[ ${cond} -eq 88 ]];then
        echo "backed to mode"
    else
        echo "clone sucess"
    fi
    
    return
}
function do_create () {

    local cond

    chmod +x setting.bash
    ./setting.bash

    cond=$?

    if [[ $cond -eq 88 ]];then
        echo "back to mode"
    elif [[ $cond -eq 1 ]];then
        echo "create failed"
    fi
    return 

}
function do_setcom () {
    echo "recent commit message:"
    cat commitmessage.txt
    read -p "enter your commit message,type 'back' to cancel: " m
    if [[ $m == "b/" ]];then
        return
    fi
    echo "$m" > commitmessage.txt
    echo "message setted"
    return
}
function do_delete () {  
    
    local cond

    chmod +x delete.bash
    ./delete.bash
    cond=$?
   
    if [[ $cond -eq 88 ]];then
        echo "back to mode"
    elif [[ $cond -eq 1 ]];then
        echo "delete failed"
    fi
    return  

}
function do_list () {

    chmod +x list.bash
    ./list.bash
    
    return
}
function jumpy () {

    cd ${IDKDIR}/gitprocess/ 2>/dev/null

    declare -a arr
    arr=$(find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
    if [[ -n arr ]];then
        echo "nothing to jump"
        return 2
    fi
    PS3='choose:'

    select c in ${arr[@]}
    do

        if [[ $REPLY == "b/" ]];then 
            echo "back to mode"
            return 1
        fi

        echo "you chose : $c"
        cd ${IDKDIR}/gitprocess/gitprocessof$c/ 2>/dev/null

        if [[ $? -eq 0 ]];then

            cd $(grep "route:" ginfo_$c.txt| cut -c7-) 
            echo "jumped"
            break 2
        fi

        echo "input invalid,please choose again"
    done

    return 0

}

function main (){
    while ((1)) 
    do
        read -p "mode: "
        cd ${IDKDIR}

        case $REPLY in 
            clone | cl) do_clone ;;

            init | i)  do_init ;;

            create | cr) do_create ;;

            setcom| s) do_setcom ;;

            push | ph)  do_pp "push";;

            pull | pl)  do_pp "pull";;

            delete | d) do_delete ;;

            list | l) do_list ;;  

            jump | j) jumpy; 
            if [[ $? -eq 0 ]];then 
            break 
            fi 
            ;;

            out | o) cd ~ ; break ;;

            *) echo "mode not found" ;;

        esac

    done 
    echo "idk closed"
}

#execute
start
main  

        