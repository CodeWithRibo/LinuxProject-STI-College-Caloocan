#!/bin/sh
#permission and cd  
option=0

while [ $option -ne 5 ]; 
do 

echo "[1] Create a folder"
echo "[2] Create a file"
echo "[3] List Folder and File"
echo "[5] Delete a folder"
echo "[6] Delete a file"
echo "[7] Exit"

echo "Select an option:"
read option

    case $option in
        1)
            echo "Enter folder name:"
            read folderName
            
            if [ -d $folderName ]; then
                echo "Folder already exists"
            else 
                mkdir $folderName
                echo "Folder $folderName has been created."
                echo "Do you want to set a permission for that folder ? (Y/N) : "
                read permission
            fi

             if [[ $permission == "Y" || $permission == "y" ]]; then 
                echo "Enter permission (ex: 700):"
                read setPermission
                chmod $setPermission $folderName
                echo "Permission $setPermission has been set for folder $folderName"
            fi
        ;;
        
        2)
            echo "Enter file name:"
            read fileName

            if [ -f $fileName ]; then
                echo "File already exists"
            else 
                echo > $fileName
                echo "File $fileName has been created."
                echo "Do you want to set a permission for that folder ? (Y/N) : "
                read permission
            fi 

             if [[ $permission == "Y" || $permission == "y" ]]; then 
                echo "Enter permission (ex: 700):"
                read setPermission
                chmod $setPermission $fileName
                echo "Permission $setPermission has been set for file $fileName"
            fi
        ;;

        3)
                ls -l
        ;;
    esac
done

