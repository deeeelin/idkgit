#! /bin/bash
set -e
function back () {

    if [[ $2 == "b/" ]];then
        exit 88
    fi

    return 
}


function pp () {

    declare -a info

    
    cd ${IDKDIR}/gitprocess/gitprocessof$2/ 


    info[0]=$(grep "url:" ginfo_$2.txt | cut -c5-)
    info[1]=$(grep "repn:" ginfo_$2.txt| cut -c6-)
    info[2]=$(grep "route:" ginfo_$2.txt| cut -c7-)
    info[3]=$(grep "prevo:" ginfo_$2.txt| cut -c7-)
    info[4]=$(grep "prevt:" ginfo_$2.txt| cut -c7-)


    actmode=$3

    cd ${info[2]}

    if [[ ${actmode} == "auto" && "${info[3]}" != '_nobranch' ]] ;then

        ownbranch=${info[3]}
        tarbranch=${info[4]}

    elif [[ ${actmode} == "auto" && "${info[3]}" == '_nobranch' ]];then

        echo "no previous reference for $2"

        exit 1

    else
        read -p "own branch: " ownbranch
        back $ownbranch
        read -p "tar branch: " tarbranch 
        back $tarbranch

    fi

    git checkout $ownbranch
    
    set +e
    git remote remove ${info[1]}
    set -e

    git remote add ${info[1]} ${info[0]} 

    git add --all 
     
    if [[ $1 == "push" ]];then
        cd $IDKDIR
        IFS=
        read t<commitmessage.txt
        cd ${info[2]}
        
        if [[ -n t && ${#t} -gt 0 ]];then
             git commit -m "$t , commit on $(date)" 
        else
            git commit -m "commit on $(date)"
        fi 

    fi

    git push ${info[1]} ${ownbranch}:${tarbranch}
    
    cd ${IDKDIR}/gitprocess/gitprocessof$2/

    tochange=$(grep "prevo:" ginfo_$2.txt | cut -c7-)

    sed -i '' "/prevo:/s/$tochange/${ownbranch}/" ginfo_$2.txt

    tochange=$(grep "prevt:" ginfo_$2.txt | cut -c7-)

    sed -i '' "/prevt:/s/$tochange/${tarbranch}/" ginfo_$2.txt
    return
}

pp $1 $2 $3 
