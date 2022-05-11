#! /bin/bash
set -e
read previous<ginfo_${name}.bash
pullmode=normal

cd ${route}
if [[ pullmode == "auto" && ${previous[*]} != _null _null ]];then

    read -p "own branch" ownbranch <${previous[0]}
    read -p "tar branch" tarbranch <${previous[1]}

else if [[ pullmode == "auto" && ${previous[*]} == _null _null ]];then

    exit 1

else

    read -p "own branch" ownbranch 
    read -p "tar branch" tarbranch 

fi

git checkout \${ownbranch}
git pull $rname \${tarbranch}

echo "\${ownbranch} \${tarbranch}"> ginfo_${name}.bash