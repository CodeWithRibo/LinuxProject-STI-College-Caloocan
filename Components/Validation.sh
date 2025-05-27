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
            if [ -e "$destination" ]; then
            mv "$moveFilesAndDirectories" "$destination"
            echo "sucessfully move the $moveFilesAndDirectories to $destination"
            else
            echo "Destination path does not exist"
            fi
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
                listText 
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
            if [ "$(ls *.txt)" ]; then
                read -p "Enter File you want to delete: " deleteFile
                if [ -f "$deleteFile" ]; then
                    { rm $deleteFile; echo "File $deleteFile has been successfully deleted."; }
                else
                   echo "File does not exist"
                fi
                else 
                errorMessageFile    
             fi

        ;;
        2)
            listDirectiories
             if [ "$(ls -A)" ]; then
                read -p "Enter folder you want to delete: " deleteFolder
                if [ -d "$deleteFolder" ]; then
                    { rm -rf $deleteFolder; echo "Folder $deleteFolder has been successfully deleted."; }
                else
                   echo "Folder does not exist"
                fi
                else 
                errorMessageFolder    
             fi

        ;;
        3)
            listZipFile
             if [ "$(ls *.zip)" ]; then
                read -p "Enter zip file you want to delete: " deleteZipFile
                if [ -f "$deleteZipFile" ]; then
                    { rm -rf $deleteZipFile; echo "Zip file $deleteZipFile has been successfully deleted."; }
                else
                   echo "Zip file does not exist"
                fi
                else 
                errorMessageZipFile  
             fi
        ;;
        4)
            read -p "Are you sure want to delete the system? [Y]/[N] :" deleteSystem
            if [ "$deleteSystem" == "Y" ]; then
                rm -rf /home/adminriboluna/LinuxProject-STI-College-Caloocan/* 
                echo "Delete Successfully"
            fi
        ;;
        5) clear; welcomeView; break;;
        esac

    done
}

#Take notes
validateTakeNotes () 
{
    listFiles 
    if [ "$(ls *.txt)" ]; then
        read -p "Enter file you want to take a note: " inputUser
        if [ -f $inputUser ]; then
            takeNotes
            else
            echo "$inputUser is not in the list file "
        fi
        else
        errorMessageFile
    fi
}

encrypt ()
{
        listFiles
        read -p "Enter the file name : " file_encrypt
        read -p "Enter Passwword to encrypt : " password
        openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 -in "$file_encrypt" -out "${file_encrypt}.enc" -k "$password"
        if [ "$password" ]; then
            echo "Your "$file_encrypt" has been successfully encrypted";
        fi
}

decrypt ()
{
        listDecryption
        read -p "Enter the file name : " file_decrypt
        read -p "Enter password to decrypt: " password
        openssl enc -aes-256-cbc -d -salt -pbkdf2 -iter 100000 -in "$file_decrypt" -out "${file_decrypt%.enc}" -k "$password" 2>/dev/null

        if [ $? -eq 0 ]; then
            rm -rf $file_decrypt
            echo "Your "$file_decrypt" has been successfully decrypted";
            else 
            rm -rf "${file_decrypt%.enc}"
            echo "Wrong password"
            fi
}