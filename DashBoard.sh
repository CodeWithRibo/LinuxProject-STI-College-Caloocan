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
    echo "[4] Delete a folder or file"
    echo "[5] Take notes"
    echo "[6] Set Password the File or Folder"
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
                read -p "Enter the name of the File or Directory for which you want to set permissions: " setUserPermission
                [ ! -e "$setUserPermission" ] && { echo "File or Directory does not exist"; continue; }

                read -p "Enter permission (ex: 700): " setPermission                
                if [ ! $setPermission -ge 778 ]; then 
                chmod "$setPermission" "$setUserPermission"
                sleep 1
                listText #Function
                else 
                    echo "set permission denied"
                fi
                ;;
            4) clear; welcomeView; continue  ;;
            * ) 
                echo "Invalid Input. Please try again.";;
            esac
            done
            ;;
        4)
            clear
            echo "[1] File"
            echo "[2] Folder"
            echo "[3] Zip File"
            read -p "Type the content you want to delete: " deleteContent
            
            if [ "$deleteContent" -eq 1 ]; then
                listFiles
                # read -p  "Enter file you want to delete: " deleteFile 
                # [ ! -e $deleteFile ]  && echo "file does not exist" ||
                # echo "File $deleteFile has been successfully deleted. $(rm $deleteFile)"
            elif [ "$deleteContent" -eq 2 ]; then
                listDirectiories #Function  
                read -p "Enter folder you want to delete: " deleteFolder
                rm -rf "$deleteFolder"
                echo "Folder $deleteFolder has been successfully deleted."
            elif [ "$deleteContent" -eq 3 ]; then
                listZipFile #Function
                read -p "Enter folder you want to delete: " deleteZipFile                
                rm -rf "$deleteZipFile"
                echo "Zip File $deleteZipFile has been successfully deleted."
            else
                echo "Invalid type: $deleteContent is not a valid option."
            fi
            ;;
        5)
            listFiles #Function
            read -p "Enter file you want to take a note: " inputUser
            [ -f $inputUser ]  && takeNotes || echo "$inputUser is not in the file selection "
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
            list #Function
            read -p "Enter File or Directory Name : " file_directory_name
            read -p "Enter Passwword to encrypt : " -password
            openssl enc -aes-256-cbc -salt -in "${file_directory_name}.zip" -out "${file_directory_name}.enc" -k "$password"
            # rm "${file_directory_name}.zip"

            ;;
            2)
            list #Function
            read -p "Enter File or Directory Name : " file_directory_name
            read -p "Enter password to decrypt: " password
            openssl enc -aes-256-cbc -d -in "${file_directory_name}.enc" -out "${file_directory_name}.zip" -k "$password"
            unzip "${file_directory_name}.zip"

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
