#! /bin/bash #possible error excluded
#set -e  #這裏架set -e只要子程式出錯，這個也會跳出去
if  ! [[ $( alias | grep -q 'idk=' ) ]];then
    cd ~/
    cat >>.bash_profile << Here1234 
    alias idk="$0"
Here1234

fi

echo "git start executed"

function do_push () {
    echo "start pushing..."
    echo "$1"
    if [[ "$1" == 'all' ]]; then #not yet apply auto to own and tar branch
        for i in $(cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
            do
            cd ~/Desktop/.gitprocess/gitprocessof$i/ 
            sed -i '' 's/pushmode="normal"/pushmode="auto"/' gpsh_$i.bash
            chmod +x gpsh_$i.bash 
            bash -x ./gpsh_$i.bash
            if [[ $? -eq 87 ]];then
                echo "$1 push failed" 
                echo "no previous reference for auto"
            elif [[ $? -eq 1 ]];then
                echo "$i push failed" 
            fi
            sed -i '' 's/pushmode="auto"/pushmode="normal"/' gpsh_$i.bash
            done
    else
        cd ~/Desktop/.gitprocess/gitprocessof$1/ #2>/dev/null
            if  [[ $? -eq 1 ]];then 
                echo "push fail,no this dir" 
                return 
            fi
            chmod +x gpsh_$1.bash 
            ./gpsh_$1.bash
            if [[ $? -eq 1 ]];then
                echo "$i push failed" 
                return
            fi
    fi

    echo "push completed"
    
    return
}
function do_pull () {
    echo "start pulling..."

    if [[ $1 == 'all' ]];then

        for i in $(cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
            do
            cd ~/Desktop/.gitprocess/gitprocessof$i/ 
            sed -i 's/pullmode="normal"/pullmode="auto"/' gpsh_$i.bash
            chmod +x gpul_$i.bash 
            ./gpul_$i.bash
            cond=$?
            if [[ $cond -eq 87 ]];then
                echo "$i pull failed" 
                echo "no previous reference for auto"
            elif [[ $cond -eq 1 ]];then
                echo "$i pull failed" 
            fi
            sed -i 's/pullmode="auto"/pullmode="normal"/' gpsh_$i.bash
            done

    else
        cd ~/Desktop/.gitprocess/gitprocessof$1/ #e
            chmod +x gpul_$1.bash 
            ./gpul_$1.bash
            if [[ $? -eq 1 ]];then
                echo "$1 pull failed" 
                return
            fi
            

    fi

    echo "pull completed"
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
                echo "delete fail,no this dir" 
                return 
        fi

    
    fi

    echo "successfully deleted"
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
    declare -a routes
    declare -i i
    cd ~/Desktop/.gitprocess/
    arr=$(find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')

    #echo ${arr[@]}

    for (( i=0; i<${#arr[@]} ; i++ ))
    do 
    routes[${arr[i]}]=$(find . -name gpsh_${arr[i]}.bash | grep 'cd'|sed -e 's/^..//')
    done
    select route in arr
    do 
    echo "您鍵入的編號為$REPLY,選擇了 ${route}"

    cd routes[$route]
    
    done

    kill -Term $$
    
    return 
}
while ((1)) 
do
    read -p "mode: "
    cd $(dirname $0)
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

        jump) jumpy ;;

        out) cd ~ ; break ;;

        *) echo "mode not found" ;;

    esac

done
echo "idk closed"

         

        