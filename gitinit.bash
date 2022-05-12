#! /bin/bash

# error when path =enter
read -p "give me a path: " route


echo "start initializing....."

cd ${route} 2>/dev/null
if [[ $? -eq 1 ]];then
    echo "path wrong do again"
    read -p "give me a path: " route
    cd ${route} 2>/dev/null
fi

git init

git add  --all 
set -e
git commit -m "first commit on $(date)"
echo  "finished git initialize and commit"
