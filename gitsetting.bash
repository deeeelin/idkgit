#! /bin/bash
set -e

echo "start creating....."

read -p "please enter the remote repository url: " url

read -p "please enter repository name: " rname

read -p "please enter your folder path (absolute path): "  route

cd ${route}  #make it coller

read -p "please enter your project name: " name

cd ~/Desktop/
mkdir -p .gitprocess
cd .gitprocess/
mkdir -p gitprocessof${name}
cd gitprocessof${name}/

echo "url:${url}" >> ginfo_${name}.txt
echo "repn:${rname}" >> ginfo_${name}.txt
echo "route:${route}" >> ginfo_${name}.txt
echo "prevo:_nobranch" >> ginfo_${name}.txt #written into file is disable when using echo to a bash document
echo "prevt:_nobranch" >> ginfo_${name}.txt


echo "finished settings" 



