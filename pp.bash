#! /bin/bash
function back () {

    if [[ $1 == "back" ]];then
        exit 88
    fi

    return 
}
function do_pp () {

    local cond
    local noprev=0

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

    echo "start ${mode}ing..."
    echo "your choice : $REPLY"

    if [[ "$REPLY" == 'all' ]]; then 

        for i in $(cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
        do
            pp $i "auto"
            cond=$?
            if [[ $cond -eq 1 ]];then
                echo "$i ${mode} failed"
            elif [[ $cond -eq 87 ]];then
                echo "no prev ref for $i,$i ${mode} failed"
                noprev=1
            else 
                echo "$i ${mode} success"
            fi
        done

        if [[ $noprev -eq 1 ]];then 
            exit 87
        fi

    else
            pp $REPLY "normal"  
            cond=$?

            if [[ $cond -eq 1 ]];then
               exit 1
            elif [[ $cond -eq 87 ]];then 
               exit 87
            else
               echo "$REPLY ${mode} success"
            fi       
    fi
    return 
}
function pp () {

    declare -a info

    set -e
    cd ~/Desktop/.gitprocess/gitprocessof$1/ 2>/dev/null
    set +e

    info[0]=$(grep "url:" ginfo_$1.txt | cut -c5-)
    info[1]=$(grep "repn:" ginfo_$1.txt| cut -c6-)
    info[2]=$(grep "route:" ginfo_$1.txt| cut -c7-)
    info[3]=$(grep "prevo:" ginfo_$1.txt| cut -c7-)
    info[4]=$(grep "prevt:" ginfo_$1.txt| cut -c7-)


    actmode=$2

    cd ${info[2]}

    if [[ ${actmode} == "auto" && "${info[3]}" != '_nobranch' ]] ;then

        ownbranch=${info[3]}
        tarbranch=${info[4]}

    elif [[ ${actmode} == "auto" && "${info[3]}" == '_nobranch' ]];then

        return 87

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
    if [[ ${mode} == "push" ]];then
        cd $IDKDIR
        IFS=
        read t<commitmessage.txt
        cd ${info[2]}
        
        if [[ -n t && ${#t} -gt 0 ]];then
             git commit -m "$t , commit on $(date)" 
             cond=$?
        else
            git commit -m "commit on $(date)"
             cond=$?
        fi 
    
        if [[ $cond -eq 1 ]];then 
             return 1
        fi
    fi
    
    git pull ${info[1]} $tarbranch 
    
    if [[ ${mode} == "push" ]];then
        git push ${info[1]} ${ownbranch}:${tarbranch}
    fi

    cd ~/Desktop/.gitprocess/gitprocessof$1/

    tochange=$(grep "prevo:" ginfo_$1.txt | cut -c7-)

    sed -i '' "/prevo:/s/$tochange/${ownbranch}/" ginfo_$1.txt

    tochange=$(grep "prevt:" ginfo_$1.txt | cut -c7-)

    sed -i '' "/prevt:/s/$tochange/${tarbranch}/" ginfo_$1.txt
    return
}

if [[ $1 == "push" ]];then
    mode="push"
else
    mode="pull"
fi

do_pp 
