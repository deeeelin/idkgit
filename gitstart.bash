#! /bin/bash #possible error excluded
#set -e  #這裏架set -e只要子程式出錯，這個也會跳出去
#alias | awk '/idk=/{ exit 1 }'  #you cannot put this thing in a $() ,it will open a child shell,and you cannot see alias
function start () {

    if [[ $SHLVL -ne 1 ]]; then

    echo "setting alias...." 

    cat >>.bash_profile << Here1234

    alias idk='source $0'
    export IDKDIR="$(dirname $0)"

Here1234

    chmod +x ~/.bash_profile
    ~/.bash_profile
    
    fi

    echo "git start executed"
}
function do_push () {
    chmod +x gitpush.bash
    ./gitpush.bash "push"
    local cond=$?

    if [[ $cond -eq 87 ]];then
        echo "push failed" 
        echo "no previous reference for auto"

    elif [[ $cond -eq 1 ]];then
        echo "push failed" 
        return
    elif [[ $cond -eq 88 ]];then
        echo "back to mode"
        return
    else
        echo "push process finished" 
    fi

    return
}
function do_pull () {

    chmod +x gitpush.bash
    ./gitpush.bash "pull"

    local cond=$?

    if [[ $cond -eq 87 ]];then

        echo "$i pull failed" 
        echo "no previous reference for auto"

    elif [[ $cond -eq 1 ]];then

        echo "$REPLY pull failed" 
        return
    elif [[ $cond -eq 88 ]];then
        return
    else 
        echo "pull process finished"

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
function do_delete () {  #little error
    
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

    declare -a arr

    cd ~/Desktop/.gitprocess/
    arr=$(find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')

    arr+=" (back_to_mode)"

    PS3='choose:'

    select c in ${arr[@]}
    do
        echo "you chose : $c"
        if [[ $c == "back" ]];then 
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

            push)  do_push  ;;

            pull)  do_pull ;;

            delete) do_delete ;;

            list) do_list ;;  

            #  1. p puts in the last one because you only need to show the last result
            #  2. when you use find . -name 'xxx*',you need to add  '' orelse 
            #  *will expand first and if there are two thing that fits,
            #  then there will be two arg putted in find,which will cause error

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

        