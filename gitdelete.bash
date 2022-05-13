function delete () { 

    declare -a dlist
    dlist=$(cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
    dlist+=" all"
    dlist+=" back"

    PS3="proj name: "
    select p in ${dlist}
    do
        if [[ $p == 'all' ]];then

            for i in $(cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
                do
                    cd ~/Desktop/.gitprocess/
                    echo "start deleting..."
                    rm -rf dir gitprocessof$i 
                done

            break
        
        elif [[ $p == "back" ]];then
            exit 88

        else
            
            cd ~/Desktop/.gitprocess/
            echo "start deleting..." 
            rm -rf dir gitprocessof$p 
            cd ~/Desktop/.gitprocess/gitprocessof$p 2>/dev/null

            if [[ $? -eq 1 || $REPLY == '' ]];then   
                echo "delete fail,project name non-found,choose again"
            else
                break 
            fi
        fi
    done

    echo "delete process finished"

    return
}
delete