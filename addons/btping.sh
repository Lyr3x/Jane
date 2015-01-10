while :
    do
        phoneAtHome=`sudo l2ping -s 1 -c 1 9C:D9:17:20:89:72 >/dev/null 2>&1; echo $?` #Ping phone
        if [ "$phoneAtHome" = 0 ];
            then #Phone available
                echo true
            else #Phone not available
                echo false
        fi
        sleep 5s
   done
