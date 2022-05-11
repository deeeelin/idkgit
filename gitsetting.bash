#! /bin/bash
set -e

echo "start creating....."


read -p "please enter the remote repository url: " url

read -p "please enter repository name: " rname

read -p "please enter your folder path: "  route

cd ${route} 

read -p "please enter your project name: " name

cd ~/Desktop/
mkdir -p .gitprocess
cd .gitprocess/
mkdir -p gitprocessof${name}
cd gitprocessof${name}/
touch gpsh_${name}.bash
touch gpul_${name}.bash
echo "_nobranch _nobranch" > ginfo_${name}.txt #written into file is disable when using echo to a bash document
exec 12>gpsh_${name}.bash
exec 13>gpul_${name}.bash

cat  >& 12 <<Here
#! /bin/bash


pushmode="normal"

cd ~/Desktop/.gitprocess/gitprocessof${name}/

read -a previous < ginfo_${name}.txt

cd ${route}

if [[ \${pushmode} == "auto" && "\${previous[*]}" != '_nobranch _nobranch' ]] ;then

    ownbranch=\${previous[0]}
    tarbranch=\${previous[1]}

elif [[ \${pushmode} == "auto" && "\${previous[*]}" == '_nobranch _nobranch' ]];then

    exit 87

else
    read -p "own branch: " ownbranch 
    read -p "tar branch: " tarbranch 

fi

git checkout \$ownbranch 2>/dev/null

git remote add $rname $url  2>/dev/null   #error when remote node is exist

git add --all 
set -e #every git push will change DS store ,so you can pull cand push without changing

git commit -m "commit on \$(date)" 

git pull $rname \$tarbranch 

git push $rname \${ownbranch}:\${tarbranch}

cd ~/Desktop/.gitprocess/gitprocessof${name}/

echo "\${ownbranch} \${tarbranch}" > ginfo_${name}.txt
Here

cat  >& 13  <<Here 
#! /bin/bash
pullmode="normal"
cd ~/Desktop/.gitprocess/gitprocessof${name}/
read -a previous < ginfo_${name}.txt


cd ${route}
if [[ \${pullmode} == "auto" && "\${previous[*]}" != '_nobranch _nobranch' ]];then

    read ownbranch=\${previous[0]}
    read tarbranch=\${previous[1]}

elif [[ \${pullmode} == "auto" && "\${previous[*]}" == '_nobranch _nobranch' ]];then #在if 判斷式中一個變數中有空格在錢錢符號外圍要加上雙引號

    exit 87

else

    read -p "own branch: " ownbranch 
    read -p "tar branch: " tarbranch 

fi

git checkout \${ownbranch} 2>/dev/null
set -e
git pull $rname \${tarbranch} 
cd ~/Desktop/.gitprocess/gitprocessof${name}/
echo "\${ownbranch} \${tarbranch}" > ginfo_${name}.txt


Here






echo "finished settings" 



