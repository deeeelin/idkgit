#! /bin/bash
function back () {
    if [[ $1 == "back" ]];then
        exit 88
    fi
    return 
}
function do_pull () {

    read -p "proj name: "

    back $REPLY
    cd ~/Desktop/.gitprocess/gitprocessof$REPLY 2>/dev/null
    while [[ $? -eq 1 && $REPLY != "all" ]] 
    do 
        echo "no such proj "
        read -p "proj name: "
        back $REPLY
        cd ~/Desktop/.gitprocess/gitprocessof$REPLY 2>/dev/null
    done
    


    echo "start pulling..."

    echo "your choice : $REPLY"

    if [[ $REPLY == 'all' ]];then
        for i in $(cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
        do
            pull $i "auto"
        done
    else
            pull $REPLY "normal"
    fi
}
function pull () {

    declare -a info
    set -e
    cd ~/Desktop/.gitprocess/gitprocessof$1/ 2>/dev/null
    set +e

    info[0]=$(grep "url:" ginfo_$1.txt | cut -c5-)
    info[1]=$(grep "repn:" ginfo_$1.txt| cut -c6-)
    info[2]=$(grep "route:" ginfo_$1.txt| cut -c7-)
    info[3]=$(grep "prevo:" ginfo_$1.txt| cut -c7-)
    info[4]=$(grep "prevt:" ginfo_$1.txt| cut -c7-)




    pullmode=$2

    cd ${info[2]}


    if [[ ${pullmode} == "auto" && "${info[3]}" != '_nobranch' ]] ;then

        ownbranch=${info[3]}
        tarbranch=${info[4]}

    elif [[ ${pullmode} == "auto" && "${info[3]}" == '_nobranch' ]];then
    #在if 判斷式中一個變數中有空格在錢錢符號外圍要加上雙引號

        exit 87

    else

        read -p "own branch: " ownbranch
        back $ownbranch
        read -p "tar branch: " tarbranch 
        back $tarbranch

    fi

    git checkout ${ownbranch} 2>/dev/null

    git remote remove ${info[1]} 2>/dev/null

    git remote add ${info[1]} ${info[0]}  2>/dev/null   #error when remote node is exist

    set -e

    git pull ${info[1]} $tarbranch 

    cd ~/Desktop/.gitprocess/gitprocessof$1/

    tochange=$(grep "prevo:" ginfo_$1.txt | cut -c7-)

    sed -i '' "/prevo:/s/$tochange/${ownbranch}/" ginfo_$1.txt

    tochange=$(grep "prevt:" ginfo_$1.txt | cut -c7-)

    sed -i '' "/prevt:/s/$tochange/${tarbranch}/" ginfo_$1.txt
}
do_pull