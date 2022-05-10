#! /bin/bash
#set -e

echo "start creating....."


read -p "please enter the remote repository url: " url

read -p "please enter repository name: " rname

read -p "please enter your folder path: "  route

read -p "please enter your project name: " name

cd ~/Desktop/
mkdir -p .gitprocess
cd .gitprocess/
mkdir gitprocessof${name}
cd gitprocessof${name}/
touch gpsh_${name}.bash
touch gpul_${name}.bash
exec 12>gpsh_${name}.bash
exec 13>gpul_${name}.bash


cat >& 12 << HERE 
#! /bin/bash
#set -e
cd ${route}
read -p "own branch" ownbranch
read -p "tar branch" tarbranch
git checkout \$ownbranch
git remote add $rname $url      #error when remote node is exist
git add --all
git commit -m "commit on $(date)"
git pull $rname \$tarbranch
git push $rname \${ownbranch}:\${tarbranch}
HERE


cat >& 13 << HERE23
#! /bin/bash
#set -e
cd ${route}
read -p "own branch: " ownbranch
read -p "tar branch: " tarbranch
git checkout \${ownbranch}
git pull $rname \${tarbranch}
HERE23


echo "finished settings" 



