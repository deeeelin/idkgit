#! /bin/bash
#set -e

read -p "give me a path: " route

echo "start initializing....."

cd ${route}
git init
if [[ $(git status | grep -q '沒有要提交的檔案，工作區為乾淨狀態') ]];then
    echo "no files ot add,init failed"
    kill -TERM $$
fi
git add  --all 
git commit -m "first commit on \$(date)"
echo  "finished git initialize and commit"
