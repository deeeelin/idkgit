#! /bin/bash 

function start () {

    if [[ $SHLVL -ne 1 ]]; then

    echo "setting alias...." 

    cat >>.bash_profile << Here1234

    alias idk='source $0'
    export IDKDIR="$(dirname $0)"

Here1234
    cd ~
    chmod +x ~/.bash_profile
    . ./.bash_profile
    
    fi

    echo "git start executed"
}
function do_pp () {

    if [[ $1 == "push" ]];then
        mode="push"
    else
        mode="pull"
    fi

    chmod +x gitpp.bash
    ./gitpp.bash ${mode}

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

    chmod +x gitinit.bash
    ./gitinit.bash

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

    chmod +x gitclone.bash
    ./gitclone.bash

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

    chmod +x gitsetting.bash
    ./gitsetting.bash

    cond=$?

    if [[ $cond -eq 88 ]];then
        echo "back to mode"
    elif [[ $cond -eq 1 ]];then
        echo "create failed"
    fi
    return 

}
function do_setcom () {
    read -p "enter your commit message: " m
    echo "$m" > commitmessage.txt
    echo "message setted"
    return
}
function do_delete () {  
    
    local cond

    chmod +x gitdelete.bash
    ./gitdelete.bash
    cond=$?
   
    if [[ $cond -eq 88 ]];then
        echo "back to mode"
    elif [[ $cond -eq 1 ]];then
        echo "delete failed"
    fi
    return  

}
function do_list () {

    chmod +x gitlist.bash
    ./gitlist.bash
    
    return
}
function jumpy () {

    cd ~/Desktop/.gitprocess/

    declare -a arr
    arr=$(find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
    arr+=" (back_to_mode)"

    PS3='choose:'

    select c in ${arr[@]}
    do
        echo "you chose : $c"

        if [[ $c == "(back_to_mode)" ]];then 
            return 1
        fi

        cd ~/Desktop/.gitprocess/gitprocessof$c/ 2>/dev/null

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
            clone) do_clone ;;

            init)  do_init ;;

            create) do_create ;;

            setcom) do_setcom ;;

            push)  do_pp "push";;

            pull)  do_pp "pull";;

            delete) do_delete ;;

            list) do_list ;;  

            jump) jumpy; 
            if [[ $? -eq 0 ]];then 
            break 
            fi 
            ;;

            out) cd ~ ; break ;;

            *) echo "mode not found" ;;

        esac

    done 
    echo "idk closed"
}

#execute
start
main  

        