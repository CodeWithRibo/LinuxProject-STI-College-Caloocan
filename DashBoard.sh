#!/bin/sh
   source Components/ListDirectories.sh
   source Components/WelcomeView.sh
   source Components/Validation.sh

   welcomeView #Function

option=0
while [ $option -ne 7 ]; do
    echo "[1] Create a folder"
    echo "[2] Create a file"
    echo "[3] List Folder and File"
    echo "[4] Delete"
    echo "[5] Take notes"
    echo "[6] Set Password the File"
    echo "[7] Exit"

    read -p "Select an option: " option

    case $option in
        1)
            validateFolder
            ;;
        2)
            validateFiles
            ;;
        3)
            list #Function

            inputSelection=0 

            until [ $inputSelection -eq 4 ]; do            
            echo "[1] Rename Files or Directories"
            echo "[2] Move files or Directories"
            echo "[3] Set Permission Files or Directories"
            echo "[4] Back to Dashboard"
            read -p "Choose selection : " inputSelection

            #Nested Switch Case
            case $inputSelection in
            1)
            validateRename
                ;;
            2)
            validateMove
                ;;
            3) 
            validateSetPermission
                ;;
            4) clear; welcomeView; continue  ;;
            * ) 
                echo "Invalid Input. Please try again.";;
            esac
            done
            ;;
        4)
            delete
            ;;
        5)
            validateTakeNotes
            ;;
        6)
            clear
            inputSelection=0 

            until [ $inputSelection -eq 4 ]; do            
            echo "[1] Encrypt the File or Folder"
            echo "[2] Decrypted the File or Folder"
            echo "[3] Back to the DashBoard"            
            read -p "Choose selection : " inputSelection

            #Nested Switch Case
            case $inputSelection in
            1)
                encrypt
            ;;
            2)
                decrypt
            ;;
            3) clear; welcomeView;  break;;
            esac
            done
            ;;
        7)  echo "Thank your for choosing GMP Linux File Explorer "
            ;;

        *)
            echo "Invalid Input. Please try again."
            ;;
    esac
done

