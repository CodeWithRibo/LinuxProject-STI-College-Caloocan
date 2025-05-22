#!/bin/sh

listDirectiories () {
    clear
    echo "------------------------------------------------------------"
    echo "Here is the detailed information about directories"
    echo "------------------------------------------------------------"
    ls -d */
    echo "------------------------------------------------------------"
}

listFiles () { 
    clear
    echo "------------------------------------------------------------"
    echo "Here is the detailed information about txt files"
    echo "------------------------------------------------------------"
    ls *.txt
    echo "------------------------------------------------------------"
}


takeNotes () { 
    clear
    echo "============================================================"
    echo "📝            Welcome to the Note Taking Section            📝"
    echo "============================================================"
    echo ""
    echo "Please enter your note below (press Ctrl+D to finish):"
    echo ""
    cat >> $inputUser
    echo ""
    echo "------------------------------------------------------------"
    echo "Your note has been saved to " $inputUser
    echo "------------------------------------------------------------"
}

list () { 
            clear
            echo "============================================================"
            echo "📂                Listing All Files & Folders               📂"
            echo "============================================================"
            ls -l
            echo "============================================================"
    
}
