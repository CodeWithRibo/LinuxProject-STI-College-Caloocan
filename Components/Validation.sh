#!/bin/sh

error="Error: Invalid input. Please try again"
            
validateFolder () 
{
    while true; do
        read -p "Enter folder name: " folderName
        [ -n "$folderName" ] && break || echo "$error"
    done
    [ ! -d $folderName ] && echo "$(mkdir $folderName)Folder $folderName has been created " || echo "Folder already exists"  
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

                # if [ -e $file_directory_name ]; then
                # read -p "Enter New Name: " new_name
                # mv $file_directory_name $new_name
                # echo "You have sucessfully renamed $file_directory_name to $new_name"
                # else
                # echo "$file_directory_name does not exist"
                # fi
validateRename () 
{
    while true; do
        read -p "Enter File or Directory Name : " file_directory_name
        [ -n "$file_directory_name" ] && break || echo "$error"
    done

}                