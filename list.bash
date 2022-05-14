function list () {
    
    echo "current projects:"

    cd ${IDKDIR}/gitprocess/ 2>/dev/null
    find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p' 

        
    echo 
    echo
    return
}
list