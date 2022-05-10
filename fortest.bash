#push
#! /bin/bash
set -e
cd ${route}
read -p "own branch" ownbranch 
read -p "tar branch" tarbranch 
git checkout \$ownbranch  
git remote add $rname $url      #error when remote node is exist
if [[ \$(git status | grep -q '沒有要提交的檔案，工作區為乾淨狀態') ]];then
    echo "no files to add,push failed"
    kill -TERM $$
fi
git add --all 
git commit -m "commit on \$(date)"
git pull $rname \$tarbranch
git push $rname \${ownbranch}:\${tarbranch}



#pull
#! /bin/bash
set -e
cd ${route}
read -p "own branch: " ownbranch
read -p "tar branch: " tarbranch
git checkout \${ownbranch}
git pull $rname \${tarbranch}