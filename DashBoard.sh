#!/bin/sh
   source Components/ListDirectories.sh
   source Components/WelcomeView.sh

   welcomeView #Function

option=0

while [ $option -ne 6 ]; do
    echo "[1] Create a folder"
    echo "[2] Create a file"
    echo "[3] List Folder and File"
    echo "[4] Delete a folder or file"
    echo "[5] Take notes"
    echo "[6] Exit"

    read -p "Select an option: " option

    case $option in
        1)
            read -p "Enter folder name: " folderName
            if [ -d "$folderName" ]; then
                echo "Folder already exists"
            else
                mkdir "$folderName"
                echo "Folder $folderName has been created."
                # read -p "Do you want to set a permission for that folder? (Y/N): " permission
                # if [ "$permission" = "Y" ] || [ "$permission" = "y" ]; then
                #     read -p "Enter permission (ex: 700): " setPermission
                #     chmod "$setPermission" "$folderName"
                #     echo "Permission $setPermission has been set for folder $folderName"
                # fi
            fi
            ;;
        2)
            read -p "Enter file name: " fileName
            if [ -f "$fileName" ]; then
                echo "File already exists"
            else
                touch "$fileName"
                echo "File $fileName has been created."
                # read -p "Do you want to set a permission for that file? (Y/N): " permission
                # if [ "$permission" = "Y" ] || [ "$permission" = "y" ]; then
                #     read -p "Enter permission (ex: 700): " setPermission
                #     chmod "$setPermission" "$fileName"
                #     echo "Permission $setPermission has been set for file $fileName"
                # fi
            fi
            ;;
        3)
            list #Function
            echo "[1] Rename Files or Directories"
            echo "[2] Set Permission Files or Directories"
            read -p "Choose selection : " inputSelection

            case $inputSelection in
            1)
                read -p "Input File or Directory Name : " file_directory_name

                if [ -e $file_directory_name ]; then
                read -p "Input New Name: " new_name
                mv $file_directory_name $new_name
                echo "You have sucessfully renamed $file_directory_name to $new_name"
                else
                echo "$file_directory_name does not exist"
                fi
                ;;
            2) 
                read -p "Enter the name of the file or directory for which you want to set permissions: " setUserPermission
                if  [ ! -e $setUserPermission ]; then 
                    echo "File does not exist"
                    continue
                fi

                read -p "Enter permission (ex: 700): " setPermission                
                if [ ! $setPermission -ge 778 ]; then 
                chmod "$setPermission" "$setUserPermission"
                sleep 1
                listText #Function
                else 
                    echo "set permission denied"
                fi
                ;;
            *) 
                echo "Invalid Input. Please try again.";;
            esac
            ;;
        4)
            read -p "Enter the content (file or folder) you want to delete: " deleteContent
            if [ "$deleteContent" = "file" ]; then
                listFiles #Function
                read -p "Enter file you want to delete: " deleteFile
                rm "$deleteFile"
                echo "File $deleteFile has been successfully deleted."
            elif [ "$deleteContent" = "folder" ]; then
                #Function
                listDirectiories #Function
                read -p "Enter folder you want to delete: " deleteFolder
                rm -rf "$deleteFolder"
                echo "Folder $deleteFolder has been successfully deleted."
            else
                echo "Invalid type: $deleteContent is not a valid option."
            fi
            ;;
        5)
            listFiles #Function
            read -p "Enter file you want to take a note: " inputUser

            if [ -f $inputUser ]; then
            takeNotes #Function
            else
            echo "$inputUser is not in the file selection "
            fi

            ;;
        6)  echo "Thank your for choosing GMP Linux File Explorer "
            ;;

        *)
            echo "Invalid Input. Please try again."
            ;;
    esac
done
