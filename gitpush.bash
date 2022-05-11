#! /bin/bash
set -e

pushmode="normal"
read previous<ginfo_${name}.bash
cd ${route}

if [[ pushmode == "auto" && ${previous[*]} != '_null _null' ]];then

    read -p "own branch" ownbranch <${previous[0]}
    read -p "tar branch" tarbranch <${previous[1]}

else if [[ pushmode == "auto" && ${previous[*]} == '_null _null' ]];then

    exit 1

else
    read -p "own branch" ownbranch 
    read -p "tar branch" tarbranch 

fi

git checkout \$ownbranch  
git remote add $rname $url      #error when remote node is exist

if [[ \$(git status | grep -q '沒有要提交的檔案，工作區為乾淨狀態') ]];then

    echo "no files to add,push failed"
    exit 1

fi

git add --all 
git commit -m "commit on \$(date)"
git pull $rname \$tarbranch
git push $rname \${ownbranch}:\${tarbranch}
echo "\${ownbranch} \${tarbranch}"> ginfo_${name}.bash