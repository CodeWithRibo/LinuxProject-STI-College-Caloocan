#!/bin/sh

echo "Enter 1st number:" 
read numOne

echo "Enter 2st number:" 
read numTwo

choose=0

while [ $choose -ne 5 ];  do 

echo "[1] Add"
echo "[2] Subtract"
echo "[3] Multiply"
echo "[4] Divide"
echo "[5] Exit"

echo "Select choice: "
read choose


case $choose in
1)
    let "totalSum = $numOne + $numTwo"
    echo "Your choice $choose and total is : $totalSum"
    ;;

2)
    let "totalDiff= $numOne - $numTwo"
    echo "Your choice $choose and total is : $totalDiff"
    ;;

3)
    let "totalProd= $numOne * $numTwo"
    echo "Your choice $choose and total is : $totalProd"
    ;;


4)

    if [ $numTwo == 0 ]; then 
            echo "You cannot divide by zero"
    
        else
            let "totalQuo= $numOne / $numTwo"
            let "mod = $numOne % $numTwo"
            echo "Your choice $choose and total is : $totalQuo"
        
        if [ $mod -ne 0 ]; then
            echo "Remainder : $mod"
        fi 

    fi
    ;;

5)
    echo "Program will now exit. Thank you."
    ;;

*)
    echo "Invalid Input. Please try again."
    ;;

esac
done

