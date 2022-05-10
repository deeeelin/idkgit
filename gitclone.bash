#! /bin/bash
#set -e
read -p "clone where? " url
read -p "create dir? yes or no? "
 
echo "start cloning......"

if [[ $REPLY == "yes" ]];then
    read -p "what name? " name
    read -p "under where? " fdir
    cd $fdir
    mkdir ${name}
    git clone $url "$fdir/$name/"
else 
    read -p "save where" fdir
    git clone "$url" "$fdir"

fi
 
echo "finished cloning"

  