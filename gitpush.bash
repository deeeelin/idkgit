#! /bin/bash
function back () {
    if [[ $1 == "back" ]];then
        exit 88
    fi
    return 
}
function do_push () {
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

    echo "start pushing..."

    echo "your choice : $REPLY"

    if [[ "$REPLY" == 'all' ]]; then #not yet apply auto to own and tar branch

        for i in $(cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
            do
            push $i "auto"
            if [[ $? -eq 1 ]];then
                echo "$i push failed"
            else 
                echo "$i push success"
            fi
            done

    else
            push $REPLY "normal"  
            if [[ $? -eq 1 ]];then
               exit 1
            else
               echo "$REPLY push success"
            fi       
    fi
}
function push () {

    declare -a info

    #echo "$1 $2"
    set -e
    cd ~/Desktop/.gitprocess/gitprocessof$1/ 2>/dev/null
    set +e

    info[0]=$(grep "url:" ginfo_$1.txt | cut -c5-)
    info[1]=$(grep "repn:" ginfo_$1.txt| cut -c6-)
    info[2]=$(grep "route:" ginfo_$1.txt| cut -c7-)
    info[3]=$(grep "prevo:" ginfo_$1.txt| cut -c7-)
    info[4]=$(grep "prevt:" ginfo_$1.txt| cut -c7-)


    pushmode=$2

    cd ${info[2]}

    if [[ ${pushmode} == "auto" && "${info[3]}" != '_nobranch' ]] ;then

        ownbranch=${info[3]}
        tarbranch=${info[4]}

    elif [[ ${pushmode} == "auto" && "${info[3]}" == '_nobranch' ]];then

        exit 87

    else
        read -p "own branch: " ownbranch
        back $ownbranch
        read -p "tar branch: " tarbranch 
        back $tarbranch

    fi

    git checkout $ownbranch 2>/dev/null

    git remote remove ${info[1]} 2>/dev/null

    git remote add ${info[1]} ${info[0]}  2>/dev/null   #error when remote node is exist

    git add --all 
     #every git push will change DS store ,so you can pull cand push without changing

    git commit -m "commit on $(date)" 
    
    if [[ $? -eq 1 ]];then 
        return 1
    fi
    git pull ${info[1]} $tarbranch 

    git push ${info[1]} ${ownbranch}:${tarbranch}

    cd ~/Desktop/.gitprocess/gitprocessof$1/

    tochange=$(grep "prevo:" ginfo_$1.txt | cut -c7-)

    sed -i '' "/prevo:/s/$tochange/${ownbranch}/" ginfo_$1.txt

    tochange=$(grep "prevt:" ginfo_$1.txt | cut -c7-)

    sed -i '' "/prevt:/s/$tochange/${tarbranch}/" ginfo_$1.txt
}
do_push
