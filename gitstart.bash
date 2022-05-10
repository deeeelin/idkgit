#! /bin/bash
#set -e 
echo "git start executed"

function do_push () {
    echo "start pushing..."
    cd ~/Desktop/.gitprocess/gitprocessof$1/
    chmod +x gpsh_$1.bash
    ./gpsh_$1.bash
    echo "push completed"
    return
}
function do_pull () {
    echo "start pulling..."
    cd ~/Desktop/.gitprocess/gitprocessof$1/
    chmod +x gpul_$1.bash
    ./gpul_$1.bash
    echo "pull completed"
    return
}
function delete (){
    echo "start deleting..."
    cd ~/Desktop/.gitprocess/
    rm -rf dir gitprocessof$1
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

        delete) read -p "proj name" ; delete $REPLY ;;

        list) list ;;  

        #  1. p puts in the last one because you only need to show the last result
        #  2. when you use find . -name 'xxx*',you need to add  '' orelse 
        #  *will expand first and if there are two thing that fits,
        #  then there will be two arg putted in find,which will cause error

        out) break ;;

    esac

done

echo "gitstart closed"

         

        