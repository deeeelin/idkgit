#! /bin/bash
function back () {

    if [[ $1 == "b/" ]];then
        exit 88
    fi
    return 
}
function check_name () {
    read -p "directory name of the cloned repository : " name ; back ${name}

    
    while [[ ${name} == ''  ]]
    do
       echo "error , name invalid !"
       back ${name}
       read -p "directory name of the cloned repository : " name ; back ${name}
    done

    return 
}
function check_url () {
    
    read -p "clone repository url : " url ; back ${url}

    while [[ ${url} == ''  ]]
    do
       echo "error , can't be empty !"
       read -p "clone repository url : " url ; back ${url}
    done
    return 

}
function clone () {

    check_url

    PS3="make directory ?"
    select r in yes no
    do
        if [[ $r == "yes" ]];then

            check_name

            read -p "clone under which directory (enter directory path):  " fdir ; back ${fdir}
            cd $fdir 2>/dev/null

            while [[ $fdir == '' || $? -eq 1 ]]
            do
                echo "wrong path"
                read -p "clone under which directory (enter directory path):  " fdir ; back ${fdir}
                cd $fdir 2>/dev/null
            done

            mkdir ${name}
            echo "start cloning......"

            set -e
            git clone $url "$fdir/$name/"

            break

        elif [[ $r == "no" ]];then

            read -p "clone repository to which directory (enter directory path) : " fdir ; back ${fdir}
            cd $fdir
            while [[ $fdir == '' || $? -eq 1 ]]
            do
                echo "wrong path"
                read -p "clone repository to which directory (enter directory path) : " fdir ; back ${fdir}
                cd $fdir
            done

            echo "start cloning......"
            set -e
            git clone "$url" "$fdir"  
            break

        
        elif [[ $REPLY == "b/" ]];then 
            exit 88

        else echo "invalid choice !"

        fi
    done

    
    return 

}
clone
  