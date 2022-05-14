#! /bin/bash
function back () {

    if [[ $1 == "b/" ]];then
        exit 88
    fi
    return 
}
function clone () {

    read -p "clone where? " url 
    back ${url}

    PS3="make directory ?"
    select r in yes no
    do
        if [[ $r == "yes" ]];then

            read -p "what name? " name ; back ${name}

            read -p "under where? " fdir ; back ${fdir}
            cd $fdir 2>/dev/null

            while [[ $fdir == '' || $? -eq 1 ]]
            do
                echo "wrong path"
                read -p "under where? " fdir ; back ${fdir}
                cd $fdir 2>/dev/null
            done

            mkdir ${name}
            echo "start cloning......"

            set -e
            git clone $url "$fdir/$name/"

            break

        else 

            read -p "save where" fdir ; back ${fdir}
            cd $fdir
            while [[ $fdir == '' || $? -eq 1 ]]
            do
                echo "wrong path"
                read -p "save where? " fdir ; back ${fdir}
                cd $fdir
            done

            echo "start cloning......"
            set -e
            git clone "$url" "$fdir"  
            break

        fi
    done

    echo "finished cloning"
    return 

}
clone
  