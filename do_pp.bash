#! /bin/bash
function back () {

    if [[ $1 == "b/" ]];then
        exit 88
    fi

    return 
}

function do_pp () {

    local cond
    local noprev=0

    read -p "project name : " 
    back $REPLY

    cd ${IDKDIR}/gitprocess/gitprocessof$REPLY 2>/dev/null

    while [[ $? -eq 1 && $REPLY != "all" ]] 
    do 
        echo "no such project "
        read -p "project name: "
        back $REPLY
        cd ${IDKDIR}/gitprocess/gitprocessof$REPLY 2>/dev/null
    done

    echo "start ${mode}ing $REPLY"

    if [[ "$REPLY" == 'all' ]]; then 

        for i in $(cd ${IDKDIR}/gitprocess/; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p')
        do
            cd ${IDKDIR}
            chmod +x ./pp.bash
            ./pp.bash ${mode} $i "auto"
            cond=$?
            if [[ $cond -eq 0 ]];then
                echo "$i ${mode} successed"

            else 
                echo "$i ${mode} failed"
            fi
        done

    else
            cd ${IDKDIR}
            chmod +x ./pp.bash
            source ./pp.bash ${mode} $REPLY "normal"   #bash -x
            cond=$?

            if [[ $cond -eq 0 ]];then
               echo "$REPLY ${mode} successed"
            else
               echo "$REPLY ${mode} failed"
               
            fi       
    fi
    return 
}

if [[ $1 == "push" ]];then
    mode="push"
else
    mode="pull"
fi

do_pp