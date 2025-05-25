#!/bin/sh
source Components/ListDirectories.sh
source Dashboard.sh

error="Error: Invalid input. Please try again"
            
validateFolder () 
{
    while true; do
        read -p "Enter folder name: " folderName
        [ -n "$folderName" ] && break || echo "$error"
    done
    [ ! -d "$folderName" ] && echo "$(mkdir $folderName)Folder $folderName has been created " || echo "Folder already exists"  
}

validateFiles () 
{
    while true; do
        read -p "Enter file name: " fileName
        [ -n "$fileName" ] && break || echo "$error"
    done        
        if [ -f $fileName ]; then
        echo "File is already exist"
        elif find /home/adminriboluna/LinuxProject-STI-College-Caloocan -name "$fileName" 2>/dev/null | grep -q .; then
        echo "The File $fileName is already exist in another directory"
        else 
        echo "$(touch $fileName)File $fileName has been created. "
        fi

}

#Validation for Listing All Zip Files, Regular Files & Folders
#Validate Rename Files or Directories
validateRename () 
{
    while true; do
        read -p "Enter File or Directory Name : " file_directory_name
        [ -n "$file_directory_name" ] && break || echo "$error"
    done
        if [ -e "$file_directory_name" ]; then
            read -p "Enter New Name: " new_name
            if find /home/adminriboluna/LinuxProject-STI-College-Caloocan -name "$new_name" 2>/dev/null | grep -q .; then
            echo "The $new_name is already exist in another directory"            
            else  
            mv "$file_directory_name" "$new_name"
            echo "You have sucessfully renamed $file_directory_name to $new_name"
            fi
        else
        echo "$file_directory_name does not exist"
        fi
}         
#Validate Move Files and Directories
validateMove () 
{
    while true; do
         read -p "Enter the File or Directory you want to move: " moveFilesAndDirectories
        [ -n "$moveFilesAndDirectories" ] && break || echo "$error"
    done
        if [ -e "$moveFilesAndDirectories" ]; then
            read -p "Enter the Destination path : " destination
            [ -e "$destination" ] && mv "$moveFilesAndDirectories" "$destination" echo "sucessfully move the $moveFilesAndDirectories to $destination" || echo "Destination path does not exist"
        else 
            echo "$moveFilesAndDirectories not exist" 
        fi
}
#Validate Permission
validateSetPermission ()
{
    while true; do
        read -p "Enter the name of the File or Directory for which you want to set permissions: "   setUserPermission
        [ -n "$setUserPermission" ] && break || echo $error
    done

        if [ -e "$setUserPermission" ]; then
        read -p "Enter permission (ex: 700): " setPermission
            if [ ! "$setPermission" -ge 778 ]; then
                chmod "$setPermission" "$setUserPermission"
                sleep 1
                listText #Function
            else 
                echo "Set permission denied"
            fi
        else 
        echo "directory does not exist"
        fi
}
#Delete Content
delete () 
{    
    until [ $option -eq 3 ]; do
        echo "[1] File"
        echo "[2] Folder"
        echo "[3] Zip File"
        echo "[4] Delete System"
        echo "[5] Back to Dashboard"
        read -p "Select the content you want to delete : " option

        case $option in
        1)
            listFiles
            read -p "Enter File you want to delete: " deleteFile

            [ -f "$deleteFile" ] &&  { rm $deleteFile; echo "File $deleteFile has been successfully deleted."; } ||
            echo "File doest not exist"
        ;;
        2)
        ;;
        3)
        ;;
        4)
            read -p "Are you sure want to delete the system? [Y]/[N]" : deleteSystem

            if [ "$deleteSystem" == "Y" ]; then
                rm -f home/adminriboluna/LinuxProject-STI-College-Caloocan/* 
                echo "Delete Successfully"
            fi
        ;;
        esac

    done
}