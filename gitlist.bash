function list () {
    
    echo "current projects:"

    cd ~/Desktop/.gitprocess/ ; find . -name 'gitprocessof*'| sed -e 's/^..//' -e 's/gitprocessof//' -e 's/.bash//p'

    echo
    echo
    return
}
list