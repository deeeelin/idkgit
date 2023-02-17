function delete () { 
    cd ${IDKDIR}/gitprocess/
   
    declare -a dlist
    dlist=$(find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
    dlist+=" all"
    

    PS3="project name: "
    select p in ${dlist}
    do
        if [[ $p == 'all' ]];then

            for i in $(find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
                do
                    echo "start deleting..."
                    rm -rf dir gitprocessof$i 
                done

            break
        
        elif [[ $REPLY == "b/" ]];then
            exit 88

        else
            
            cd ${IDKDIR}/gitprocess/gitprocessof$p 2>/dev/null

            if [[ $? -eq 1 || $REPLY == '' ]];then   
                echo "delete fail,project name non-found,choose again"
            else
                echo "start deleting..." 
                cd ${IDKDIR}/gitprocess/
                rm -rf dir gitprocessof$p 
                break 
            fi
        fi
    done

    echo "delete process finished"

    return
}
delete