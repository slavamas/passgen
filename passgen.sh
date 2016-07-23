#!/bin/bash
#http://tldp.org/LDP/abs/html/contributed-scripts.html#PRIMES
#
#set -x
function usage() {
        echo "Usage: $0 <length of password> <char> "
	echo "second parameter is:"
	echo "		l - low case char" 
	echo "		u - upper case chars"
	echo "		n - numbers"
	echo "		s- special chars"
	echo "either altogether or in any combination"
    echo " "
	exit 0
}
Upperchars="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
Lowchars="abcdefghijklmnopqrstuvwxyz"
numbers="0123456789"
specialchars="!@#$%^&*()-_=+{}[]|~?><,~"
if [ $# -eq 2 ]; then
#        $@ = stores all the arguments in a list of string
#        $* = stores all the arguments as a single string
#        $# = stores the number of arguments
        secarg=$2
        for (( i=0; i<${#secarg}; i++ ))
        do
		case "${secarg:$i:1}" in
			"u")
                        MATRIX="$MATRIX $Upperchars"
                        ;;
                        "l")
                        MATRIX="$MATRIX $Lowchars"
                        ;;
                        "s")
                        MATRIX="$MATRIX $specialchars"
                        ;;
                        "n")
                        MATRIX="$MATRIX $numbers"
                        ;;
                        *)      
                        usage
			exit 1	#to fix problem with - line 61: 32021%0: division by 0 (error token is "0") 
                        ;;
                esac
        done
else    
        usage
fi
MATRIX=`echo -n $MATRIX | sed -e "s/ //g"`
LENGTH=$1
while [ "${n:=1}" -le "$LENGTH" ]
do
	if [ "$n" -eq 1 ]
	then
		letter="${MATRIX:$(($RANDOM%${#MATRIX})):1}"
	else
		newletter="${MATRIX:$(($RANDOM%${#MATRIX})):1}"
		while [ "$letter" == "$newletter" ]
		do	
			newletter="${MATRIX:$(($RANDOM%${#MATRIX})):1}"
			letter=$newletter
			break
		done
		letter="$newletter"
	fi
	let n+=1
	PASS="$PASS $letter"
	PASS=`echo -n $PASS | sed -e "s/ //g"`	
done
echo "$PASS"     
exit 0
