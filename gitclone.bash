#! /bin/bash
#set -e
read -p "clone where? " url
read -p "create dir? yes or no? "
 


if [[ $REPLY == "yes" ]];then
    read -p "what name? " name
    read -p "under where? " fdir
    cd $fdir
    mkdir ${name}
    echo "start cloning......"
    git clone $url "$fdir/$name/"
else 
    read -p "save where" fdir
    echo "start cloning......"
    git clone "$url" "$fdir"

fi
 
echo "finished cloning"

  