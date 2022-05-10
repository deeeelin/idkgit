#! /bin/bash
#set -e

read -p "give me a path: " route

echo "start initializing....."

cd ${route}
git init
git add  --all 
git commit -m "first commit on $(date)"
echo  "finished git initialize and commit"
