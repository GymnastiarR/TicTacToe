papan(){
    echo "-------------"
    echo "| ${number[0]} | ${number[1]} | ${number[2]} |"
    echo "-------------"
    echo "| ${number[3]} | ${number[4]} | ${number[5]} |"
    echo "-------------"
    echo "| ${number[6]} | ${number[7]} | ${number[8]} |"
    echo "-------------"
}

check(){

    if [ ${number[$input - 1]} = "O" -o ${number[$input - 1]} = "X" ]
    then
        echo "Nomor yang anda masukkan sudah digunakan"
        return
    fi
    
    number[$input - 1]=$sign
    
    winnerCheck
    if [ $? -eq 1 ];
    then
        echo "Pemenangnya adalah $winner"
        return 1
    fi
    
    turn=`expr $turn + 1`
    
}

changeTurn(){
    temp=`expr $turn % 2`
    
    if [ $temp -eq 0 ]
    then
        echo "Giliran User Pertama : ${user[$temp]}"
        sign="O"
    else
        echo "Giliran User kedua : ${user[$temp]}"
        sign="X"
    fi
}

winnerCheck(){
    if [ ${number[0]} = ${number[1]} -a ${number[0]} = ${number[2]} ];
    then
        winner=${user[temp]}
        return 1
    elif [ ${number[0]} = ${number[3]} -a ${number[0]} = ${number[5]} ];
    then
        winner=${user[temp]}
        return 1
    elif [ ${number[2]} = ${number[5]} -a ${number[2]} = ${number[8]} ];
    then
        winner=${user[temp]}
        return 1
    elif [ ${number[3]} = ${number[4]} -a ${number[3]} = ${number[5]} ];
    then
        winner=${user[temp]}
        return 1
    elif [ ${number[6]} = ${number[7]} -a ${number[6]} = ${number[8]} ];
    then
        winner=${user[temp]}
        return 1
    fi
    
}

runGame(){
    number=("1" "2" "3" "4" "5" "6" "7" "8" "9")
    registerUser
    papan
    
    while [ true ]
    do
        changeTurn
        
        echo -n "Masukkan nomor pilihan : "
        
        read input
        
        clear
        
        check
        if [ $? -eq 1 ];
        then
            break
        fi
        
        papan
        
	echo -n "Klik enter to next"
        read temp
    done
    
    saveMenu
    clear
    menu
}

saveGame(){
    
    if [ -f history.txt ]
    then
        echo "Pemenangnya adalah $winner" >> history.txt
    else
        touch history.txt
        echo "Pemenangnya adalah $winner" >> history.txt
    fi
}

saveMenu(){
    echo "Apakah kamu ingin menyimpan riwayat permainan ? [y/n]"
    read isSave
    if [ $isSave = "y" ];
    then
        saveGame
        echo "Permianan berhasil disimpan"
        return
    fi
}

registerUser(){
    turn=0
    echo -n "Masukkan nama user 1 : "
    read user[0]
    echo -n "Masukkan nama user 2 : "
    read user[1]
    clear
}

displayHistory(){
    clear
    
    cat history.txt
    echo "Enter to continue"
    read freeze
    clear
    
    menu
}

menu(){
    echo "1. Mulai Permainan"
    echo "2. Lihat Score Permianan"
    echo "3. Keluar Permainan"
    echo -n "Pilih menu : "
    read pilih
    if [ $pilih -eq 1 ];
    then
        runGame
    elif [ $pilih -eq 2 ];
    then
        displayHistory
    elif [ $pilih -eq 3 ];
    then
        echo "Selamat Tinggal . . ."
    else
        clear
        echo "Masukkan tidak valid"
        menu
    fi
}

clear
menu
