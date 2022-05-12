#! /bin/bash

declare -a info

#echo "$1 $2"
cd ~/Desktop/.gitprocess/gitprocessof$1/

info[0]=$(grep "url:" ginfo_$1.txt | cut -c5-)
info[1]=$(grep "repn:" ginfo_$1.txt| cut -c6-)
info[2]=$(grep "route:" ginfo_$1.txt| cut -c7-)
info[3]=$(grep "prevo:" ginfo_$1.txt| cut -c7-)
info[4]=$(grep "prevt:" ginfo_$1.txt| cut -c7-)
#echo "${info[@]}"

pushmode=$2

cd ${info[2]}

if [[ ${pushmode} == "auto" && "${info[3]}" != '_nobranch' ]] ;then

    ownbranch=${info[3]}
    tarbranch=${info[4]}

elif [[ ${pushmode} == "auto" && "${info[3]}" == '_nobranch' ]];then

    exit 87

else
    read -p "own branch: " ownbranch 
    read -p "tar branch: " tarbranch 

fi

git checkout $ownbranch 2>/dev/null

git remote remove ${info[1]} 2>/dev/null

git remote add ${info[1]} ${info[0]}  2>/dev/null   #error when remote node is exist

git add --all 
set -e #every git push will change DS store ,so you can pull cand push without changing

git commit -m "commit on $(date)" 

git pull ${info[1]} $tarbranch 

git push ${info[1]} ${ownbranch}:${tarbranch}

cd ~/Desktop/.gitprocess/gitprocessof$1/

tochange=$(grep "prevo:" ginfo_$1.txt | cut -c7-)

sed -i '' "/prevo:/s/$tochange/${ownbranch}/" ginfo_$1.txt

tochange=$(grep "prevt:" ginfo_$1.txt | cut -c7-)

sed -i '' "/prevt:/s/$tochange/${tarbranch}/" ginfo_$1.txt
