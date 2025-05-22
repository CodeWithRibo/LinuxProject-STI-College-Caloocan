#!/bin/sh
#permission and cd  
option=0
non_existing_command

while [ $option -ne 5 ]; 
do 


echo "[1] Create a folder"
echo "[2] Create a file"
echo "[3] List Folder and File"
echo "[4] Delete a folder or file"
echo "[5] Exit"

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

        4)

              echo "Enter the content (file or folder) you want to delete:"
              read deleteContent

            if [[ "$deleteContent" == "file" ]]; then 

                echo "Enter file you want to delete : " 
                read deleteFile 

                rm $deleteFile
                echo "File $deleteFile has been sucessfully deleted." 
                
            elif [[ "$deleteContent" == "folder" ]]; then

                echo "Enter folder you want to delete : " 
                read deleteFolder

                rmdir $deleteFolder
                echo "Folder $deleteFolder has been sucessfully deleted." 
            
            else 
                echo "Invalid type: $deleteContent is not a valid option."

            fi

        ;;
        5) echo "Thank you!" ;;
        *) echo "Invalid Input. Please try again." ;;
    esac
done
