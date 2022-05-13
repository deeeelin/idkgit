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

    read -p "proj name: " ; 
    if [[ $REPLY == "back" ]]; then 
    return 
    fi
    echo "start pushing..."

    echo "your choice : $REPLY"

    if [[ "$REPLY" == 'all' ]]; then #not yet apply auto to own and tar branch

        for i in $(cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')

            do
            chmod +x gitpush.bash 
            ./gitpush.bash $i "auto"
            local cond=$?
            #echo "this is fucking $cond"
            if [[ $cond -eq 87 ]];then
                echo "$i push failed" 
                echo "no previous reference for auto"
            elif [[ $cond -eq 1 ]];then
                echo "$i push failed"
            fi
            done

    else
            chmod +x gitpush.bash 
            ./gitpush.bash $REPLY "normal"         
            cond=$?

            if [[ $cond -eq 1 ]];then
                echo "$REPLY push failed" 
                return
            elif [[ $cond -eq 88 ]];then
                return
            fi
    fi

    echo "push process finished"
    
    return
}
function do_pull () {
    read -p "proj name: "

    if [[ $REPLY == "back" ]]; then 
    return 
    fi

    echo "start pulling..."
    echo "your choice : $REPLY"

    if [[ $REPLY == 'all' ]];then

        for i in $(cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
            
            do
            chmod +x gitpull.bash 
            ./gitpull.bash $i "auto"
            local cond=$?
            #echo "this is fucking $cond"
            
            if [[ $cond -eq 87 ]];then
                echo "$i pull failed" 
                echo "no previous reference for auto"
            elif [[ $cond -eq 1 ]];then
                echo "$i pull failed" 
            fi

            done

    else

            chmod +x gitpull.bash 
            ./gitpull.bash $REPLY "normal"
            cond=$?

            if [[ $cond -eq 1 ]];then
                echo "$REPLY pull failed" 
                return
            elif [[ $cond -eq 88 ]];then
                return
            fi
            

    fi

    echo "pull process finished"
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

    chmod +x gitsetting.bash
    ./gitsetting.bash
    if [[ $? -eq 88 ]];then
        echo "back to mode"
    elif [[ $? -eq 1 ]];then
        echo "create failed"
    fi
    return 

}
function delete () {  #error
    chmod +x gitdelete.bash
    ./gitdelete.bash
    if [[ $? -eq 88 ]];then
        echo "back to mode"
    elif [[ $? -eq 1 ]];then
        echo "delete failed"
    fi
    return  

}
function jumpy () {

    declare -a arr

    cd ~/Desktop/.gitprocess/
    arr=$(find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')

    arr+=" back"
    echo "${arr[0]}"
    #echo ${arr[@]}
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

            delete) delete ;;

            list) list ;;  

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

        