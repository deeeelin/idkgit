#! /bin/bash #possible error excluded
#set -e  #這裏架set -e只要子程式出錯，這個也會跳出去
#alias | awk '/idk=/{ exit 1 }'  #you cannot put this thing in a $() ,it will open a child shell,and you cannot see alias

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

function do_push () {
    echo "start pushing..."
    echo "your choice : $1"
    if [[ "$1" == 'all' ]]; then #not yet apply auto to own and tar branch
        for i in $(cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
            do
            chmod +x gitpush.bash 
            ./gitpush.bash $i "auto"
            local cond=$?
            #echo "this is fucking $cond"
            if [[ $cond -eq 87 ]];then
                echo "$1 push failed" 
                echo "no previous reference for auto"
            elif [[ $cond -eq 1 ]];then
                echo "$i push failed" 
            fi
            done
    else
            chmod +x gitpush.bash 
            ./gitpush.bash $1 "normal"         
            cond=$?
            if [[ $cond -eq 1 ]];then
                echo "$1 push failed" 
                return
            fi
    fi

    echo "push process finished"
    
    return
}
function do_pull () {
    echo "start pulling..."
    echo "your choice : $1"
    if [[ $1 == 'all' ]];then

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
            ./gitpull.bash $1 "normal"
            cond=$?
            if [[ $cond -eq 1 ]];then
                echo "$1 pull failed" 
                return
            fi
            

    fi

    echo "pull process finished"
    return
}
function delete (){ #feature succeed

   
    if [[ $1 == 'all' ]];then
        for i in $(cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
            do
            cd ~/Desktop/.gitprocess/
            echo "start deleting..."
            rm -rf dir gitprocessof$i #e
            done
    else
        
        cd ~/Desktop/.gitprocess/
        echo "start deleting..." 
        rm -rf dir gitprocessof$1 # 不會丟錯誤
        if ! [[ $? -eq 0 ]];then 
                echo "delete fail,project name non-found" 
                return 
        fi

    
    fi

    echo "delete process finished"
    return
}
function list () {

    echo

    echo "current projects:"

    cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p'

    echo
    echo
    
    return
}
function jumpy () {

    declare -a arr
    cd ~/Desktop/.gitprocess/
    arr=$(find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
    #echo ${arr[@]}
    PS3='choose:'
    select c in ${arr[@]}
    do
        echo "you chose : $c"
        cd ~/Desktop/.gitprocess/gitprocessof$c/
        cd $(grep "route:" ginfo_$c.txt| cut -c7-)
        echo "jumped"
        break
    done
    return

}
while ((1)) 
do
    read -p "mode: "
    cd ${IDKDIR}
  # echo "this is ${IDKDIR}"
    case $REPLY in 
        clone) chmod +x gitclone.bash;./gitclone.bash ;;

        init)  chmod +x gitinit.bash; ./gitinit.bash ;;

        create) chmod +x gitsetting.bash; ./gitsetting.bash ;;

        push) read -p "proj name: " ; do_push $REPLY ;;

        pull) read -p "proj name: " ; do_pull $REPLY ;;

        delete) read -p "proj name: " ; delete $REPLY ;;

        list) list ;;  

        #  1. p puts in the last one because you only need to show the last result
        #  2. when you use find . -name 'xxx*',you need to add  '' orelse 
        #  *will expand first and if there are two thing that fits,
        #  then there will be two arg putted in find,which will cause error

        jump) jumpy; break ;;

        out) cd ~ ; break ;;

        *) echo "mode not found" ;;

    esac

done 
echo "idk closed"

         

        