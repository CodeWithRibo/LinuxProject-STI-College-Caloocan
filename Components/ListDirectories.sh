#!/bin/sh

listDirectiories () {
    clear
    echo "------------------------------------------------------------"
    echo "Here is the detailed information about directories"
    echo "------------------------------------------------------------"
    ls -d */
    echo "------------------------------------------------------------"
}

listZipFile () {
    clear
    echo "------------------------------------------------------------"
    echo "Here is the detailed information about directories"
    echo "------------------------------------------------------------"
    ls *.zip
    echo "------------------------------------------------------------"
}


listFiles () { 
    clear
    echo "------------------------------------------------------------"
    echo "Here is the detailed information about txt files"
    echo "------------------------------------------------------------"
    ls *.txt 2>/dev/null | grep -q .  && ls *.txt || echo "No txt file found"
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
     echo "============================================================"
     echo "📂   Listing All Zip Files, Regular Files & Folders      📂"
     ls -pl | grep -v '/$' | grep -v '\.zip$'
     echo "============================================================"
     ls -ld */
     echo "============================================================"
     ls *.zip 2>/dev/null | grep -q .  && ls *.zip || echo "No zip file found" 
     echo "============================================================"

}
listText() {
    echo "------------------------------------------------------------"
    echo "You have successfully set the permission to: $setPermission for $setUserPermission"
    echo "------------------------------------------------------------"
     ls *.txt 2>/dev/null | grep -q .  && ls *.txt || echo "No txt file found" 
    echo "------------------------------------------------------------"
     ls -ld */ 2>/dev/null | grep -q .  && ls -ld */ || echo "No txt file found" 
}   